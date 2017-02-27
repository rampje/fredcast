source("functions.R")

shinyUI(
  dashboardPage(
    skin = "blue",

    dashboardHeader(title = h3("FREDcast dashboard"),
                    titleWidth = 300),
  
    dashboardSidebar(h3("This shiny dashboard uses time series models to forecast economic indicators in FRED's 'FREDcast' game"),
                     width = 400,
                     dateInput("date", 
                               label = h3("Select Month to Forecast:"), 
                               value = "2014-03-01")),
    
    dashboardBody(
      widget(unempTabs),
      widget(payempTabs),
      widget(gdpTabs),
      widget(cpiTabs))
    )
  )
  

     
  