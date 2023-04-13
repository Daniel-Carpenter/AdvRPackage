# Packages
library(kableExtra) # printing df's


#' Print Rttest Objects in a Readable Format
#'
#' This function defines the print method for Rttest objects. It extracts the data from the object and
#' prints it in a readable format using the kable function from the knitr package.
#'
#' @param Rttest_obj An object of class Rttest.
#'
#' @param roundToDigits Number of digits to round the output to.
#'
#' @return A formatted table displaying the data from the Rttest object.
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

  # Return Data in Kable Format. Note rounding of digits for ease of viewing
  Rttest_obj$data |> kableExtra::kable(digits  = roundToDigits,
                           caption = paste("Rttest Printed Data. Note rounded to",
                                           roundToDigits, 'digits'),
  )
}
