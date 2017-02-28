library(forecast)
library(fredr)

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
