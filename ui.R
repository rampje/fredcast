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
      

      box("Unemployment Forecast",
          plotlyOutput("plot.unemp"),
          color = "light-blue"),

      box("Monthly Payroll Employment",
          plotlyOutput("plot.payemp"),
          color = "light-blue")
      )
    )
  )
  

     
  