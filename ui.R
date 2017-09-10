#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

#
# ID: Twitter API
# Search for Hashtag, visualise geographically using Leaflet?

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Survival of passengers on the Titanic"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        radioButtons("xAxis", h3("Graph"),
                    choices = list("Class" = "Class", "Sex" = "Sex",
                                   "Age" = "Age"), selected = "Class"),
        p(""),
        h3("Predict Survival"),
        radioButtons("class", h4("Class"),
                     choices = list("1st" = "1st", "2nd" = "2nd",
                                    "3rd" = "3rd", "Crew" = "Crew"), selected = "1st"),
        radioButtons("sex", h4("Sex"),
                    choices = list("Male" = "Male", "Female" = "Female"), selected = "Male"),
        radioButtons("age", h4("Age"),
                    choices = list("Adult" = "Adult", "Child" = "Child"), selected = "Adult")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        h3('Survival by Dimension'),
        p("See the actual survivals broken down by dimension"),
        plotOutput("titanicBarChart"),
        h3('Likelihood of survival'),
        p("Predicted likelihood of survival based on chosen class, sex and age."),
        tableOutput('table')
    )
  )
))