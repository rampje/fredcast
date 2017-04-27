source("functions.R")

fredr_key(key)

unemp.mod <- readRDS("unrate-AutoArima.rds")
payemp.mod <- readRDS("payems-AutoArima.rds")
gdp.mod <- readRDS("gdp-AutoArima.rds")
cpi.mod <- readRDS("cpi-AutoArima.rds")

unemp.mod %>% forecast %>% data.frame -> unfcst_df
payemp.mod %>% forecast %>% data.frame -> payfcst
gdp.mod  %>% forecast %>% data.frame -> gdpfcst
cpi.mod %>% forecast %>% data.frame -> cpifcst

unfcst <- forecast(unemp.mod)
unfcst_df <- data.frame(unfcst)

payfcst <- forecast(payemp.mod)
payfcst_df <- data.frame(payfcst)

gdpfcst <- forecast(gdp.mod)
gdpfcst_df <- data.frame(gdpfcst)

cpifcst <- forecast(cpi.mod)
cpifcst_df <- data.frame(cpifcst)

shinyServer(function(input, output){
  
  output$menu <- renderMenu({
    sidebarMenu(
      menuItem("Unemployment",
               tabName="m1", icon=icon("line-chart")),
#               menuSubItem("Unemployment EDA",
#                           tabName="u2"),
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
      paste0(round(unfcst_df$Point.Forecast[2], 2), "%"), color="navy",
      subtitle="Unemployment Rate"
      #icon = icon("arrow-up")
      )
  })
  
  output$payroll_emp <- renderValueBox({
    valueBox(
      round(payfcst_df$Point.Forecast[2]), color="blue", 
      subtitle="Payroll Employment")
  })
  
  output$gdp <- renderValueBox({
    valueBox(
      paste0(round(gdpfcst_df$Point.Forecast[2], 2), "%"), color="light-blue",
      "GDP Growth Rate")
  })
  
  output$cpi <- renderValueBox({
    valueBox(
      paste0(round(cpifcst_df$Point.Forecast[2]/100, 2), "%"), color="purple",
             "Consumer Price Index")
  })
  
  unemp_array <- gen_array(unfcst)
  payemp_array <- gen_array(payfcst)
  gdp_array <- gen_array(gdpfcst)
  cpi_array <- gen_array(cpifcst)
  # unemployment widget
  output$plot.unemp <- renderDygraph(unemp_array %>% 
                                       plotModel("UNRATE"))
  output$unempSummary <- renderPrint(unemp.mod)
  output$unempForecastTable <- renderDataTable(unemp.mod %>% forecastTable)
  output$unedmpResiduals <- renderPlot(unemp.mod %>% checkresiduals)
  # payroll employment widget
  output$plot.payemp <- renderDygraph(payemp_array %>% 
                                        plotModel("PAYEMS"))
  output$payempSummary <- renderPrint(payemp.mod)
  output$payempForecastTable <- renderDataTable(payemp.mod %>% forecastTable)
  output$payempResiduals <- renderPlot(payemp.mod %>% checkresiduals)
  # gdp widget
  output$plot.gdp <- renderDygraph(gdp_array %>% 
                                     plotModel("A191RL1Q225SBEA"))
  output$gdpSummary <- renderPrint(gdp.mod)
  output$gdpForecastTable <- renderDataTable(cpi.mod %>% forecastTable)
  output$gdpResiduals <- renderPlot(gdp.mod %>% checkresiduals)
  # cpi widget
  output$plot.cpi <- renderDygraph(cpi_array %>% 
                                     plotModel("CPIAUCSL"))
  output$cpiSummary <- renderPrint(cpi.mod)
  output$cpiForecastTable <- renderDataTable(cpi.mod %>% forecastTable)
  output$cpiResiduals <- renderPlot(cpi.mod %>% checkresiduals)
  
})



