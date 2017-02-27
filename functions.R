
fitModel <- function(seriesID){
  if(seriesID == "UNRATE"){
    Arima(fredr_series(series_id = "UNRATE"), order = c(1,1,1))
  } else if(seriesID == "PAYEMS"){
    Arima(fredr_series(series_id = "PAYEMS"), order=c(1,1,1))
  } else if(seriesID == "A191RL1Q225SBEA"){
    Arima(fredr_series(series_id = "A191RL1Q225SBEA"), order = c(2,1,1))
  } else if(seriesID == "CPIAUCSL"){
    Arima(fredr_series(series_id = "CPIAUCSL"), order = c(2,1,1))
  }
}

plotModel <- function(model){
  
  fcst <- forecast(model)
  
  # assumes object is forecast model
  if(grepl("PAYEMS", model$series)){
    
    autoplot(fcst) + ylab("Payroll Employment") +
      ggtitle(" ") + xlim(1990, 2018) + ylim(105000, 155000)
    
  } else if(grepl("A191RL1Q225SBEA", model$series)){
    
    autoplot(fcst) + ylab("Real GDP Growth Rate") +
      ggtitle(" ") + xlim(1990, 2018)
    
  } else if(grepl("CPIAUCSL", model$series)){
    
    autoplot(fcst) + ylab("CPI Growth Rate") +
      ggtitle(" ") + xlim(1990, 2018) + ylim(125, 250)
  } else if(grepl("UNRATE", model$series)){
    autoplot(fcst) + ylab("Unemployment Rate") + ggtitle(" ")
  }
}

forecastTable <- function(model){
  fcst <- forecast(model)
  
  # assumes object is forecast model
  if(grepl("UNRATE", model$series) |
     grepl("A191RL1Q225SBEA", model$series)){
    
    fcst <- data.frame(fcst)
    
    fcst.dates <- row.names(fcst)
    
    fcst <- data.frame(sapply(fcst, function(x) round(x, 2)))
    fcst$Date <- fcst.dates
    
    datatable(head(fcst), rownames = FALSE)
    
  } else if(grepl("CPIAUCSL", model$series)){
    
    fcst <- data.frame(fcst)
    
    fcst.dates <- row.names(fcst)
    
    fcst <- data.frame(sapply(fcst, function(x) round(x, 1)))
    fcst$Date <- fcst.dates
    
    datatable(head(fcst), rownames = FALSE)
    
  }  else if(grepl("PAYEMS", model$series)){
    fcst <- data.frame(fcst)
    
    fcst.dates <- row.names(fcst)
    
    fcst <- data.frame(sapply(fcst, function(x) round(x)))
    fcst$Date <- fcst.dates
    
    datatable(head(fcst), rownames = FALSE)
  }
}