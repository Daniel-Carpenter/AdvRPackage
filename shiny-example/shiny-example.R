# Libraries ----
library(shiny)
library(shinydashboard)
library(shinyjs)
library(tidyverse)
library(scales)
library(fresh) # For colors

library(AdvRPackage) # https://github.com/Daniel-Carpenter/AdvRPackage.git

# ===============================================================================
# Theme
# ===============================================================================

# source https://stackoverflow.com/questions/45016826/change-color-in-shinydashboard

# Create a theme
themeUI <- create_theme(

  # Use here: dashboardBody(use_theme(themeUI))

  # Top Ribbon
  adminlte_color(
    light_blue = "#2D343B",
  ),

  # Left Side bar
  adminlte_sidebar(
    width = "300px",
    dark_bg = "#3F4953"
    # dark_hover_bg = "#3F4953",
    # dark_color = "#3F4953"
  ),

  # Page Background
  adminlte_global(
    content_bg = "#FAFAFA", # Page Background
    # box_bg = "#F2A896",
    # info_box_bg = "#F2A896"
  )
)

# ===============================================================================
# UI
# ===============================================================================

ui <- dashboardPage(


  #### Header ----
  dashboardHeader(
    title = "AdvRPackage Dashboard",
    titleWidth = 350
  ),

  #### Sidebar ----
  dashboardSidebar(
    width = 350,
    br(),
    h4("Inputs for T-Test", style = "padding-left:20px"),

    # Input Length of Data
    numericInput("inputLengthOfData", "Number of Observations in Data:", value = 25, step = 25, min = 0),

    # Input Mean x
    numericInput("inputMean_x", "Mean of x:", value = 10, step = 5),

    # Input SD x
    numericInput("inputSD_x", "Standard Deviation of x:", value = 15, step = 5, min = 0),

    # Input Mean y
    numericInput("inputMean_y", "Mean of y:", value = 8, step = 5),

    # Input SD y
    numericInput("inputSD_y", "Standard Deviation of y:", value = 15, step = 5, min = 0),

    # Input Paired
    checkboxInput("inputPaired", "Use Paired T-Test?", value = FALSE),

    # Input Alpha
    numericInput("inputAlpha", "Alpha:", value = 0.05, step = 0.01, max = 0.1, min = 0.01),

    # Input Seed
    numericInput("inputSeed", "Seed for Random Data Creation:", value = 2023, step = 5)

    # # Refresh button - uncomment if wanted
    # actionButton("resfreshPlot", "Refresh Output")
  ),

  #### Body ----
  dashboardBody(
    use_theme(themeUI),
    fluidRow(
      column(width = 12, plotOutput("tTestPlot")),
      column(width = 12, htmlOutput("tTestPrint"))
    )
  )
)

# ===============================================================================
# Server
# ===============================================================================

server <- function(input, output) {

  # Process the t-test result
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

    AdvRPackage::myttest(x, y, alpha = input$inputAlpha, paired = input$inputPaired)
  })

  # Create the plot
  output$tTestPlot <- renderPlot({
    req(tTestResult()) # Ensure the plot is only refreshed when tTestResult is available
    plot(tTestResult())
  })

  # Create the printed output
  output$tTestPrint <- renderText({
    req(tTestResult()) # Ensure the print is only refreshed when tTestResult is available
    paste0(br(),'Printed Data', br(), print(tTestResult()))
  })
}


shinyApp(ui, server) # run the shiny server
