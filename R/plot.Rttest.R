#' @title       Plot Method for Rttest Objects
#' @description This function creates a generic method for Ploting Rttest objects. Uses ggplot2
#'
#' @param Rttest_obj An object of class Rttest.
#'
#' @return The result of the specific Plot method for the class of the input object.
#'
#' @importFrom dplyr   mutate filter
#' @importFrom tidyr   pivot_longer
#' @importFrom stringr str_replace_all str_detect
#' @importFrom ggplot2 ggplot aes geom_hline geom_boxplot scale_fill_brewer labs ggtitle theme element_blank annotate
#' @importFrom purrr   map map2
#' @importFrom stats   t.test
#'
#' @export
#'
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


# Plot method for Rttest objects, using the plot method
plot.Rttest <- function(Rttest_obj) {

  # Make references of data for ease of viewing
  testTypeIsPaired = Rttest_obj$testType == 'Paired' # Flag if using a paired sample

  # Inititalize List for the output plots
  outputPlots = list()

  # Data from Rttest obj
  df <- Rttest_obj$data |>

    # Differences of samples
    mutate(Difference_of_Samples = y - x) |>

    # Pivot the data so that we can color the data
    pivot_longer(cols      = where(is.numeric), # pivot the sample values
                 names_to  = 'sampleNames',
                 values_to = 'sampleValues') |>

    # Clean up names for plots using factors
    mutate(sampleNames = as.factor(str_replace_all(sampleNames, '_', ' ')) )



  # Function to add shared layers to a plot ------------------------------------

  getMapping <- function() {
    aes(x     = sampleNames,
        y     = sampleValues,
        color = sampleNames,
        fill  = sampleNames
    )
  }

  addSharedLayers <- function(..., thePalette = 'Set1') {

    # Return a list of the layers of a ggplot
    return(
      list(

        # Create the boxplots
        geom_boxplot(size  = 2/3,
                     alpha = 1/10
                     ),

          # Change the colors and fill
          scale_fill_brewer(type       = 'qual',
                            palette    = thePalette,
                            direction  = -1,
                            aesthetics = c("color", "fill")
          ),

          # Labels on the plot
          labs(title   = paste0(..., '\nTest Type: ', Rttest_obj$testType),
               caption = '\nProduced with the `AdvRPackage` Package by Daniel Carpenter',
               x       = '\nCategory',
               y       = 'Samples\n'
          ),

          # Using the package's ggplot2 theme seen in R/theme_ggplot.R
          theme_ggplot()
      )
    )
  }


  # Create the  non-paried plot ------------------------------------------------

  plot_dist <- df |>

    # Do NOT include differences data
    filter( !str_detect(df$sampleNames, 'Difference') ) |>

    # Map variables to the plot
    ggplot(mapping = getMapping() ) +

    # Get shared layers for better OOP approach
    map('Differences of Sample Distributions in the T-Test', addSharedLayers)

  # add boxplot of sample distributions
  outputPlots[['boxplots_distributions']] = plot_dist



  # Create the paired differences plot -----------------------------------------

  if (testTypeIsPaired) {


    df_diff <- df |>

      # ONLY include differences data
      filter( str_detect(df$sampleNames, 'Difference') )



    ## Confidence interval data ------------------------------------------------

    ### Bounds for labeling
    bounds = paste(c('Lower', 'Upper'),  'CI:')

    ### CI of differences data
    ci_diff = t.test(df_diff$sampleValues)[['conf.int']]


    ### Function to label ONE of the confidence intervals
    getCIText <- function(minOrMaxBound, boundName) {

        # Label for the confidence interval
        annotate('text',
                 y     = minOrMaxBound,
                 x     = unique(df_diff$sampleNames),
                 label = paste( boundName, round(minOrMaxBound, 2) ),
                 color = 'grey40',
                 size  = 3.5)
    }



    ## Create the plot ---------------------------------------------------------

    plot_diff <- df_diff |>

      # Map variables to the plot
      ggplot(mapping = getMapping() ) +

      # Create a horizontal line showing zero for the differences in samples plot
      geom_hline(yintercept = 0,
                 linetype   = "longdash",
                 color      = "grey10",
                 linewidth  = 3/4,
                 alpha      = 1/3) +

      # Get shared layers for better OOP approach
      addSharedLayers('Distribution of Samples used in the T-Test',
                      thePalette = 'Set2') +

      # Add labels for the confidence intervals using purrr
      map2( .x = ci_diff, .y = bounds, .f = getCIText) +

      # Do not show a legend now
      theme(legend.position = 'none',
            axis.title.x = element_blank())


    # add boxplot of sample differences
    outputPlots[['boxplots_differences']] = plot_diff
  }

  return( outputPlots ) # Return a list of plots
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
# obj <- myttest(x = x, y = y, alpha = 0.05, paired = T)
#
# # Plot the sample Rttest
# print(obj)
