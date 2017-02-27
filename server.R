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

fredr_key("0e510a57a0086df706ac9c8fb852b706")

shinyServer(function(input, output){
  
  # unemployment widget
  output$plot.unemp <- renderPlot("UNRATE" %>% fitModel %>% plotModel)
  output$unempSummary <- renderPrint(fitModel("UNRATE"))
  output$unempForecastTable <- renderDataTable({
    unemp.model <- fitModel("UNRATE")
    
    unemp.fcst <- forecast(unemp.model)
    unemp.fcst <- data.frame(unemp.fcst)
    
    unemp.fcst.dates <- row.names(unemp.fcst)
    
    unemp.fcst <- data.frame(sapply(unemp.fcst, function(x) round(x, 2)))
    unemp.fcst$Date <- unemp.fcst.dates
    
    datatable(head(unemp.fcst), rownames = FALSE)
  })
  
  # payroll employment widget
  output$plot.payemp <- renderPlot("PAYEMS" %>% fitModel %>% plotModel)
  output$payempSummary <- renderPrint(fitModel("PAYEMS"))
  output$payempForecastTable <- renderDataTable({
    payemp.model <- Arima(fredr_series(series_id = "PAYEMS"), order = c(1,1,1))
    
    payemp.fcst <- forecast(payemp.model)
    payemp.fcst <- data.frame(payemp.fcst)
    
    payemp.fcst.dates <- row.names(payemp.fcst)
    
    payemp.fcst <- data.frame(sapply(payemp.fcst, function(x) round(x)))
    payemp.fcst$Date <- payemp.fcst.dates
    
    datatable(head(payemp.fcst), rownames = FALSE)
  })
  
  # gdp widget
  output$plot.gdp <- renderPlot("A191RL1Q225SBEA" %>% fitModel %>% plotModel)
  output$gdpSummary <- renderPrint(fitModel("A191RL1Q225SBEA"))
  output$gdpForecastTable <- renderDataTable({
    gdp.model <- Arima(fredr_series(series_id = "A191RL1Q225SBEA"), order = c(1,1,1))
    
    gdp.fcst <- forecast(gdp.model)
    gdp.fcst <- data.frame(gdp.fcst)
    
    gdp.fcst.dates <- row.names(gdp.fcst)
    
    gdp.fcst <- data.frame(sapply(gdp.fcst, function(x) round(x, 2)))
    gdp.fcst$Date <- gdp.fcst.dates
    
    datatable(head(gdp.fcst), rownames = FALSE)
  })
  
  # cpi widget
  output$plot.cpi <- renderPlot("CPIAUCSL" %>% fitModel %>% plotModel)
  output$cpiSummary <- renderPrint(fitModel("CPIAUCSL"))
  output$cpiForecastTable <- renderDataTable({
    cpi.model <- Arima(fredr_series(series_id = "CPIAUCSL"), order = c(1,1,1))
    
    cpi.fcst <- forecast(cpi.model)
    cpi.fcst <- data.frame(cpi.fcst)
    
    cpi.fcst.dates <- row.names(cpi.fcst)
    
    cpi.fcst <- data.frame(sapply(cpi.fcst, function(x) round(x, 1)))
    cpi.fcst$Date <- cpi.fcst.dates
    
    datatable(head(cpi.fcst), rownames = FALSE)
  })
})