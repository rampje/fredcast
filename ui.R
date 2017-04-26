source("functions.R")

unemp.mod <- readRDS("unrate-AutoArima.rds")
payemp.mod <- readRDS("payems-AutoArima.rds")
gdp.mod <- readRDS("gdp-AutoArima.rds")
cpi.mod <- readRDS("cpi-AutoArima.rds")

unemp.mod %>% forecast %>% data.frame -> unfcst_df
payemp.mod %>% forecast %>% data.frame -> payfcst
gdp.mod  %>% forecast %>% data.frame -> gdpfcst
cpi.mod %>% forecast %>% data.frame -> cpifcst

# automate forecast month name
fcst_month <- end(unemp.mod$x)
fcst_month[2] <- fcst_month[2] + 1 
fcst_month <- months(as.Date(paste0(fcst_month[1], "-",
                                    0,fcst_month[2],  "-",1)))

shinyUI(
  dashboardPage(
    skin = "blue",

    dashboardHeader(title = "FREDcast dashboard",
                    titleWidth = 300),
                    
    dashboardSidebar(
      tags$br("This shiny app uses time series models 
               to forecast economic indicators in FRED's 
               'FREDcast' game"),
      #width = 200,
      
      tags$br(
        tags$strong("indicator selection:")),
      
      tags$br(
        sidebarMenuOutput("menu")),
      
      tags$strong("links"),
      tags$div(
        tags$ul(
          tags$li(
            tags$a(href="https://github.com/rampje/fredcast", 
                   "code on github")),
          tags$li(
            tags$a(href="https://research.stlouisfed.org/useraccount/fredcast/",
                   "FREDcast page"))))),
    
    dashboardBody(
      fluidRow(
        box(title=paste(fcst_month, "economic forecasts:"),
        valueBoxOutput("unemp", width = 3),
        valueBoxOutput("payroll_emp", width = 3),
        valueBoxOutput("gdp", width = 3),
        valueBoxOutput("cpi", width = 3), 
        strong("Click on tabs for more information about an indicator"),
        width = 11),
      
      #mainPanel("This shiny app contains models and forecasts for the economic variables in the forecasting game fredcast"),
      tabItems(
        tabItem(tabName = "m1", widget(unempTabs)),
        tabItem(tabName = "m2", widget(payempTabs)),
        tabItem(tabName = "m3", widget(gdpTabs)),
        tabItem(tabName = "m4", widget(cpiTabs))
        )
      )
      #column(widget(unempTabs),
      #       widget(payempTabs),
      #       width = 11),
      #column(widget(gdpTabs),
      #        widget(cpiTabs),
      #       width = 11),
      
      #fluidRow(tags$a(href="https://research.stlouisfed.org/useraccount/fredcast/", "FREDcast Page"))
             
    )
  )
)
  

     
  