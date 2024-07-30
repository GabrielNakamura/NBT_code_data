#' Auxiliar function to scale back standardized variables
#'
#' @param data data frame. An object from ggpredict
#' @param scaled data frame. An object from scale
#'
#' @return a new data frame with the variable x_original that corresponds
#'     to the standardized variable scaled back
#' @export
#'
#' @examples
scale_back <- 
  function(data, scaled){
    data2 <- data.frame(data)
    res <- 
      data2 |> 
      mutate(x_original = as.matrix(x) * attr(scaled, 'scaled:scale') + 
               attr(scaled, 'scaled:center'))
    return(res)
  }