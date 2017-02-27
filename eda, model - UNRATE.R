library(forecast)
library(fredr)

unrate <- fredr_series(series_id = "UNRATE")

acf(unrate)
pacf(unrate)

acf(diff(unrate))
pacf(diff(unrate))
