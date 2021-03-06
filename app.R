library(shiny)
library(DT)

data <- read.csv('http://w0lxpintdata02.worldbank.org:443/content/91/data.csv')

ui <- fluidPage(
    titlePanel("Basic Data Filter Application"),
    hr(),
    h4("This application presents data generated by a scheduled R Markdown process: ", tags$a(href="http://w0lxpintdata02.worldbank.org:443/content/91", "See it here!")),
    p("Use this framework to build out your own R Markdown-based ETL jobs hosted on RStudio Connect."),
    br(),
    
    fluidRow(
        column(4,
               selectInput("a",
                           "Attribute A:",
                           c("All","Positive Values","Negative Values"))
        ),
        column(4,
               selectInput("b",
                           "Attribute B:",
                           c("All","Positive Values","Negative Values"))
        ),
        column(4,
               selectInput("c",
                           "Attribute C:",
                           c("All","Positive Values","Negative Values"))
        )
    ),

    dataTableOutput("table")
)

server <- function(input, output) {

    # Filter data based on selections
    output$table <- renderDataTable(DT::datatable({
        if (input$a != "All") {
            if (input$a == "Positive Values") {
                data <- data[data$a >= 0,]
            } else data <- data[data$a < 0,]
        }
        if (input$b != "All") {
            if (input$b == "Positive Values") {
                data <- data[data$b >= 0,]
            } else data <- data[data$b < 0,]
        }
        if (input$c != "All") {
            if (input$c == "Positive Values") {
                data <- data[data$c >= 0,]
            } else data <- data[data$c < 0,]
        }
        data
    }))
}

# Run the application 
shinyApp(ui = ui, server = server)