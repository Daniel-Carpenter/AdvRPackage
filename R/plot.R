#' @title       Plot Method for Rttest Objects
#' @description This function creates a generic method for Ploting Rttest objects. Uses ggplot2
#'
#' @param Rttest_obj An object of class Rttest created with the myttest method.
#'
#' @return The result of the specific Plot method for the class of the input object.
#'
#' @export plot
#'
#' @seealso \code{\link{plot.Rttest}}
#' @seealso \code{\link{myttest}}


# Generic Plot method
plot <- function(Rttest_obj) {
  UseMethod("plot")
}
