#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(caret)
library(xgboost)

set.seed(1337)

data("Titanic")
TitanicDf = as.data.frame(Titanic)

TitanicDfObservations <- TitanicDf[rep(seq.int(1,nrow(TitanicDf)), TitanicDf$Freq),] %>% select(-Freq)
trainIndex <- createDataPartition(TitanicDfObservations$Survived, p = .8, list = FALSE)

TitanicTrain <- TitanicDfObservations[ trainIndex,]
TitanicTest <- TitanicDfObservations[ -trainIndex,]

if(!file.exists("./model.rds")){
    gbmFit <- train(Survived ~ ., data = TitanicTrain, method="xgbLinear")
    saveRDS(gbmFit, "./model.rds")
} else {
    gbmFit <- readRDS("./model.rds")
}

#gbmFit <- train(Survived ~ ., data = TitanicTrain, method="xgbLinear")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$titanicBarChart <- renderPlot({
      ggplot(TitanicDf, aes(x = TitanicDf[, input$xAxis], y = Freq, fill = Survived)) + 
          xlab(input$xAxis) +
          geom_bar(stat = "identity")
      })
  
  output$table <- renderTable({
      df <- data.frame(input$class, input$sex, input$age)
      colnames(df) <- c("Class", "Sex", "Age")
      
      test <- predict(gbmFit, newdata = df, type='prob')
  })
  
})
