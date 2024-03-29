% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/print.Rttest.R
\name{print.Rttest}
\alias{print.Rttest}
\title{Print Rttest Objects in a Readable Format}
\usage{
\method{print}{Rttest}(Rttest_obj, roundToDigits = 3)
}
\arguments{
\item{Rttest_obj}{An object of class Rttest created with the myttest method.}

\item{roundToDigits}{Number of digits to round the output to.}
}
\value{
3 formatted tables displaying the 1 - alpha, confidence interval, and data from the Rttest object.
}
\description{
This function defines the print method for Rttest objects. It extracts the data from the object and
prints it in a readable format using the kable function from the knitr package.
}
\examples{
# X Variable
set.seed(21)
x <- rnorm(30,5,2)

# Y Variable
set.seed(23)
y <- rnorm(30, 3,2)

# Alpha level
alpha <- 0.05

# Call the contructor
Rttest_obj <- myttest(x = x, y = y, alpha = 0.05)

# Print the Rttest object
print(Rttest_obj)
}
\seealso{
\code{\link{myttest}}

\code{\link{plot.Rttest}}
}
