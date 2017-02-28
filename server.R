source("functions.R")

fredr_key(key)

unemp.mod <- readRDS("unrate-AutoArima.rds")
payemp.mod <- readRDS("payems-AutoArima.rds")
gdp.mod <- readRDS("gdp-AutoArima.rds")
cpi.mod <- readRDS("cpi-AutoArima.rds")

shinyServer(function(input, output){
  # unemployment widget
  output$plot.unemp <- renderPlot(unemp.mod %>% plotModel)
  output$unempSummary <- renderPrint(unemp.mod)
  output$unempForecastTable <- renderDataTable(unemp.mod %>% forecastTable)
  # payroll employment widget
  output$plot.payemp <- renderPlot(payemp.mod %>% plotModel)
  output$payempSummary <- renderPrint(payemp.mod)
  output$payempForecastTable <- renderDataTable(payemp.mod %>% forecastTable)
  # gdp widget
  output$plot.gdp <- renderPlot(gdp.mod %>% plotModel)
  output$gdpSummary <- renderPrint(gdp.mod)
  output$gdpForecastTable <- renderDataTable(cpi.mod %>% forecastTable)
  # cpi widget
  output$plot.cpi <- renderPlot(cpi.mod %>% plotModel)
  output$cpiSummary <- renderPrint(cpi.mod)
  output$cpiForecastTable <- renderDataTable(cpi.mod %>% forecastTable)
})



