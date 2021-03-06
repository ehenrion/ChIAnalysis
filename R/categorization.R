#' Creates categories based on a numeric variable
#'
#' @param chia.obj A list containing the annotated ChIA-PET data, as returned by \code{\link{annotate_chia}}.
#' @param variable.name The name of the column to cut into categories.
#' @param breaks The limits to use while cutting into categories.
#' @return A data frame in which each column corresponds to a category. The data frame is as long as the
#' "Regions" element of chia.obj, and the values indicate wheter or not a region belongs to a category.
#' @export
categorize_by_breaks <- function(chia.obj, variable.name, breaks = NULL) {
  # Convert data into data frame
  chia.df <- chia.obj$Regions
 # Create the boolean matrix
  bool.matrix <- matrix(FALSE, nrow = nrow(chia.df), ncol = (length(breaks) - 1))
  for (i in 1:(length(breaks) - 1)) {
    low = breaks[i]
    high = breaks[i + 1]
    bool.matrix[,i] <- ((chia.df[,variable.name] >= low) & (chia.df[,variable.name] < high))
  }
  # Convert to data frame and add names
  bool.df <- as.data.frame(bool.matrix)
  colnames(bool.df) <- paste0("[", breaks[1:(length(breaks) - 1)], ",", breaks[2:length(breaks)], ")")
  
  res = bool.df
  return(lapply(res, which))
}

#' Creates categories based on the connectivity of the nodes
#'
#' @param chia.obj A list containing the annotated ChIA-PET data, as returned by \code{\link{annotate_chia}}.
#' @param breaks The limits to use while cutting into categories.
#' @return A data frame in which each column corresponds to a category. The data frame is as long as the
#' "Regions" element of chia.obj, and the values indicate wheter or not a region belongs to a category.
#' @export
categorize_by_connectivity <- function(chia.obj, breaks = c(1, 2, 6, 21, Inf)) {
  res = categorize_by_breaks(chia.obj, "Degree", breaks)
  return(res)
}

#' Creates categories based on the size of the components
#'
#' @param chia.obj A list containing the annotated ChIA-PET data, as returned by \code{\link{annotate_chia}}.
#' @param breaks The limits to use while cutting into categories.
#' @return A data frame in which each column corresponds to a category. The data frame is as long as the
#' "Regions" element of chia.obj, and the values indicate wheter or not a region belongs to a category.
#' @export
categorize_by_components_size <- function(chia.obj, breaks = c(2, 6, 11, 21, 41, Inf)) {
  res = categorize_by_breaks(chia.obj, "Component.size", breaks)
  return(res)
}

#' Creates categories based on the centrality of the nodes
#'
#' @param chia.obj A list containing the annotated ChIA-PET data, as returned by \code{\link{annotate_chia}}.
#' @return A data frame in which each column corresponds to a category. The data frame is as long as the
#' "Regions" element of chia.obj, and the values indicate wheter or not a region belongs to a category.
#' @importFrom stats aggregate
#' @export
categorize_by_centrality <- function(chia.obj){
  # Convert data into data frame
  chia.df <- chia.obj$Regions
  # The central, perpheral nodes, and all nodes, can already be identified
  centrality.df <- data.frame(Central.nodes = chia.df$Is.central,
                              Peripheral.nodes = !(chia.df$Is.central),
                              All.nodes = TRUE)
  # Find the most central node for each network
  central.info <- aggregate(Centrality.score~Component.Id, chia.df, max)
  # Associate the maximum score of each network to the corresponding nodes
  chia.df$max.centrality <- central.info$Centrality.score[match(chia.df$Component.Id, central.info$Component.Id)]
  # Add a boolean indicating if the regions are the most central of their component
  centrality.df$Most.central <- (chia.df$Centrality.score == chia.df$max.centrality) & chia.df$Is.central
  # Reorder the columns
  centrality.df <- centrality.df[,c(4,1,2,3)]
  
  res = centrality.df
  return(lapply(res, which))
}

#' Creates categories based on the component of each node.
#'
#' @param chia.obj A list containing the annotated ChIA-PET data, as returned by \code{\link{annotate_chia}}.
#' @return A data frame in which each column corresponds to a category. The data frame is as long as the
#' "Regions" element of chia.obj, and the values indicate wheter or not a region belongs to a category.
#' @export
categorize_by_component <- function(chia.obj) {
    stopifnot(has_components(chia.obj))
    
    all.components = sort(unique(chia.obj$Regions$Component.Id))
    indices.list = lapply(all.components, function(x) { chia.obj$Regions$Component.Id == x })
    indices.df = as.data.frame(indices.list)
    colnames(indices.df) <- all.components
    
    res = indices.df
    return(lapply(res, which))
}

#' Creates categories based on the presence of certain transcription factors.
#'
#' @param chia.obj A list containing the annotated ChIA-PET data, as returned by \code{\link{annotate_chia}}.
#' @param tf.names The transcription factors to be used for the categories. If NULL, all available TFs are used.
#' @param add.all IF TRUE, a category containing all nodes is added.
#'
#' @return A list containing a set of indices, one for each apssed TF combination, indicating which regions
#'   bind the given TFs.
#' @export
categorize_by_tf <- function(chia.obj, tf.names=NULL, add.all=FALSE) {
    # Initialize the result list.
    category.list = list()
    
    # Add a category with all nodes, if requested.
    if(add.all) {
        category.list[["All"]] = 1:number_of_nodes(chia.obj)
    }

    # If no TFs were provided, use all of them.
    if(is.null(tf.names)) {
        get_tf_names(chia.obj)
    }
    
    # For each TF or set of TF, compute a presence vector.
    for(tf.set in tf.names) {
        set.name = paste(tf.set, collapse=" & ")
        category.list[[set.name]] = which(nodes_with_tf(chia.obj, tf.set))
    }
    
    return(category.list)
}