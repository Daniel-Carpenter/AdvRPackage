#' @title       Print Rttest Objects in a Readable Format
#' @description This function defines the print method for Rttest objects. It extracts the data from the object and
#' prints it in a readable format using the kable function from the knitr package.
#'
#' @param Rttest_obj An object of class Rttest created with the myttest method.
#' @param roundToDigits Number of digits to round the output to.
#'
#' @return 3 formatted tables displaying the 1 - alpha, confidence interval, and data from the Rttest object.
#'
#' @importFrom kableExtra kable
#' @importFrom stringr    str_flatten
#' @importFrom htmltools  HTML tagList
#'
#' @export
#'
#' @seealso \code{\link{myttest}}
#' @seealso \code{\link{plot.Rttest}}
#'
#' @examples
#' # X Variable
#' set.seed(21)
#' x <- rnorm(30,5,2)
#'
#' # Y Variable
#' set.seed(23)
#' y <- rnorm(30, 3,2)
#'
#' # Alpha level
#' alpha <- 0.05
#'
#' # Call the contructor
#' Rttest_obj <- myttest(x = x, y = y, alpha = 0.05)
#'
#' # Print the Rttest object
#' print(Rttest_obj)


# Define the print method when calling print(~Rttest objects~)
print.Rttest <- function(Rttest_obj, roundToDigits = 3) {

  #  1 - alpha
  alpha = HTML(data.frame(Alpha = (1 - Rttest_obj$alpha) * 100) |> kable(digits = roundToDigits))

  # confidence interval
  ci = HTML(data.frame(Confidence_Interval = Rttest_obj$ci) |> kable(digits = roundToDigits))

  # Data
  data = HTML(Rttest_obj$data |> kable(digits = roundToDigits,
                                       caption = "Rttest Data"))

  # Combine all HTML outputs
  htmlOutput <- tagList(alpha, ci, data)

  return(htmlOutput)
}
