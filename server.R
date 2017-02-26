library(shiny)
library(shinydashboard)
library(forecast)
library(plotly)
library(fredr)


fredr_key("0e510a57a0086df706ac9c8fb852b706")
#gdp <- 
#payroll <- fredr_series(series_id = "PAYEMS")
#cpi <- fredr_series(series_id = "CPIAUCSL")

shinyServer(function(input, output){
  
  output$plot.unemp <- renderPlotly({
    unemp.model <- Arima(fredr_series(series_id = "UNRATE"), order = c(1,1,1))
    
    unemp.fcst <- forecast(unemp.model)
    
    ggplotly(autoplot(unemp.fcst) + ylab("Unemployment Rate") + 
               ggtitle(" ") + xlim(2012,2018))
  })
  
  output$modelSummary <- renderPrint({
    Arima(fredr_series(series_id = "UNRATE"), order = c(1,1,1))
  })
  
  
  output$plot.payemp <- renderPlotly({
    payemp.model <- Arima(diff(fredr_series(series_id = "PAYEMS")), order=c(1,1,1))
    
    payemp.fcst <- forecast(payemp.model)
    
    ggplotly(autoplot(payemp.fcst) + ylab("Payroll Employment") +
              ggtitle(" ") + xlim(2008, 2018))
  })
  
  output$payempSum <- renderPrint({
    Arima(diff(fredr_series(series_id = "PAYEMS")), order=c(1,1,1))
  })
  
  output$plot.gdp <- renderPlotly({
    gdp.model <- Arima(fredr_series(series_id = "A191RL1Q225SBEA"), order = c(2,1,1))
    
    gdp.fcst <- forecast(gdp.model)
    
    ggplotly(autoplot(gdp.fcst) + ylab("Real GDP Growth Rate") +
               ggtitle(" ") + xlim(2012, 2018))
  })
  
  
})