library(shiny)
library(shinydashboard)
library(forecast)
library(plotly)
library(fredr)
library(DT)

unempTabs <- c("plot.unemp","unempSummary", "unempForecastTable")

shinyUI(
  dashboardPage(
    skin = "blue",

    dashboardHeader(title = h3("FREDcast dashboard"),
                    titleWidth = 300),
  
    dashboardSidebar(h3("This shiny dashboard uses time series models to forecast economic time series in FRED's 'FREDcast' game"),
                     width = 400),
    
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
  

     
  