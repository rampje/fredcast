library(forecast)
library(fredr)
library(zoo)

source("functions.R")

unrate <- fredr_series(series_id = "UNRATE")

unr.mod <- fitModel("UNRATE")
pay.mod <- fitModel("PAYEMS")
gdp.mod <- fitModel("A191RL1Q225SBEA")
cpi.mod <- fitModel("CPIAUCSL")

saveRDS(unr.mod, file = "unrate-AutoArima.rds")
saveRDS(pay.mod, file = "payems-AutoArima.rds")
saveRDS(gdp.mod, file = "gdp-AutoArima.rds")
saveRDS(cpi.mod, file = "cpi-AutoArima.rds")

# convert time series to dataframe for analysis
unrate_df <- data.frame("unemp"=as.matrix(unrate),
                        "month"=as.Date(unrate))

unrate_df$unemp_L1 <- lag(unrate_df$unemp, k = 1)

# flag for whether unemployment went up or down
unrate_df$direction <-
  ifelse(unrate_df$unemp > unrate_df$unemp_L1,
         "increase",
         ifelse(unrate_df$unemp == unrate_df$unemp_L1,
                "same", "decrease"))
head(unrate_df)
