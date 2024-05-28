# load packages and scripts ----------------

library(shiny)
library(gargle)
library(googledrive)

source("drug_detection_gdrive.R")


# code for the application -----------------

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Drug groups for choking hazard"),

    # Sidebar with a text input
    sidebarLayout(
        sidebarPanel(
          textInput("drugs", 
                    "Drugs separated by commas", 
                    value = "", 
                    width = NULL, 
                    placeholder = NULL)
          
        ),

        # Show a plot of the generated distribution
        mainPanel(
           tableOutput("table")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  indata <- reactive({
    indrugs <- input$drugs
  })
  
  output$table <- renderTable({
    nd <- indata()
    group_drugs(nd)
    dname
  })
  }

# Run the application 
shinyApp(ui = ui, server = server)
