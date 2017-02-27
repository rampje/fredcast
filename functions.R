library(shiny)
library(shinydashboard)
library(forecast)
library(plotly)
library(fredr)
library(DT)

key <- "0e510a57a0086df706ac9c8fb852b706"

unempTabs <- c("plot.unemp","unempSummary", "unempForecastTable")
payempTabs <- c("plot.payemp","payempSummary","payempForecastTable")
gdpTabs <- c("plot.gdp","gdpSummary","gdpForecastTable")
cpiTabs <- c("plot.cpi","cpiSummary","cpiForecastTable")

fitModel <- function(seriesID){
  # currently only fitting ARIMA models
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
widget <- function(tabs){
  
  if(grepl("unemp", tabs[1])){
    tabBox(title = "Unemployment Forecast",
           tabPanel("Forecast Graph", plotOutput(tabs[1], height = "350px"),
                    color = "light-blue"),
           tabPanel("Model Summary",
                    verbatimTextOutput(tabs[2])),
           tabPanel("Forecast Table",
                    dataTableOutput(tabs[3])))
  } else if(grepl("payemp", tabs[1])){
    tabBox(title = "Monthly Payroll Employment",
           tabPanel("Forecast Graph", plotOutput(tabs[1], height = "350px"),
                    color = "light-blue"),
           tabPanel("Model Summary",
                    verbatimTextOutput(tabs[2])),
           tabPanel("Forecast Table",
                    dataTableOutput(tabs[3])))
  } else if(grepl("gdp", tabs[1])){
    tabBox(title = "Quarterly GDP Growth Rate",
           tabPanel("Forecast Graph", plotOutput(tabs[1], height = "350px"),
                    color = "light-blue"),
           tabPanel("Model Summary",
                    verbatimTextOutput(tabs[2])),
           tabPanel("Forecast Table",
                    dataTableOutput(tabs[3])))
  } else if(grepl("cpi", tabs[1])){
    tabBox(title = "Consumer Price Index",
           tabPanel("Forecast Graph", plotOutput(tabs[1], height = "350px"),
                    color = "light-blue"),
           tabPanel("Model Summary",
                    verbatimTextOutput(tabs[2])),
           tabPanel("Forecast Table",
                    dataTableOutput(tabs[3])))
  }
}
