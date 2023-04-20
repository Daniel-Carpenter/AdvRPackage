#' @title       Two-sample t-test function
#' @description Performs a two-sample t-test on x and y and returns the results as an object of class "Rttest"
#'
#' @param x A numeric vector of data for group 1
#' @param y A numeric vector of data for group 2
#' @param alpha A numeric value specifying the level of significance (default is 0.05)
#'
#' @return A list containing the results of the t-test, including the test type, summary statistics, null hypothesis rejection, and input data
#'
#' @importFrom stats t.test
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
myttest <- function(x, y, alpha = 0.05) {

  # Check if x and y are numeric vectors
  if (!is.numeric(x) || !is.numeric(y)) {
    stop("x and y must be numeric vectors.")
  }

  # Perform a two-sample t-test on x and y
  performTTest <- function(x, y, alpha) {

    # Assume that the variances in the population are the same (this will mean a simple no conditional function)
    tTestResults <- t.test(x, y, var.equal = TRUE)

    # Reteive Confidence interval and p value
    ci     = tTestResults[['conf.int']]
    pValue = tTestResults[['p.value']]

    # Return the test type (name), t-test output, and if we rejected the null
    return(list(ci           = ci,
                pValue       = pValue,
                tTestResults = tTestResults
    )
    )
  }

  # Call the performTTest function and store the results in testResult
  testResult <- performTTest(x, y, alpha)

  # Create a results list of the test results and input data
  result <- list(
    data         = data.frame(x = x, y = y),
    alpha        = alpha,
    ci           = testResult$ci,
    pValue       = testResult$pValue
  )

  # Set the class of the result object to "Rttest"
  class(result) <- "Rttest"

  # Return the result object invisibly
  return(invisible(result))
}
