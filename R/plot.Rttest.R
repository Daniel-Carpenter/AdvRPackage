# Packages
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)

#' Plot Method for Rttest Objects
#'
#' This function creates a generic method for Ploting Rttest objects. Uses ggplot2
#'
#' @param Rttest_obj An object of class Rttest.
#'
#' @return The result of the specific Plot method for the class of the input object.
#' @export
#' @seealso \code{\link{plot.Rttest}}
#' @examples
#'
#' # Create a sample Rttest object
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
#' # Plot the sample Rttest
#' plot(obj)

# Generic Plot method
plot.Rttest <- function(Rttest_obj) {

  # Return the plot of the two samples in the data
  df <- Rttest_obj$data |>

    # Make a difference of samples field
    dplyr::mutate(Difference_of_Samples = y - x) |>

    # Pivot the data so that we can color the data
    tidyr::pivot_longer(cols      = where(is.numeric), # pivot the sample values
                        names_to  = 'sampleNames',
                        values_to = 'sampleValues') |>

    # Clean up names for plots using factors
    dplyr::mutate(sampleNames = as.factor(stringr::str_replace_all(sampleNames, '_', ' ')) )



    # Create the plot ----------------------------------------------------------

    plot_boxplots <- df |>

      # Map variables to the plot
      ggplot2::ggplot(ggplot2::aes(x     = sampleNames,
                                   y     = sampleValues,
                                   color = sampleNames,
                                   fill  = sampleNames
                                   )
             ) +

      ggplot2::geom_hline(yintercept = 0,
                          linetype   = "longdash",
                          color      = "grey10",
                          linewidth  = 1/2,
                          alpha      = 1/3) +

      # Create the boxplots
      ggplot2::geom_boxplot(size  = 2/3,
                            alpha = 1/10) +

      # Change the colors and fill
      ggplot2::scale_fill_brewer(type       = 'qual',
                                 palette    = "Set1",
                                 direction  = -1,
                                 aesthetics = c("color", "fill")
                                 ) +

      # Labels on the plot
      ggplot2::labs(title   = 'Distribution of Samples used in the T-Test',
                    caption = '\nProduced with the `AdvRPackage` by Daniel Carpenter',
                    x       = '\nCategory',
                    y       = 'Samples\n'
      ) +

      # Using the package's ggplot2 theme seen in R/theme_ggplot.R
      AdvRPackage::theme_ggplot()



  return( plot_boxplots ) # Return the boxplot plot
}

# # X Variable
# set.seed(21)
# x <- rnorm(30,5,2)
#
# # Y Variable
# set.seed(23)
# y <- rnorm(30, 3,2)
#
# # Alpha level
# alpha <- 0.05
#
# # Call the contructor
# obj <- myttest(x = x, y = y, alpha = 0.05)
#
# # Plot the sample Rttest
# plot(obj)
