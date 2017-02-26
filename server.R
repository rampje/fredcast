library(shiny)
library(shinydashboard)
library(forecast)
library(plotly)
library(fredr)
library(DT)


fredr_key("0e510a57a0086df706ac9c8fb852b706")
#gdp <- 
#payroll <- fredr_series(series_id = "PAYEMS")
#cpi <- fredr_series(series_id = "CPIAUCSL")

shinyServer(function(input, output){
  
  
  
  output$plot.unemp <- renderPlot({
    unemp.model <- Arima(fredr_series(series_id = "UNRATE"), order = c(1,1,1))
    
    unemp.fcst <- forecast(unemp.model)
    
    autoplot(unemp.fcst) + ylab("Unemployment Rate") + ggtitle(" ")
  })
  
  output$unempSummary <- renderPrint({
    Arima(fredr_series(series_id = "UNRATE"), order = c(1,1,1))
  })
  
  output$unempForecastTable <- renderDataTable({
    unemp.model <- Arima(fredr_series(series_id = "UNRATE"), order = c(1,1,1))
    
    unemp.fcst <- forecast(unemp.model)
    unemp.fcst <- data.frame(unemp.fcst)
    
    unemp.fcst.dates <- row.names(unemp.fcst)
    
    unemp.fcst <- data.frame(sapply(unemp.fcst, function(x) round(x, 2)))
    unemp.fcst$Date <- unemp.fcst.dates
    
    datatable(head(unemp.fcst), rownames = FALSE)
  })
  
  
  output$plot.payemp <- renderPlot({
    payemp.model <- Arima(fredr_series(series_id = "PAYEMS"), order=c(1,1,1))
    
    payemp.fcst <- forecast(payemp.model)
    
    autoplot(payemp.fcst) + ylab("Payroll Employment") +
            ggtitle(" ") + xlim(1990, 2018) + ylim(105000, 155000)
  })
  
  output$payempSummary <- renderPrint({
    Arima(fredr_series(series_id = "PAYEMS"), order=c(1,1,1))
  })
  
  output$payempForecastTable <- renderDataTable({
    payemp.model <- Arima(fredr_series(series_id = "PAYEMS"), order = c(1,1,1))
    
    payemp.fcst <- forecast(payemp.model)
    payemp.fcst <- data.frame(payemp.fcst)
    
    payemp.fcst.dates <- row.names(payemp.fcst)
    
    payemp.fcst <- data.frame(sapply(payemp.fcst, function(x) round(x)))
    payemp.fcst$Date <- payemp.fcst.dates
    
    datatable(head(payemp.fcst), rownames = FALSE)
  })
  
  output$plot.gdp <- renderPlot({
    gdp.model <- Arima(fredr_series(series_id = "A191RL1Q225SBEA"), order = c(2,1,1))
    
    gdp.fcst <- forecast(gdp.model)
    
    autoplot(gdp.fcst) + ylab("Real GDP Growth Rate") +
               ggtitle(" ") + xlim(1990, 2018)
  })
  
  output$gdpSummary <- renderPrint({
    Arima(fredr_series(series_id = "A191RL1Q225SBEA"), order=c(1,1,1))
  })
  
  output$gdpForecastTable <- renderDataTable({
    gdp.model <- Arima(fredr_series(series_id = "A191RL1Q225SBEA"), order = c(1,1,1))
    
    gdp.fcst <- forecast(gdp.model)
    gdp.fcst <- data.frame(gdp.fcst)
    
    gdp.fcst.dates <- row.names(gdp.fcst)
    
    gdp.fcst <- data.frame(sapply(gdp.fcst, function(x) round(x, 2)))
    gdp.fcst$Date <- gdp.fcst.dates
    
    datatable(head(gdp.fcst), rownames = FALSE)
  })
  
  output$plot.cpi <- renderPlot({
    cpi.model <- Arima(fredr_series(series_id = "CPIAUCSL"), order = c(2,1,1))
    
    cpi.fcst <- forecast(cpi.model)
    
    autoplot(cpi.fcst) + ylab("CPI Growth Rate") +
               ggtitle(" ") + xlim(1990, 2018) + ylim(125, 250)
  })
  
  output$cpiSummary <- renderPrint({
    Arima(fredr_series(series_id = "CPIAUCSL"), order=c(1,1,1))
  })
  
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