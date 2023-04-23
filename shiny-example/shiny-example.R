# Libraries ----
library(shiny)
library(shinyWidgets) # Helpful for coloring action sliders
library(shinydashboard)
library(shinyjs)
library(tidyverse)
library(scales)
library(fresh) # For colors
library(gridExtra) # arranging plots

library(AdvRPackage) # https://github.com/Daniel-Carpenter/AdvRPackage.git



# ===============================================================================
# Default Inputs
# ===============================================================================

# Set default values for inputs
default_inputLengthOfData <- 250
default_inputMean_x       <- 10
default_inputSD_x         <- 15
default_inputMean_y       <- 20
default_inputSD_y         <- 15
default_inputPaired       <- FALSE
default_inputAlpha        <- 0.05
default_inputSeed         <- 2023

# Titles in body
header1Title = "T-Test Box Plots"
header2Title = "Printed Data from Rttest Object"

# Titles outside of body
mainTitle         = "AdvRPackage Dashboard"
inputsHeaderTitle = "Inputs for T-Test Data and Analysis"



# ===============================================================================
# Theme
# ===============================================================================

# source https://stackoverflow.com/questions/45016826/change-color-in-shinydashboard

# Reusable colors
lightBlueColor  = '#BECDE0'
ribbonColor     = '#2D343B'
sideBarColor    = '#3F4953'
backgroundColor = '#FAFAFA'
textColor       = '#444444'

# HMTL tag colors
textColorTag = paste0("color:", textColor, ';')
headerFont   = paste0('font-weight: bold;', textColorTag)

# Create a theme
# Use here: dashboardBody(use_theme(themeUI))
themeUI <- create_theme(

  # Top Ribbon
  adminlte_color(
    light_blue = ribbonColor,
  ),

  # Left Side bar
  adminlte_sidebar(
    width = "300px",
    dark_bg = sideBarColor
    # dark_hover_bg = "#3F4953",
    # dark_color = "#3F4953"
  ),

  # Page Background
  adminlte_global(
    content_bg = backgroundColor, # Page Background
    # box_bg = "#F2A896",
    # info_box_bg = "#F2A896"
  )
)



# ===============================================================================
# UI
# ===============================================================================

ui <- dashboardPage(


  #### Header ------------------------------------------------------------------
  dashboardHeader(
    title = "AdvRPackage Dashboard",
    titleWidth = 350
  ),

  #### Sidebar -----------------------------------------------------------------
  dashboardSidebar(
    width = 350,
    br(),
    h4(inputsHeaderTitle, style = "padding-left:20px"),

    # Input Length of Data
    setSliderColor(lightBlueColor, sliderId = 1),
    sliderInput("inputLengthOfData", "Number of Observations in Data:",
                min = 50, max = 500, value = default_inputLengthOfData, step = 50,
                width     = "100%", # Set slider width to 100%
                round     = TRUE, # Round slider values to integer
                dragRange = TRUE, # Allow to drag slider range
                ticks     = FALSE # Show ticks
    ),

    # Input Mean x
    numericInput("inputMean_x", "Mean of x:", value = default_inputMean_x, step = 5),

    # Input SD x
    numericInput("inputSD_x", "Standard Deviation of x:", value = default_inputSD_x, step = 5, min = 0),

    # Input Mean y
    numericInput("inputMean_y", "Mean of y:", value = default_inputMean_y, step = 5),

    # Input SD y
    numericInput("inputSD_y", "Standard Deviation of y:", value = default_inputSD_y, step = 5, min = 0),

    # Input Paired
    checkboxInput("inputPaired", "Use Paired T-Test?", value = default_inputPaired),

    # Input Alpha
    selectInput("inputAlpha", "Set Alpha for Confidence Level:",
                choices = c(0.01, 0.05, 0.10), selected = default_inputAlpha,
                width = "100%"
    ),

    # Input Seed
    numericInput("inputSeed", "Set Seed for Random Data Creation:", value = default_inputSeed),

    # Add reset button
    actionButton("resetBtn", "Reset Inputs", icon = icon("undo"))
  ),


  #### Body --------------------------------------------------------------------
  dashboardBody(
    use_theme(themeUI),
    fluidRow(
      # Dynamic objects
      column(width = 12, tags$h4(header1Title, style = headerFont)), # Static Header
      column(width = 12, plotOutput("tTestPlot")),  # T-Test plot
      column(width = 12, htmlOutput("tTestPrint"))  # Printed Rttest object
    )
  )
)



# ===============================================================================
# Server
# ===============================================================================

server <- function(input, output, session) {

  # Process the t-test result on each click ------------------------------------
  tTestResult <- reactive({

    # Set the seed
    set.seed(input$inputSeed)

    # Create the data
    x <- rnorm(input$inputLengthOfData, mean = input$inputMean_x, sd = input$inputSD_x)
    y <- rnorm(input$inputLengthOfData, mean = input$inputMean_y, sd = input$inputSD_y)

    # If paired then create a paired dataset for y
    if (input$inputPaired) {
      y = x + y
    }

    # Ensure the alpha input to numeric - this happens with the selectInput
    alpha_numeric <- as.numeric(input$inputAlpha)

    # Run the T-Test
    AdvRPackage::myttest(x, y, alpha = alpha_numeric, paired = input$inputPaired)
  })


  # Create the plot ------------------------------------------------------------
  output$tTestPlot <- renderPlot({
    req(tTestResult()) # Ensure the plot is only refreshed when tTestResult is available

    # Get the plots
    tTestPlots <- plot(tTestResult())

    boxplots_distributions <- tTestPlots$boxplots_distributions # Distribution plot always available

    # if paired then show the differences too
    if ("boxplots_differences" %in% names(tTestPlots)) {
      boxplots_differences <- tTestPlots$boxplots_differences
      grid.arrange(boxplots_distributions, boxplots_differences, ncol = 2)
    } else {
      boxplots_distributions # when not paired only show the distributions
    }
  })


  # Create the printed output --------------------------------------------------
  output$tTestPrint <- renderText({
    req(tTestResult()) # Ensure the print is only refreshed when tTestResult is available

    # Header and printed data
    paste0(br(),
           tags$h4(header2Title, style = headerFont),
           tags$span(style = textColorTag, print(tTestResult())) )
    })


  # Reset button - this will put everything back to its default value ----------
  observeEvent(input$resetBtn, {
    updateNumericInput(session, "inputLengthOfData", value = default_inputLengthOfData)
    updateNumericInput(session, "inputMean_x",       value = default_inputMean_x)
    updateNumericInput(session, "inputSD_x",         value = default_inputSD_x)
    updateNumericInput(session, "inputMean_y",       value = default_inputMean_y)
    updateNumericInput(session, "inputSD_y",         value = default_inputSD_y)
    updateCheckboxInput(session, "inputPaired",      value = default_inputPaired)
    updateNumericInput(session, "inputAlpha",        value = default_inputAlpha)
    updateNumericInput(session, "inputSeed",         value = default_inputSeed)
  })
}



# ==============================================================================
# Run App
# ==============================================================================

shinyApp(ui, server) # run the shiny server
