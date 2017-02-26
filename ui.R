library(shiny)
library(shinydashboard)
library(forecast)
library(plotly)
library(fredr)
library(DT)

unemp.model <- Arima(fredr_series(series_id = "UNRATE"), order = c(1,1,1))
unemp.fcst <- forecast(unemp.model)
unrate <- round(unemp.fcst$mean[2], 1) 

datatable(data.frame(unemp.fcst))

shinyUI(
  dashboardPage(
    skin = "blue",

    dashboardHeader(title = "FREDcast dashboard",
                    titleWidth = 300),
  
    dashboardSidebar("blah"),
    
    dashboardBody(
      
      tabBox(title = "Unemployment Forecast",
             tabPanel("Forecast Graph", plotOutput("plot.unemp"),
                      color = "light-blue"),
             tabPanel("Model Summary",
                      verbatimTextOutput("unempSummary")),
             tabPanel("Forecast Table",
                      dataTableOutput("unempForecastTable"))),
      
      tabBox(title = "Monthly Payroll Employment",
             tabPanel("Forecast Graph", plotOutput("plot.payemp"),
                      color = "light-blue"),
             tabPanel("Model Summary",
                      verbatimTextOutput("payempSummary")),
             tabPanel("Forecast Table",
                      dataTableOutput("payempForecastTable"))),
      
      tabBox(title = "Quarterly GDP Growth Rate",
             tabPanel("Forecast Graph", plotOutput("plot.gdp"),
                      color = "light-blue"),
             tabPanel("Model Summary",
                      verbatimTextOutput("gdpSummary")),
             tabPanel("Forecast Table",
                      dataTableOutput("gdpForecastTable"))),
      
      tabBox(title = "Consumer Price Index",
             tabPanel("Forecast Graph", plotOutput("plot.cpi"),
                      color = "light-blue"),
             tabPanel("Model Summary",
                      verbatimTextOutput("cpiSummary")),
             tabPanel("Forecast Table",
                      dataTableOutput("cpiForecastTable")))
      )
    )
  )
  

     
  