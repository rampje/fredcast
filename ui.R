source("functions.R")

unemp.mod <- readRDS("unrate-AutoArima.rds")
payemp.mod <- readRDS("payems-AutoArima.rds")
gdp.mod <- readRDS("gdp-AutoArima.rds")
cpi.mod <- readRDS("cpi-AutoArima.rds")

unemp.mod %>% forecast %>% data.frame -> unfcst
payemp.mod %>% forecast %>% data.frame -> payfcst
gdp.mod  %>% forecast %>% data.frame -> gdpfcst
cpi.mod %>% forecast %>% data.frame -> cpifcst

shinyUI(
  dashboardPage(
    skin = "blue",

    dashboardHeader(title = h3("FREDcast dashboard"),
                    titleWidth = 300),
                    
    dashboardSidebar(
      "This shiny app uses time series models to forecast economic indicators in FRED's 'FREDcast' game",
      width = 200,
      sidebarMenuOutput("menu"),
      dateRangeInput("dateRange",
                     label = "Graph Date Range",
                     start = "1990-01-01", end = "2018-12-31"),
      dateInput("date",
                label = "Select Month to Forecast:", 
                value = "2014-03-01"),
      "April 2017 Forecasts:",
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
      
      fluidRow(
        valueBox(3*5, "Unemployment"),
        valueBoxOutput("payroll_emp")
      ),
      #mainPanel("This shiny app contains models and forecasts for the economic variables in the forecasting game fredcast"),
      tabItems(
        tabItem(tabName = "m1", widget(unempTabs)),
        tabItem(tabName = "m2", widget(payempTabs))
        )
      #column(widget(unempTabs),
      #       widget(payempTabs),
      #       width = 11),
      #column(widget(gdpTabs),
      #        widget(cpiTabs),
      #       width = 11),
      
      #tags$a(href="https://github.com/rampje/fredcast", "Shiny app code on Github")
      #fluidRow(tags$a(href="https://research.stlouisfed.org/useraccount/fredcast/", "FREDcast Page"))
             
    )
  )
)
  

     
  