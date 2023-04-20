#' @title       Print Rttest Objects in a Readable Format
#' @description This function defines the print method for Rttest objects. It extracts the data from the object and
#' prints it in a readable format using the kable function from the knitr package.
#'
#' @param Rttest_obj An object of class Rttest.
#'
#' @param roundToDigits Number of digits to round the output to.
#'
#' @return 3 formatted tables displaying the 1 - alpha, confidence interval, and data from the Rttest object.
#'
#' @importFrom kableExtra kable
#' @importFrom stringr    str_flatten
#' @importFrom htmltools  HTML tagList
#'
#' @export
#' @examples
#' # Create a sample Rttest object
#' sample_data <- data.frame(a = 1:5, b = 6:10)
#' sample_Rttest_obj <- list(data = sample_data, class = "Rttest")
#'
#' # Print the sample Rttest object
#' print(sample_Rttest_obj)

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
