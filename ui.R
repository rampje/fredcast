library(shiny)
library(shinydashboard)
library(forecast)
library(plotly)
library(fredr)
library(DT)

widget <- function(tabs){
  
  if(grepl("unemp", tabs[1])){
    tabBox(title = "Unemployment Forecast",
           tabPanel("Forecast Graph", plotOutput(tabs[1]),
                    color = "light-blue"),
           tabPanel("Model Summary",
                    verbatimTextOutput(tabs[2])),
           tabPanel("Forecast Table",
                    dataTableOutput(tabs[3])))
  } else if(grepl("payemp", tabs[1])){
    tabBox(title = "Monthly Payroll Employment",
           tabPanel("Forecast Graph", plotOutput(tabs[1]),
                    color = "light-blue"),
           tabPanel("Model Summary",
                    verbatimTextOutput(tabs[2])),
           tabPanel("Forecast Table",
                    dataTableOutput(tabs[3])))
  } else if(grepl("gdp", tabs[1])){
    tabBox(title = "Quarterly GDP Growth Rate",
           tabPanel("Forecast Graph", plotOutput(tabs[1]),
                    color = "light-blue"),
           tabPanel("Model Summary",
                    verbatimTextOutput(tabs[2])),
           tabPanel("Forecast Table",
                    dataTableOutput(tabs[3])))
  } else if(grepl("cpi", tabs[1])){
    tabBox(title = "Consumer Price Index",
           tabPanel("Forecast Graph", plotOutput(tabs[1]),
                    color = "light-blue"),
           tabPanel("Model Summary",
                    verbatimTextOutput(tabs[2])),
           tabPanel("Forecast Table",
                    dataTableOutput(tabs[3])))
  }
}

unempTabs <- c("plot.unemp","unempSummary", "unempForecastTable")
payempTabs <- c("plot.payemp","payempSummary","payempForecastTable")
gdpTabs <- c("plot.gdp","gdpSummary","gdpForecastTable")
cpiTabs <- c("plot.cpi","cpiSummary","cpiForecastTable")


shinyUI(
  dashboardPage(
    skin = "blue",

    dashboardHeader(title = h3("FREDcast dashboard"),
                    titleWidth = 300),
  
    dashboardSidebar(h3("This shiny dashboard uses time series models to forecast economic time series in FRED's 'FREDcast' game"),
                     width = 400),
    
    dashboardBody(
      widget(unempTabs),
      widget(payempTabs),
      widget(gdpTabs),
      widget(cpiTabs)
      )
    )
  )
  

     
  