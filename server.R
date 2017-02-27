library(shiny)
library(shinydashboard)
library(forecast)
library(plotly)
library(fredr)
library(DT)

fitModel <- function(seriesID){
  if(seriesID == "UNRATE"){
    Arima(fredr_series(series_id = "UNRATE"), order = c(1,1,1))
  } else if(seriesID == "PAYEMS"){
    Arima(fredr_series(series_id = "PAYEMS"), order=c(1,1,1))
  } else if(seriesID == "A191RL1Q225SBEA"){
    Arima(fredr_series(series_id = "A191RL1Q225SBEA"), order = c(2,1,1))
  } else if(seriesID == "CPIAUCSL"){
    Arima(fredr_series(series_id = "CPIAUCSL"), order = c(2,1,1))
  }
}
plotModel <- function(model){
  
  fcst <- forecast(model)
  
  # assumes object is forecast model
  if(grepl("PAYEMS", model$series)){
    
    autoplot(fcst) + ylab("Payroll Employment") +
      ggtitle(" ") + xlim(1990, 2018) + ylim(105000, 155000)
    
  } else if(grepl("A191RL1Q225SBEA", model$series)){
    
    autoplot(fcst) + ylab("Real GDP Growth Rate") +
      ggtitle(" ") + xlim(1990, 2018)
    
  } else if(grepl("CPIAUCSL", model$series)){

    autoplot(fcst) + ylab("CPI Growth Rate") +
      ggtitle(" ") + xlim(1990, 2018) + ylim(125, 250)
  } else if(grepl("UNRATE", model$series)){
    autoplot(fcst) + ylab("Unemployment Rate") + ggtitle(" ")
  }
}
forecastTable <- function(model){
  fcst <- forecast(model)
  
  # assumes object is forecast model
  if(grepl("UNRATE", model$series) |
     grepl("A191RL1Q225SBEA", model$series)){
    
    fcst <- data.frame(fcst)
    
    fcst.dates <- row.names(fcst)
    
    fcst <- data.frame(sapply(fcst, function(x) round(x, 2)))
    fcst$Date <- fcst.dates
    
    datatable(head(fcst), rownames = FALSE)
    
  } else if(grepl("CPIAUCSL", model$series)){
    
    fcst <- data.frame(fcst)
    
    fcst.dates <- row.names(fcst)
    
    fcst <- data.frame(sapply(fcst, function(x) round(x, 1)))
    fcst$Date <- fcst.dates
    
    datatable(head(fcst), rownames = FALSE)
    
  }  else if(grepl("PAYEMS", model$series)){
    fcst <- data.frame(fcst)
    
    fcst.dates <- row.names(fcst)
    
    fcst <- data.frame(sapply(fcst, function(x) round(x)))
    fcst$Date <- fcst.dates
    
    datatable(head(fcst), rownames = FALSE)
  }
}

fredr_key("0e510a57a0086df706ac9c8fb852b706")

shinyServer(function(input, output){
  # unemployment widget
  output$plot.unemp <- renderPlot("UNRATE" %>% fitModel %>% plotModel)
  output$unempSummary <- renderPrint("UNRATE" %>% fitModel)
  output$unempForecastTable <- renderDataTable("UNRATE" %>% fitModel %>% forecastTable)
  # payroll employment widget
  output$plot.payemp <- renderPlot("PAYEMS" %>% fitModel %>% plotModel)
  output$payempSummary <- renderPrint(fitModel("PAYEMS"))
  output$payempForecastTable <- renderDataTable("PAYEMS" %>% fitModel %>% forecastTable)
  # gdp widget
  output$plot.gdp <- renderPlot("A191RL1Q225SBEA" %>% fitModel %>% plotModel)
  output$gdpSummary <- renderPrint("A191RL1Q225SBEA" %>% fitModel)
  output$gdpForecastTable <- renderDataTable("A191RL1Q225SBEA"%>%fitModel%>%forecastTable)
  # cpi widget
  output$plot.cpi <- renderPlot("CPIAUCSL" %>% fitModel %>% plotModel)
  output$cpiSummary <- renderPrint("CPIAUCSL" %>% fitModel)
  output$cpiForecastTable <- renderDataTable("CPIAUCSL" %>% fitModel %>% forecastTable)
})