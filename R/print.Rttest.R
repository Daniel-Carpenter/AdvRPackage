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
#' @importFrom htmltools  HTML tagList br
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

  # Return a HTML tag list for HTML output
  return(
    tagList(

      # Test type name
      HTML(data.frame(Test_Type = Rttest_obj$testType) |> kable()), br(),

      #  1 - alpha
      HTML(data.frame(Confidence_Level = paste0((1 - Rttest_obj$alpha) * 100, '%') ) |> kable()), br(),

      # confidence interval
      HTML(data.frame(Confidence_Interval = Rttest_obj$ci) |> kable(digits = roundToDigits)), br(),

      # P value
      HTML(data.frame(P_Value = Rttest_obj$pValue) |> kable(digits = roundToDigits + 3)), br(),

      # Reject null hypothesis?
      HTML(data.frame(Reject_Null = Rttest_obj$rejectNull) |> kable()), br(),

      # Data
      HTML(Rttest_obj$data |> kable(digits = roundToDigits,
                                    caption = "Rttest Data"))
    )
  )
}
