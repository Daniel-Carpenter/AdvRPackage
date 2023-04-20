#' @title       Two-sample t-test function
#' @description Performs a two-sample t-test on x and y and returns the results as an object of class "Rttest"
#'
#' @param x      A numeric vector of data for group 1
#' @param y      A numeric vector of data for group 2
#' @param alpha  A numeric value specifying the level of significance (default is 0.05)
#' @param paired A logical indicating whether the samples are paired (default is FALSE)
#'
#' @return A list containing the results of the t-test, including the test type, summary statistics, null hypothesis rejection, and input data
#'
#' @importFrom stats t.test var.test
#' @importFrom dplyr case_when if_else
#'
#' @export myttest
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
#' obj <- myttest(x = x, y = y, alpha = 0.05)
#'
#' # Print object
#' print(obj)


# Create the constructor
myttest <- function(x, y, alpha = 0.05, paired = FALSE) {

  # Check if x and y are numeric vectors
  if (!is.numeric(x) || !is.numeric(y)) {
    stop("x and y must be numeric vectors.")
  }


  # Check the variances of x and y and determine which type of t-test to perform
  variancesAreNotEqual <- function(x, y, alpha) {

    # Check the variances of x and y using an F-test
    fTest <- var.test(x, y)

    # Return TRUE if the p-value is less than alpha, indicating unequal variances
    return(fTest$p.value < alpha)
  }

  # Perform a two-sample t-test on x and y
  performTTest <- function(x, y, alpha, paired) {

    # 0. Check if variances equal or not
    variancesNotEqual <- variancesAreNotEqual(x, y, alpha)

    # 1. Discover which t test to use

    ## 1.1 If paired in paraeters, then paired
    if (paired) {
      testType     <- 'Paired'
      tTestResults <- t.test(x, y, paired = TRUE)

      ## 1.2 Else If variances are not equal then use Welch's T-Test
    } else if (variancesNotEqual) {
      testType     <- 'Welch'
      tTestResults <- t.test(x, y, var.equal = FALSE)

      ## 1.3 Else variances are equal and not using a paired ttest, so use standard
    } else {
      testType     <- 'T-test'
      tTestResults <- t.test(x, y, var.equal = TRUE)
    }

    # Determine if the null hypothesis is rejected based on the p-value
    rejectNull <- if_else(tTestResults$p.value < alpha, "Y", "N")

    # Confidence interval and p value
    ci     = tTestResults[['conf.int']]
    pValue = tTestResults[['p.value']]

    # Return the test type (name), t-test output, and if we rejected the null
    return(list(ci           = ci,
                pValue       = pValue,
                testType     = testType,
                tTestResults = tTestResults,
                rejectNull   = rejectNull
    )
    )
  }

  # Call the performTTest function and store the results in testResult
  testResult <- performTTest(x, y, alpha, paired)

  # Create a results list of the test results and input data
  result <- list(
    data         = data.frame(x = x, y = y),
    alpha        = alpha,
    ci           = testResult$ci,
    pValue       = testResult$pValue,
    testType     = testResult$testType,
    summaryStats = testResult$tTestResults,
    rejectNull   = testResult$rejectNull
  )

  # Set the class of the result object to "Rttest"
  class(result) <- "Rttest"

  # Return the result object invisibly
  return(invisible(result))
}
