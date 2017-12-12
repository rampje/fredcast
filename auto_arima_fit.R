library(forecast)
library(fredr)
library(zoo)

source("functions.R")

model_dir <- getwd()
model_dir <- paste0(model_dir, "/models/prod")

unrate <- fredr_series(series_id = "UNRATE")

unr.mod <- fitModel("UNRATE")
pay.mod <- fitModel("PAYEMS")
gdp.mod <- fitModel("A191RL1Q225SBEA")
cpi.mod <- fitModel("CPIAUCSL")

saveRDS(unr.mod, file = paste0(model_dir,
                               "/unrate-AutoArima.rds"))
saveRDS(pay.mod, file = paste0(model_dir,
                               "/payems-AutoArima.rds"))
saveRDS(gdp.mod, file = paste0(model_dir,
                               "/gdp-AutoArima.rds"))
saveRDS(cpi.mod, file = paste0(model_dir,
                               "/cpi-AutoArima.rds"))
