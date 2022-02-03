#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(toastui)
library(DT)
library(tidyverse)

#load dataset
df <- readr::read_csv("exampledata.csv")

#formatting data
surveydata <- df[, -c(12:14)]
tabledata <- df[, -c(1, 4, 7, 8, 9, 10, 11)]

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    title = "University of Tennessee, Knoxville Survey Calendar",


        # Show a plot of the generated distribution
          column(8, offset = 2,
                 h3("University of Tennessee, Knoxville Survey Calendar", align = "center"),
                 calendarOutput("cal")
        ),
    fluidRow(
      column(4, align = "left",
             h4("Survey Administration Information", align = "center"),
             datagridOutput("surveytable", width = "900px", height = "auto"))
    )
)



# Define server logic required to draw a histogram
server <- function(input, output) {

    output$cal <- renderCalendar({
        calendar(data = surveydata, navigation = TRUE, useNavigation = TRUE,
                 navOpts = navigation_options(
                   fmt_date = "MMMM D YYYY",
                   sep_date = " - "
                 )) %>%
            cal_month_options(
                startDayOfWeek  = 1, 
                narrowWeekend = TRUE, 
                workweek = TRUE
            ) %>% 
            cal_props(cal_demo_props())
       
    })
    output$surveytable <- renderDatagrid({
      datagrid(tabledata, pagination = 10, colwidths = "guess")
    })
    
}



# Run the application 
shinyApp(ui = ui, server = server)

#ex_data <- cal_demo_data()
#calendar(ex_data)
