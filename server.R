source("functions.R")

fredr_key(key)

unemp.mod <- readRDS("unrate-AutoArima.rds")
payemp.mod <- readRDS("payems-AutoArima.rds")
gdp.mod <- readRDS("gdp-AutoArima.rds")
cpi.mod <- readRDS("cpi-AutoArima.rds")

unemp.mod %>% forecast %>% data.frame -> unfcst
payemp.mod %>% forecast %>% data.frame -> payfcst
gdp.mod  %>% forecast %>% data.frame -> gdpfcst
cpi.mod %>% forecast %>% data.frame -> cpifcst

shinyServer(function(input, output){
  
  output$menu <- renderMenu({
    sidebarMenu(
      menuItem("Unemployment", selected = TRUE,
               tabName="m1", icon=icon("line-chart")),
      menuItem("Payroll Employment", 
               tabName="m2", icon=icon("line-chart")),
      menuItem("GDP Growth Rate",
               tabName="m3", icon=icon("line-chart")),
      menuItem("Consumer Price Index",
               tabName="m4", icon=icon("line-chart"))
    )
  })
  
  output$unemp <- renderValueBox({
    valueBox(
      paste0(round(unfcst$Point.Forecast[2], 2), "%"), color="navy",
      subtitle="Unemployment Rate"
      #icon = icon("arrow-up")
      )
  })
  
  output$payroll_emp <- renderValueBox({
    valueBox(
      round(payfcst$Point.Forecast[2]), color="blue", 
      subtitle="Payroll Employment")
  })
  
  output$gdp <- renderValueBox({
    valueBox(
      paste0(round(gdpfcst$Point.Forecast[2], 2), "%"), color="light-blue",
      "GDP Growth Rate")
  })
  
  output$cpi <- renderValueBox({
    valueBox(
      paste0(round(cpifcst$Point.Forecast[2]/100, 2), "%"), color="purple",
             "Consumer Price Index")
  })
  # unemployment widget
  output$plot.unemp <- renderPlot(unemp.mod %>% plotModel)
  output$unempSummary <- renderPrint(unemp.mod)
  output$unempForecastTable <- renderDataTable(unemp.mod %>% forecastTable)
  output$unedmpResiduals <- renderPlot(unemp.mod %>% checkresiduals)
  # payroll employment widget
  output$plot.payemp <- renderPlot(payemp.mod %>% plotModel)
  output$payempSummary <- renderPrint(payemp.mod)
  output$payempForecastTable <- renderDataTable(payemp.mod %>% forecastTable)
  output$payempResiduals <- renderPlot(payemp.mod %>% checkresiduals)
  # gdp widget
  output$plot.gdp <- renderPlot(gdp.mod %>% plotModel)
  output$gdpSummary <- renderPrint(gdp.mod)
  output$gdpForecastTable <- renderDataTable(cpi.mod %>% forecastTable)
  output$gdpResiduals <- renderPlot(gdp.mod %>% checkresiduals)
  # cpi widget
  output$plot.cpi <- renderPlot(cpi.mod %>% plotModel)
  output$cpiSummary <- renderPrint(cpi.mod)
  output$cpiForecastTable <- renderDataTable(cpi.mod %>% forecastTable)
  output$cpiResiduals <- renderPlot(cpi.mod %>% checkresiduals)
})



