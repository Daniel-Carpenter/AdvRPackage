## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "../man/figures/README-",
  out.width = "100%",
  echo    = TRUE, # Default only show output (not code)
  message = FALSE,
  warning = FALSE
)

## ----loadPackage--------------------------------------------------------------
library(AdvRPackage) # Seen at: https://github.com/Daniel-Carpenter/AdvRPackage

## -----------------------------------------------------------------------------
# Create sample data
set.seed(32); x = rnorm(30, mean = 10, sd = 15)
set.seed(35); y = rnorm(30, mean = 8, sd = 15)

# Run the T-Test function using this package and creating a Rttest object
ans1 = AdvRPackage::myttest(x, y, alpha = 0.05, paired = FALSE)

## -----------------------------------------------------------------------------
# Print Method 
print(ans1)

## -----------------------------------------------------------------------------
# Plot Method 
plot(ans1)

## -----------------------------------------------------------------------------
# Create sample data
set.seed(32); x = rnorm(30, mean = 10, sd = 5)
set.seed(35); y = rnorm(30, mean = 8, sd = 15)

# Run the T-Test function using this package and creating a Rttest object
ans2 = AdvRPackage::myttest(x, y, alpha = 0.05, paired = FALSE)

## -----------------------------------------------------------------------------
# Print Method 
print(ans2)

## -----------------------------------------------------------------------------
# Plot Method 
plot(ans2)

## -----------------------------------------------------------------------------
# Create sample data
set.seed(32); x = rnorm(30, mean = 10, sd = 15)
set.seed(35); y = x + rnorm(30, 5 , 4)

# Run the T-Test function using this package and creating a Rttest object
ans3 = AdvRPackage::myttest(x, y, alpha = 0.05, paired = TRUE)

## -----------------------------------------------------------------------------
# Print Method
print(ans3)

## -----------------------------------------------------------------------------
# Plot Method 
plot(ans3)

