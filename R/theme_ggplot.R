#' @title       Function that returns a theme object for ggplot objects
#' @description Creates a custom theme for reuse in this package
#'
#' @return a theme via a list of geoms that can be added to ggplot2 objects
#'
#' @importFrom ggplot2 theme_minimal theme element_text element_blank
#'
#' @export
#'
#' @examples
#'
#' library(ggplot2)
#'
#' mtcars |>
#'   ggplot(aes(x=wt, y=mpg)) + geom_point() +
#'   theme_ggplot()


# Create the theme function for the AdvRPackage
theme_ggplot <- function() {

  # Return a list that can be added to ggplot2 objects
  return(
    list(
      # Base minimal theme
      theme_minimal(),

      # Alterations to the theme
      theme(

        # Increase text size
        text = element_text(size = 13,
                            color = 'grey30'),

        # Make the caption grey
        plot.caption = element_text(color = 'grey70'),

        # Remove x axis gridline
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),

        # Rearange the legend and remove the title
        legend.position = 'top',
        legend.title    = element_blank())
    )
  )
}
