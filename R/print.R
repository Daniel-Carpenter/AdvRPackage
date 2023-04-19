#' Print Method for Rttest Objects with Optional Rounding
#'
#' This function creates a generic method for printing Rttest objects. It allows for optional rounding
#' of the data values by specifying the number of digits to round to.
#'
#' @param Rttest_obj An object of class Rttest.
#' @param roundToDigits The number of decimal places to round the data values to (default: 3).
#'
#' @return The result of the specific print method for the class of the input object.
#' @export
#' @seealso \code{\link{print.Rttest}}

# Generic Print method
print <- function(Rttest_obj, roundToDigits = 3) {
  UseMethod("print")
}
