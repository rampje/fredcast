library(shiny)
library(shinydashboard)
library(forecast)
library(plotly)
library(fredr)

unemp.model <- Arima(fredr_series(series_id = "UNRATE"), order = c(1,1,1))
unemp.fcst <- forecast(unemp.model)
unrate <- round(unemp.fcst$mean[2], 1) 

shinyUI(
  dashboardPage(
    skin = "blue",

    dashboardHeader(title = "FREDcast dashboard",
                    titleWidth = 300),
  
    dashboardSidebar("blah"),
    
    dashboardBody(
      
      tabBox(title = "Unemployment Forecast",
             tabPanel("Forecast Graph", plotlyOutput("plot.unemp"),
                      color = "light-blue"),
             tabPanel("Model Summary",
                      verbatimTextOutput("unempSummary"))),
      
      tabBox(title = "Monthly Payroll Employment",
             tabPanel("Forecast Graph", plotlyOutput("plot.payemp"),
                      color = "light-blue"),
             tabPanel("Model Summary",
                      verbatimTextOutput("payempSummary"))),
      
      tabBox(title = "Quarterly GDP Growth Rate",
             tabPanel("Forecast Graph", plotlyOutput("plot.gdp"),
                      color = "light-blue"),
             tabPanel("Model Summary",
                      verbatimTextOutput("gdpSummary"))),
      
      tabBox(title = "Consumer Price Index",
             tabPanel("Forecast Graph", plotlyOutput("plot.cpi"),
                      color = "light-blue"),
             tabPanel("Model Summary",
                      verbatimTextOutput("cpiSummary")))
      )
    )
  )
  

     
  