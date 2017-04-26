library(shiny)
library(shinydashboard)
library(forecast)
library(plotly)
library(fredr)
library(DT)
library(dygraphs)
library(zoo)
library(lubridate)

key <- "0e510a57a0086df706ac9c8fb852b706"

unempTabs <- c("plot.unemp","unempSummary", 
               "unempForecastTable","unempResiduals")
payempTabs <- c("plot.payemp","payempSummary",
                "payempForecastTable","payempResiduals")
gdpTabs <- c("plot.gdp","gdpSummary",
             "gdpForecastTable","gdpResiduals")
cpiTabs <- c("plot.cpi","cpiSummary",
             "cpiForecastTable","cpiResiduals")

fitModel <- function(seriesID){
  # currently only fitting ARIMA models
  if(seriesID == "UNRATE"){
    auto.arima(fredr_series(series_id = "UNRATE"))
  } else if(seriesID == "PAYEMS"){
    auto.arima(fredr_series(series_id = "PAYEMS"))
  } else if(seriesID == "A191RL1Q225SBEA"){
    auto.arima(fredr_series(series_id = "A191RL1Q225SBEA"))
  } else if(seriesID == "CPIAUCSL"){
    auto.arima(fredr_series(series_id = "CPIAUCSL"))
  }
}
gen_array <- function(forecast_obj){
  
  actuals <- forecast_obj$x
  lower <- forecast_obj$lower[,2]
  upper <- forecast_obj$upper[,2]
  point_forecast <- forecast_obj$mean
  
  cbind(actuals, lower, upper, point_forecast)
}
plotModel <- function(ts_array){
    dygraph(ts_array) %>% dyRangeSelector() %>% 
    dyRangeSelector(dateWindow = c("2007-01-01", "2019-4-01")) %>%
      dySeries(name = "actuals", label = "actual") %>%
      dySeries(c("lower","point_forecast","upper"), label = "Predicted") %>%
      dyLegend(show = "always", hideOnMouseOut = FALSE) %>%
      dyHighlight(highlightCircleSize = 5,
                  highlightSeriesOpts = list(strokeWidth = 2)) %>%
      dyOptions(#colors = c("#266DD3","23F0C7"),
                axisLineColor = "navy", gridLineColor = "grey")
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
           tabPanel("Model Summary",
                    verbatimTextOutput(tabs[2])),
           tabPanel("Forecast Table",
                    dataTableOutput(tabs[3])),
           tabPanel("Residuals",
                    plotOutput(tabs[4])),
           width = 10)
  } else if(grepl("payemp", tabs[1])){
    tabBox(title = "Monthly Payroll Employment",
           tabPanel("Model Summary",
                    verbatimTextOutput(tabs[2])),
           tabPanel("Forecast Table",
                    dataTableOutput(tabs[3])),
           tabPanel("Residuals",
                    plotOutput(tabs[4])),
           width = 10)
  } else if(grepl("gdp", tabs[1])){
    tabBox(title = "Quarterly GDP Growth Rate",
           tabPanel("Model Summary",
                    verbatimTextOutput(tabs[2])),
           tabPanel("Forecast Table",
                    dataTableOutput(tabs[3])),
           tabPanel("Residuals",
                    plotOutput(tabs[4])),
           width = 10)
  } else if(grepl("cpi", tabs[1])){
    tabBox(title = "Consumer Price Index",
           tabPanel("Model Summary",
                    verbatimTextOutput(tabs[2])),
           tabPanel("Forecast Table",
                    dataTableOutput(tabs[3])),
           tabPanel("Residuals",
                    plotOutput(tabs[4])),
           width = 10)
  }
}


