source("functions.R")

fredr_key(key)

unemp.mod <- readRDS("unrate-AutoArima.rds")
payemp.mod <- readRDS("payems-AutoArima.rds")
gdp.mod <- readRDS("gdp-AutoArima.rds")
cpi.mod <- readRDS("cpi-AutoArima.rds")

shinyServer(function(input, output){
  
  output$menu <- renderMenu({
    sidebarMenu(
      menuItem("Unemployment", selected = TRUE,
               tabName="m1", icon=icon("line-chart")),
      menuItem("Payroll Employment", 
               tabName="m2", icon=icon("line-chart"))
    )
  })
  
  output$payroll_emp <- renderValueBox({
    valueBox(
      paste0(25, "%"), color="blue", 
      "Payroll Employoment")
  })
  # unemployment widget
  output$plot.unemp <- renderPlot(unemp.mod %>% plotModel)
  output$unempSummary <- renderPrint(unemp.mod)
  output$unempForecastTable <- renderDataTable(unemp.mod %>% forecastTable)
  output$unempResiduals <- renderPlot(unemp.mod %>% checkresiduals)
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



