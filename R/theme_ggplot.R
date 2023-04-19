# Packages
library(ggplot2)

#' Function that returns a theme object for ggplot objects
#'
#' @return a theme via a list of geoms that can be added to ggplot2 objects
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
      ggplot2::theme_minimal(),

      # Alterations to the theme
      ggplot2::theme(

        # Increase text size
        text = ggplot2::element_text(size = 13,
                            color = 'grey30'),

        # Make the caption grey
        plot.caption = ggplot2::element_text(color = 'grey70'),

        # Remove x axis gridline
        panel.grid.major.x = ggplot2::element_blank(),
        panel.grid.minor.x = ggplot2::element_blank(),

        # Rearange the legend and remove the title
        legend.position = 'top',
        legend.title    = ggplot2::element_blank())
    )
  )
}
