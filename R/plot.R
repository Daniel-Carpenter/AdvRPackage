#' @title       Plot Method for Rttest Objects
#' @description This function creates a generic method for Ploting Rttest objects. Uses ggplot2
#'
#' @param Rttest_obj An object of class Rttest.
#'
#' @return The result of the specific Plot method for the class of the input object.
#'
#' @export
#'
#' @seealso \code{\link{plot.Rttest}}


# Generic Plot method
plot <- function(Rttest_obj) {
  UseMethod("plot")
}
