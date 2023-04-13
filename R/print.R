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
#' @examples
#' # Create a sample Rttest object
#' sample_data <- data.frame(a = c(1.12345, 2.54321), b = c(3.98765, 4.12345))
#' sample_Rttest_obj <- list(data = sample_data, class = "Rttest")
#'
#' # Print the sample Rttest object with default rounding (3 digits)
#' print(sample_Rttest_obj)
#'
#' # Print the sample Rttest object with custom rounding (2 digits)
#' print(sample_Rttest_obj, roundToDigits = 2)

# Generic Print method
print <- function(Rttest_obj, roundToDigits = 3) {
  UseMethod("print")
}
