source("functions.R")

"UNRATE" %>% fitModel %>% forecast %>% data.frame -> unfcst
"PAYEMS" %>% fitModel %>% forecast %>% data.frame -> payfcst
"A191RL1Q225SBEA" %>% fitModel %>% forecast %>% data.frame -> gdpfcst
"CPIAUCSL" %>% fitModel %>% forecast %>% data.frame -> cpifcst

shinyUI(
  dashboardPage(
    skin = "blue",

    dashboardHeader(title = h3("FREDcast dashboard"),
                    titleWidth = 300),
                    
    dashboardSidebar(
      "This shiny app uses time series models to forecast economic indicators in FRED's 'FREDcast' game",
      width = 200,
      dateRangeInput("dateRange",
                     label = "Graph Date Range",
                     start = "1990-01-01", end = "2018-12-31"),
      dateInput("date", 
                label = "Select Month to Forecast:", 
                value = "2014-03-01"),
      "March 2017 Forecasts:",
      fluidRow(valueBox(paste0(round(unfcst$Point.Forecast[2], 2), "%"),
               "Unemployment Rate", 
                width = 1)),
      fluidRow(valueBox(round(payfcst$Point.Forecast[2]),
               "Payroll Employment", 
                width = 1)),
      fluidRow(valueBox(paste0(round(gdpfcst$Point.Forecast[2], 2), "%"),
               "GDP Growth Rate", 
                width = 1)),
      fluidRow(valueBox(paste0(round(cpifcst$Point.Forecast[2], 1), "%"),
              "Consumer Price Index YTD", 
               width = 1))),
    
    dashboardBody(
      column(widget(unempTabs),
             widget(payempTabs),
             width = 8),
      column(widget(gdpTabs),
              widget(cpiTabs),
             width = 8),
      
      fluidRow(tags$a(href="https://github.com/rampje/fredcast", "Shiny app code on Github"))
      #fluidRow(tags$a(href="https://research.stlouisfed.org/useraccount/fredcast/", "FREDcast Page"))
             
    )
  )
)
  

     
  