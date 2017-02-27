source("functions.R")

fredr_key(key)

shinyServer(function(input, output){
  # unemployment widget
  output$plot.unemp <- renderPlot("UNRATE" %>% fitModel %>% plotModel)
  output$unempSummary <- renderPrint("UNRATE" %>% fitModel)
  output$unempForecastTable <- renderDataTable("UNRATE" %>% fitModel %>% forecastTable)
  # payroll employment widget
  output$plot.payemp <- renderPlot("PAYEMS" %>% fitModel %>% plotModel)
  output$payempSummary <- renderPrint(fitModel("PAYEMS"))
  output$payempForecastTable <- renderDataTable("PAYEMS" %>% fitModel %>% forecastTable)
  # gdp widget
  output$plot.gdp <- renderPlot("A191RL1Q225SBEA" %>% fitModel %>% plotModel)
  output$gdpSummary <- renderPrint("A191RL1Q225SBEA" %>% fitModel)
  output$gdpForecastTable <- renderDataTable("A191RL1Q225SBEA"%>%fitModel%>%forecastTable)
  # cpi widget
  output$plot.cpi <- renderPlot("CPIAUCSL" %>% fitModel %>% plotModel)
  output$cpiSummary <- renderPrint("CPIAUCSL" %>% fitModel)
  output$cpiForecastTable <- renderDataTable("CPIAUCSL" %>% fitModel %>% forecastTable)
})