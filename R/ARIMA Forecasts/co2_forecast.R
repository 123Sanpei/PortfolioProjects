library(readxl)
library(lmtest)
library(forecast)
library(DIMORA)
library(ggplot2)
library(scales)
library(dplyr)
library(plotly)
library(MLmetrics)

data = read.csv("co2_annual.csv")
View(data)

# Read all the countries

ITA = tail(data[data$Code %in% c("ITA"),], 52)
co2_ITA = ts(ITA$Annual.COâ...emissions, start=1970)
FRA = tail(data[data$Code %in% c("FRA"),], 52)
co2_FRA = ts(FRA$Annual.COâ...emissions, start=1970)
GER = tail(data[data$Code %in% c("DEU"),], 52)
co2_GER = ts(GER$Annual.COâ...emissions, start=1970)
SPA = tail(data[data$Code %in% c("ESP"),], 52)
co2_SPA = ts(SPA$Annual.COâ...emissions, start=1970)
PRT = tail(data[data$Code %in% c("PRT"),], 52)
co2_PRT = ts(PRT$Annual.COâ...emissions, start=1970)
DEN = tail(data[data$Code %in% c("DNK"),], 52)
co2_DEN = ts(DEN$Annual.COâ...emissions, start=1970)
SWE = tail(data[data$Code %in% c("SWE"),], 52)
co2_SWE = ts(SWE$Annual.COâ...emissions, start=1970)
BEL = tail(data[data$Code %in% c("BEL"),], 52)
co2_BEL = ts(BEL$Annual.COâ...emissions, start=1970)
NLD = tail(data[data$Code %in% c("NLD"),], 52)
co2_NLD = ts(NLD$Annual.COâ...emissions, start=1970)
LUX = tail(data[data$Code %in% c("LUX"),], 52)
co2_LUX = ts(LUX$Annual.COâ...emissions, start=1970)
IRL = tail(data[data$Code %in% c("IRL"),], 52)
co2_IRL = ts(IRL$Annual.COâ...emissions, start=1970)
MLT = tail(data[data$Code %in% c("MLT"),], 52)
co2_MLT = ts(MLT$Annual.COâ...emissions, start=1970)
#GBR = tail(data[data$Code %in% c("GBR"),], 52)
#co2_GBR = ts(GBR$Annual.COâ...emissions, start=1970)

AUS = tail(data[data$Code %in% c("AUT"),], 52)
co2_AUS = ts(AUS$Annual.COâ...emissions, start=1970)
SVN = tail(data[data$Code %in% c("SVN"),], 52)
co2_SVN = ts(SVN$Annual.COâ...emissions, start=1970)
CZE = tail(data[data$Code %in% c("CZE"),], 52)
co2_CZE = ts(CZE$Annual.COâ...emissions, start=1970)
SVK = tail(data[data$Code %in% c("SVK"),], 52)
co2_SVK = ts(SVK$Annual.COâ...emissions, start=1970)
POL = tail(data[data$Code %in% c("POL"),], 52)
co2_POL = ts(POL$Annual.COâ...emissions, start=1970)
FIN = tail(data[data$Code %in% c("FIN"),], 52)
co2_FIN = ts(FIN$Annual.COâ...emissions, start=1970)
LIT = tail(data[data$Code %in% c("LTU"),], 52)
co2_LIT = ts(LIT$Annual.COâ...emissions, start=1970)
EST = tail(data[data$Code %in% c("EST"),], 52)
co2_EST = ts(EST$Annual.COâ...emissions, start=1970)
LET = tail(data[data$Code %in% c("LVA"),], 52)
co2_LET = ts(LET$Annual.COâ...emissions, start=1970)
HUN = tail(data[data$Code %in% c("HUN"),], 52)
co2_HUN = ts(HUN$Annual.COâ...emissions, start=1970)
CRO = tail(data[data$Code %in% c("HRV"),], 52)
co2_CRO = ts(CRO$Annual.COâ...emissions, start=1970)
BGR = tail(data[data$Code %in% c("BGR"),], 52)
co2_BGR = ts(BGR$Annual.COâ...emissions, start=1970)
ROM = tail(data[data$Code %in% c("ROU"),], 52)
co2_ROM = ts(ROM$Annual.COâ...emissions, start=1970)
GRC = tail(data[data$Code %in% c("GRC"),], 52)
co2_GRC = ts(GRC$Annual.COâ...emissions, start=1970)
CYP = tail(data[data$Code %in% c("CYP"),], 52)
co2_CYP = ts(CYP$Annual.COâ...emissions, start=1970)

EU = tail(data[data$Entity %in% c("European Union (27)"),], 52)
co2_EU = ts(EU$Annual.COâ...emissions, start=1970)
co2_EU1990 = co2_EU[21]


fig_WEU <- plot_ly()
fig_WEU <- fig_WEU %>% add_lines(data=ITA, x = ~Year, y = ~Annual.COâ...emissions,
                                 name = 'Italy', type = 'scatter', mode = 'lines', 
                                 line = list(color = 'green', width = 2))
fig_WEU <- fig_WEU %>% add_lines(data=SPA, x = ~Year, y = ~Annual.COâ...emissions,
                                 name = 'Spain', type = 'scatter', mode = 'lines', 
                                 line = list(color = 'yellow', width = 2))
fig_WEU <- fig_WEU %>% add_lines(data=SWE, x = ~Year, y = ~Annual.COâ...emissions,
                                 name = 'Sweden', type = 'scatter', mode = 'lines', 
                                 line = list(color = '000033', width = 2))
fig_WEU <- fig_WEU %>% add_lines(data=FRA, x = ~Year, y = ~Annual.COâ...emissions,
                                 name = 'France', type = 'scatter', mode = 'lines', 
                                 line = list(color = 'blue', width = 2))
fig_WEU <- fig_WEU %>% add_lines(data=GER, x = ~Year, y = ~Annual.COâ...emissions,
                                 name = 'Germany', type = 'scatter', mode = 'lines', 
                                 line = list(color = 'black', width = 2))
fig_WEU <- fig_WEU %>% add_lines(data=IRL, x = ~Year, y = ~Annual.COâ...emissions,
                                 name = 'Ireland', type = 'scatter', mode = 'lines', 
                                 line = list(color = '00cc00', width = 2))
fig_WEU <- fig_WEU %>% layout(title = "Annual CO2 emissions- Western Europe",
                              xaxis = list(title = "Year"), 
                              yaxis = list (title = "CO2 emissions in tonnes"))

fig_EEU <- plot_ly()
fig_EEU <- fig_EEU %>% add_lines(data=AUS, x = ~Year, y = ~Annual.COâ...emissions,
                                 name = 'Austria', type = 'scatter', mode = 'lines', 
                                 line = list(color = 'FFCC00', width = 2))
fig_EEU <- fig_EEU %>% add_lines(data=CZE, x = ~Year, y = ~Annual.COâ...emissions,
                                 name = 'Czechia', type = 'scatter', mode = 'lines', 
                                 line = list(color = '996600', width = 2))
fig_EEU <- fig_EEU %>% add_lines(data=LIT, x = ~Year, y = ~Annual.COâ...emissions,
                                 name = 'Lithuania', type = 'scatter', mode = 'lines', 
                                 line = list(color = 'cc0099', width = 2))
fig_EEU <- fig_EEU %>% add_lines(data=CYP, x = ~Year, y = ~Annual.COâ...emissions,
                                 name = 'Cyprus', type = 'scatter', mode = 'lines', 
                                 line = list(color = '000033', width = 2))
fig_EEU <- fig_EEU %>% add_lines(data=POL, x = ~Year, y = ~Annual.COâ...emissions,
                                 name = 'Poland', type = 'scatter', mode = 'lines', 
                                 line = list(color = 'ff0033', width = 2))
fig_EEU <- fig_EEU %>% add_lines(data=BGR, x = ~Year, y = ~Annual.COâ...emissions,
                                 name = 'Bulgaria', type = 'scatter', mode = 'lines', 
                                 line = list(color = '660000', width = 2))
fig_EEU <- fig_EEU %>% layout(title = "Annual CO2 emissions- Eastern Europe",
                            xaxis = list(title = "Year"), 
                            yaxis = list (title = "CO2 emissions in tonnes"))
fig_WEU
fig_EEU

# Function to print the c02 emissions in 1990, the forecasted emissions in 2030
# and the reduction compared to 1990 for the country and for the EU
Ratio <- function(model, co2_EU1990) {

  co2_1990 = model$x[21]
  co2_mean = model$mean[9]
  co2_80 = model$lower[9,1]
  co2_95 = model$lower[9,2]
  co2_reduction = co2_1990 - co2_mean
  
  ratio_mean = (co2_reduction/co2_1990) * 100
  ratio_EU = (co2_reduction/co2_EU1990) * 100
  
  print(paste("1990 emissions:", co2_1990))
  print(paste("Forecasted mean emissions:", format(round(co2_mean))))
  print(paste("Forecasted emissions (80% C.I):", format(round(co2_80))))
  print(paste("Forecasted emissions (95% C.I):", format(round(co2_95))))
  print(paste("Reduction with forecasted mean emission:", format(round(as.numeric(ratio_mean),2)),"%"))
  print(paste("EU reduction:", format(round(as.numeric(ratio_EU),2)),"%"))
  
}

# Arima Forecast

# Sum of the singular reductions compared to 1990's level = 38.86%
#### ITALY ####
# 1990 emissions: 439,549,820
# Forecasted mean emissions: 267,748,471
# Reduction with forecasted mean emission: 39.09 %
# EU reduction:4.44 %

arima_ITA <- Arima(co2_ITA, order=c(0,2,2))
arima_ITA # AIC=1810.51   AICc=1811.04   BIC=1816.25

fit_arima <- fitted(arima_ITA)
autoplot(co2_ITA, size=1) + labs(title="ARIMA(0,2,2)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 50000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_ITA), co2_ITA) * 100 # 3.116876
checkresiduals(arima_ITA)

forecast_ITA = forecast(arima_ITA, h=9)
autoplot(forecast_ITA) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 50000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_ITA[21], lty=3)

Ratio(forecast_ITA, co2_EU1990)

#### FRANCE ####
# 1990 emissions: 393,422,900
# Forecasted mean emissions: 277,696,121
# Reduction with forecasted mean emission: 29.42 %
# EU reduction: 2.99 %

arima_FRA <- Arima(co2_FRA, order=c(0,1,1), include.drift = TRUE)
arima_FRA # AIC=1855.21   AICc=1855.72   BIC=1861.01

fit_arima <- fitted(arima_FRA)
autoplot(co2_FRA, size=1) + labs(title="ARIMA(0,1,1) with drift", x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 50000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_FRA), co2_FRA) * 100 # 3.272165
checkresiduals(arima_FRA)

forecast_FRA = forecast(arima_FRA, h=9)
autoplot(forecast_FRA) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 50000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_FRA[21], lty=3)

Ratio(forecast_FRA, co2_EU1990)

#### GERMANY ####
# 1990 emissions: 1,051,979,140
# Forecasted mean emissions: 484,224,219
# Reduction with forecasted mean emission: 53.97 %
# EU reduction: 14.69 %

arima_GER <- Arima(co2_GER, order=c(0,2,4))
arima_GER # 1874.81   AICc=1876.17   BIC=1884.37

fit_arima <- fitted(arima_GER)
autoplot(co2_GER, size=1) + labs(title="ARIMA(0,2,4)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1400000000, 100000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_GER), co2_GER) * 100 # 2.246805
checkresiduals(arima_GER)

forecast_GER = forecast(arima_GER, h=9)
autoplot(forecast_GER) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1400000000, 100000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_GER[21], lty=3)

Ratio(forecast_GER, co2_EU1990)

#### SPAIN ####
# 1990 emissions: 231,328,450
# Forecasted mean emissions: 185,515,975
# Reduction with forecasted mean emission: 19.8 %
# EU reduction: 1.19 %

Acf(diff(co2_SPA,differences = 2))

arima_SPA <- Arima(co2_SPA, order=c(0,2,1))
arima_SPA # AIC=1798.05   AICc=1798.3   BIC=1801.87

fit_arima <- fitted(arima_SPA)
autoplot(co2_SPA, size=1) + labs(title="ARIMA(0,2,1)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 50000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_SPA), co2_SPA) * 100 # 4.254139
checkresiduals(arima_SPA)

forecast_SPA = forecast(arima_SPA, h=9)
autoplot(forecast_SPA, co2_EU1990) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 50000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_SPA[21], lty=3)

Ratio(forecast_SPA, co2_EU1990)

#### PORTUGAL ####
# 1990 emissions: 45,325,084
# Forecasted mean emissions: 25,867,569
# Reduction with forecasted mean emission: 42.93 %
# EU reduction: 0.5 %

arima_PRT <- Arima(co2_PRT, order=c(0,2,1))
arima_PRT # AIC=1639.41   AICc=1639.67   BIC=1643.23

fit_arima <- fitted(arima_PRT)
autoplot(co2_PRT, size=1) + labs(title="ARIMA(0,2,1)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 20000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_PRT), co2_PRT) * 100 # 4.779858
checkresiduals(arima_PRT)

forecast_PRT = forecast(arima_PRT, h=9)
autoplot(forecast_PRT) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 20000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_PRT[21], lty=3)

Ratio(forecast_PRT, co2_EU1990)

#### DENMARK ####
# 1990 emissions: 53,584,856
# Forecasted mean emissions: 19,201,140
# Reduction with forecasted mean emission: 64.17 %
# EU reduction: 0.89 %

arima_DEN <- Arima(co2_DEN, order=c(0,2,4))
arima_DEN # AIC=1684.99   AICc=1686.35   BIC=1694.55

fit_arima <- fitted(arima_DEN)
autoplot(co2_DEN, size=1) + labs(title="ARIMA(0,2,4)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_DEN), co2_DEN) * 100 # 6.001305
checkresiduals(arima_DEN)

forecast_DEN = forecast(arima_DEN, h=9)
autoplot(forecast_DEN) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_DEN[21], lty=3)

Ratio(forecast_DEN, co2_EU1990)

#### SWEDEN ####
# 1990 emissions: 57,580,090
# Forecasted mean emissions: 26,214,925
# Reduction with forecasted mean emission: 54.47 %
# EU reduction: 0.81 %

arima_SWE <- Arima(co2_SWE, order=c(0,1,1), include.drift = TRUE)
arima_SWE # AIC=1687.47   AICc=1687.98   BIC=1693.27

fit_arima <- fitted(arima_SWE)
autoplot(co2_SWE, size=1) + labs(title="ARIMA(0,1,1) with drift",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_SWE), co2_SWE) * 100 # 4.007747
checkresiduals(arima_SWE)

forecast_SWE = forecast(arima_SWE, h=9)
autoplot(forecast_SWE) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_SWE[21], lty=3)

Ratio(forecast_SWE, co2_EU1990)

#### BELGIUM ####
# 1990 emissions: 120,292,640
# Forecasted mean emissions: 90,121,190
# Reduction with forecasted mean emission: 25.08 %
# EU reduction: 0.78 %
arima_BEL <- Arima(co2_BEL, order=c(0,1,0), include.drift = TRUE)
arima_BEL # AIC=1741.05   AICc=1741.3   BIC=1744.92

fit_arima <- fitted(arima_BEL)
autoplot(co2_BEL, size=1) + labs(title="ARIMA(0,1,0) with drift",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_BEL), co2_BEL) * 100 # 3.866543

checkresiduals(arima_BEL)

forecast_BEL = forecast(arima_BEL, h=9)
autoplot(forecast_BEL) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_BEL[21], lty=3)

Ratio(forecast_BEL, co2_EU1990)

#### NETHERLANDS ####
# 1990 emissions: 161,806,910
# Forecasted mean emissions: 140,921,967
# Reduction with forecasted mean emission: 12.91 %
# EU reduction: 0.54 %
arima_NLD <- Arima(co2_NLD, order=c(1,1,0))
arima_NLD # AIC=1777.3   AICc=1777.55   BIC=1781.16

fit_arima <- fitted(arima_NLD)
autoplot(co2_NLD, size=1) + labs(title="ARIMA(1,1,0)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 20000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_NLD), co2_NLD) * 100 # 3.820147
checkresiduals(arima_NLD)

forecast_NLD = forecast(arima_NLD, h=9)
autoplot(forecast_NLD) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 25000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_NLD[21], lty=3)

Ratio(forecast_NLD, co2_EU1990)

#### LUXEMBOURG ####
# 1990 emissions: 11,823,353
# Forecasted mean emissions: 7,467,997
# Reduction with forecasted mean emission: 36.84 %
# EU reduction: 0.11 %
arima_LUX <- Arima(co2_LUX, order=c(0,2,4))
arima_LUX # AIC=1515.66   AICc=1517.02   BIC=1525.22

fit_arima <- fitted(arima_LUX)
autoplot(co2_LUX, size=1) + labs(title="ARIMA(0,2,4)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 1000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_LUX), co2_LUX) * 100 # 5.741429
checkresiduals(arima_LUX)

forecast_LUX = forecast(arima_LUX, h=9)
autoplot(forecast_LUX) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 1000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_LUX[21], lty=3)

Ratio(forecast_LUX, co2_EU1990)

#### IRELAND ####
# 1990 emissions: 32,944,420
# Forecasted mean emissions: 41,232,607
# Reduction with forecasted mean emission: -25.16 %
# EU reduction: -0.21 %
arima_IRL <- Arima(co2_IRL, order=c(1,1,0))
arima_IRL # AIC=1609.23   AICc=1609.48   BIC=1613.1

fit_arima <- fitted(arima_IRL)
autoplot(co2_IRL, size=1) + labs(title="ARIMA(1,1,0)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_IRL), co2_IRL) * 100 # 3.660761
checkresiduals(arima_IRL)

forecast_IRL = forecast(arima_IRL, h=9)
autoplot(forecast_IRL) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_IRL[21], lty=3)


Ratio(forecast_IRL, co2_EU1990)

#### MALTA ####
# 1990 emissions: 2,394,194
# Forecasted mean emissions: 1,724,154
# Reduction with forecasted mean emission: 27.99 %
# EU reduction: 0.02 %
arima_MLT <- Arima(co2_MLT, order=c(0,1,0))
arima_MLT # AIC=1395.07   AICc=1395.16   BIC=1397.01

fit_arima <- fitted(arima_MLT)
autoplot(co2_MLT, size=1) + labs(title="ARIMA(0,1,0)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 1000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_MLT), co2_MLT) * 100 # 8.994285
checkresiduals(arima_MLT)

forecast_MLT = forecast(arima_MLT, h=9)
autoplot(forecast_MLT) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 1000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_MLT[21], lty=3)

Ratio(forecast_MLT, co2_EU1990)

#### AUSTRIA #### 
# 1990 emissions: 62,145,250
# Forecasted mean emissions: 64,176,124
# Reduction with forecasted mean emission: -3.27%
# EU reduction: -0.05 %
arima_AUS <- Arima(co2_AUS, order=c(1,1,0))
arima_AUS # AIC=1680.45   AICc=1680.7   BIC=1684.31

fit_arima <- fitted(arima_AUS)
autoplot(co2_AUS, size=1) + labs(title="ARIMA(1,1,0)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_AUS), co2_AUS) * 100 # 4.172428
checkresiduals(arima_AUS)

forecast_AUS= forecast(arima_AUS, h=9)
autoplot(forecast_AUS) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_AUS[21], lty=3)

Ratio(forecast_AUS, co2_EU1990)

#### SLOVENIA ####
# 1990 emissions: 15,094,849
# Forecasted mean emissions: 10,644,058
# Reduction with forecasted mean emission: 29.49 %
# EU reduction: 0.12 %
arima_SVN <- Arima(co2_SVN, order=c(0,2,1))
arima_SVN # AIC=1503.14   AICc=1503.39   BIC=1506.96

fit_arima <- fitted(arima_SVN)
autoplot(co2_SVN, size=1) + labs(title="ARIMA(0,2,1)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 2000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_SVN), co2_SVN) * 100 # 4.09594
checkresiduals(arima_SVN)

forecast_SVN = forecast(arima_SVN, h=9)
autoplot(forecast_SVN) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 2000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_SVN[21], lty=3)

Ratio(forecast_SVN, co2_EU1990)

#### CZECHIA ####
# 1990 emissions: 164,210,750
# Forecasted mean emissions: 84,041,989
# Reduction with forecasted mean emission: 48.82 %
# EU reduction: 2.07 %
arima_CZE <- Arima(co2_CZE, order=c(0,2,1))
arima_CZE # AIC=1687.38   AICc=1687.64   BIC=1691.21

fit_arima <- fitted(arima_CZE)
autoplot(co2_CZE, size=1) + labs(title="ARIMA(0,2,1)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 25000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_CZE), co2_CZE) * 100 # 2.734977
checkresiduals(arima_CZE)

forecast_CZE = forecast(arima_CZE, h=9)
autoplot(forecast_CZE)+ labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 25000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_CZE[21], lty=3)

Ratio(forecast_CZE, co2_EU1990)

#### SLOVAKIA ####
# 1990 emissions: 61,470,188
# Forecasted mean emissions: 32,772,118
# Reduction with forecasted mean emission: 46.69 %
# EU reduction: 0.74 %
arima_SVK <- Arima(co2_SVK, order=c(0,2,2))
arima_SVK # AIC=1610.45   AICc=1610.98   BIC=1616.19

fit_arima <- fitted(arima_SVK)
autoplot(co2_SVK, size=1) + labs(title="ARIMA(0,2,2)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_SVK), co2_SVK) * 100 # 3.460293
checkresiduals(arima_SVK)

forecast_SVK = forecast(arima_SVK, h=9)
autoplot(forecast_SVK) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_SVK[21], lty=3)

Ratio(forecast_SVK, co2_EU1990)

#### POLAND ####
# 1990 emissions: 376,813,570
# Forecasted mean emissions: 335,540,459
# Reduction with forecasted mean emission: 10.95 %
# EU reduction: 1.07 %
arima_POL <- Arima(co2_POL, order=c(0,2,1))
arima_POL # AIC=1809.68   AICc=1809.94   BIC=1813.51

fit_arima <- fitted(arima_POL)
autoplot(co2_POL, size=1) + labs(title="ARIMA(0,2,1)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 50000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_POL), co2_POL) * 100 # 2.93294
checkresiduals(arima_POL)

forecast_POL = forecast(arima_POL, h=9)
autoplot(forecast_POL)+ labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 50000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_POL[21], lty=3)

Ratio(forecast_POL, co2_EU1990)

#### FINLAND ####
# 1990 emissions: 56,914,336
# Forecasted mean emissions: 22,693,106
# Reduction with forecasted mean emission: 60.13  %
# EU reduction: 0.89 %
arima_FIN <- Arima(co2_FIN, order=c(0,2,4))
arima_FIN # AIC=1687.82   AICc=1689.19   BIC=1697.38

fit_arima <- fitted(arima_FIN)
autoplot(co2_FIN, size=1) + labs(title="ARIMA(0,2,4)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_FIN), co2_FIN) * 100 # 6.875234
checkresiduals(arima_FIN)

forecast_FIN = forecast(arima_FIN, h=9)
autoplot(forecast_FIN) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_FIN[21], lty=3)

Ratio(forecast_FIN, co2_EU1990)

#### BULGARIA ####
# 1990 emissions: 76,699,190
# Forecasted mean emissions: 38,545,315
# Reduction with forecasted mean emission: 49.74 %
# EU reduction: 0.99 %
arima_BGR <- Arima(co2_BGR, order=c(0,2,1))
arima_BGR # AIC=1676.94   AICc=1677.19   BIC=1680.76

fit_arima <- fitted(arima_BGR)
autoplot(co2_BGR, size=1) + labs(title="ARIMA(0,2,1)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_BGR), co2_BGR) * 100 # 5.744118
checkresiduals(arima_BGR)

forecast_BGR = forecast(arima_BGR, h=9)
autoplot(forecast_BGR) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_BGR[21], lty=3)

Ratio(forecast_BGR, co2_EU1990)

#### ROMANIA ####
# 1990 emissions: 173,463,870
# Forecasted mean emissions: 77,926,110
# Reduction with forecasted mean emission: 55.08 %
# EU reduction: 2.47 %
arima_ROM <- Arima(co2_ROM, order=c(0,2,2))
arima_ROM # 1751.83   AICc=1752.35   BIC=1757.56

fit_arima <- fitted(arima_ROM)
autoplot(co2_ROM, size=1) + labstitle="ARIMA(0,2,2)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 50000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_ROM), co2_ROM) * 100 # 4.796937
checkresiduals(arima_ROM)

forecast_ROM = forecast(arima_ROM, h=9)
autoplot(forecast_ROM) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 50000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_ROM[21], lty=3)

Ratio(forecast_ROM, co2_EU1990)

#### GREECE ####
# 1990 emissions: 83,438,040
# Forecasted mean emissions: 24,226,542
# Reduction with forecasted mean emission: 70.96 %
# EU reduction: 1.53 %
arima_GRC <- Arima(co2_GRC, order=c(0,2,1))
arima_GRC # AIC=1651.11   AICc=1651.37   BIC=1654.94

fit_arima <- fitted(arima_GRC)
autoplot(co2_GRC, size=1) + labs(title="ARIMA(0,2,1)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) 
  
MAPE(fitted(arima_GRC), co2_GRC) * 100 # 3.626083
checkresiduals(arima_GRC)

forecast_GRC = forecast(arima_GRC, h=9)
autoplot(forecast_GRC) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 20000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_GRC[21], lty=3)

Ratio(forecast_GRC, co2_EU1990)

#### LITHUANIA ####
# 1990 emissions: 35,767,736
# Forecasted mean emissions: 13,649,469
# Reduction with forecasted mean emission: 61.84 %
# EU reduction: 0.57 %
arima_LIT <-  Arima(co2_LIT, order=c(0,2,1))
arima_LIT # AIC=1630.92   AICc=1631.17   BIC=1634.74

fit_arima <- fitted(arima_LIT)
autoplot(co2_LIT, size=1) + labs(title="ARIMA(0,2,1)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_LIT), co2_LIT) * 100 # 6.53606
checkresiduals(arima_LIT)

forecast_LIT = forecast(arima_LIT, h=9)
autoplot(forecast_LIT)+ labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_LIT[21], lty=3)

Ratio(forecast_LIT, co2_EU1990)

#### ESTONIA ####
# 1990 emissions: 36,922,216
# Forecasted mean emissions: 10,319,443
# Reduction with forecasted mean emission: 72.05 %
# EU reduction: 0.69 %
arima_EST <- Arima(co2_EST, order=c(1,1,1))
arima_EST # AIC=1638.53   AICc=1639.04   BIC=1644.32

fit_arima <- fitted(arima_EST)
autoplot(co2_EST, size=1) + labs(title="ARIMA(1,1,1)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_EST), co2_EST) * 100 # 6.966135
checkresiduals(arima_EST)

forecast_EST = forecast(arima_EST, h=9)
autoplot(forecast_EST) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_EST[21], lty=3)

Ratio(forecast_EST, co2_EU1990)

#### LATVIA ####
# 1990 emissions: 19,661,396
# Forecasted mean emissions: 7,446,016
# Reduction with forecasted mean emission: 62.13 %
# EU reduction: 0.32 %
arima_LET <- Arima(co2_LET, order=c(1,1,0))
arima_LET # AIC=1564.55   AICc=1564.8   BIC=1568.42

fit_arima <- fitted(arima_LET)
autoplot(co2_LET, size=1) + labs(title="ARIMA(1,1,0)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_LET), co2_LET) * 100 # 5.322882
checkresiduals(arima_LET)

forecast_LET = forecast(arima_LET, h=9)
autoplot(forecast_LET) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_LET[21], lty=3)

Ratio(forecast_LET, co2_EU1990)

#### HUNGARY ####
# 1990 emissions: 73,225,540
# Forecasted mean emissions: 48,669,649
# Reduction with forecasted mean emission: 33.53 %
# EU reduction: 0.64 %
arima_HUN <- Arima(co2_HUN, order=c(0,2,1))
arima_HUN # AIC=1622.32   AICc=1622.58   BIC=1626.15

fit_arima <- fitted(arima_HUN)
autoplot(co2_HUN, size=1) + labs(title="ARIMA(0,2,1)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_HUN), co2_HUN) * 100 # 3.04476
checkresiduals(arima_HUN)

forecast_HUN = forecast(arima_HUN, h=9)
autoplot(forecast_HUN) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 10000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_HUN[21], lty=3)

Ratio(forecast_HUN, co2_EU1990)

#### CROAZIA ####
# 1990 emissions: 22,979,790
# Forecasted mean emissions: 17,657,836
# Reduction with forecasted mean emission: 23.16 %
# EU reduction: 0.14 %
arima_CRO <- Arima(co2_CRO, order=c(0,1,1))
arima_CRO # AIC=1535.76   AICc=1536.29   BIC=1541.43

fit_arima <- fitted(arima_CRO)
autoplot(co2_CRO, size=1) + labs(title="ARIMA(0,1,1)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 5000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_CRO), co2_CRO) * 100 # 4.741768
checkresiduals(arima_CRO)

forecast_CRO = forecast(arima_CRO, h=9)
autoplot(forecast_CRO) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 5000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_CRO[21], lty=3)

Ratio(forecast_CRO, co2_EU1990)

#### CYPRUS ####
# 1990 emissions: 4,653,217
# Forecasted mean emissions: 7,830,826
# Reduction with forecasted mean emission: -68.29 %
# EU reduction: -0.08 %
arima_CYP <- Arima(co2_CYP, order=c(1,1,0))
arima_CYP # AIC=1425.81   AICc=1426.06   BIC=1429.67

fit_arima <- fitted(arima_CYP)
autoplot(co2_CYP, size=1) + labs(title="ARIMA(1,1,0)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 1000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_CYP), co2_CYP) * 100 # 5.112095
checkresiduals(arima_CYP)

forecast_CYP = forecast(arima_CYP, h=9)
autoplot(forecast_CYP) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 1000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_CYP[21], lty=3)

Ratio(forecast_CYP, co2_EU1990)

#### EUROPEAN UNION ####
# 1990 emissions: 3,865,491,700
# Forecasted mean emissions: 2,393,789,888
# Reduction with forecasted mean emission: 38.07 %
arima_EU <- Arima(co2_EU, order=c(0,2,1))
arima_EU # AIC=1996.05   AICc=1996.31   BIC=1999.88

fit_arima <- fitted(arima_EU)
autoplot(co2_EU, size=1) + labs(title="ARIMA(0,2,1)",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 4000000000, 500000000), labels=unit_format(unit = "B", scale = 1e-9)) 

MAPE(fitted(arima_EU), co2_EU) * 100 # 2.248944
checkresiduals(arima_EU)

forecast_EU = forecast(arima_EU, h=9)
autoplot(forecast_EU) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 4000000000, 500000000), labels=unit_format(unit = "B", scale = 1e-9)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_EU[21], lty=3)

Ratio(forecast_EU, co2_EU1990)

#### UNITED KINGDOM (just in case) ####
# 1990 emissions: 601,945,100
# Forecasted mean emissions: 292,807,753
# Reduction with forecasted mean emission: 51.36 %
arima_GBR <- Arima(co2_GBR, order=c(0,1,0), include.drift = TRUE)
arima_GBR

fit_arima <- fitted(arima_GBR)
autoplot(co2_GBR, size=1) + labs(title="ARIMA(0,1,0) with drift",x = 'Year', y = "Annual co2 Emissions") +
  geom_line(aes(y = fit_arima), col=2) +
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 50000000), labels=unit_format(unit = "M", scale = 1e-6)) 

MAPE(fitted(arima_GBR), co2_GBR) * 100
checkresiduals(arima_GBR)

forecast_GBR = forecast(arima_GBR, h=9)
autoplot(forecast_GBR) + labs(x = 'Year', y = "Annual co2 Emissions") + 
  scale_x_continuous(breaks = seq(1970, 2030 , 10)) +
  scale_y_continuous(breaks = seq(0, 1000000000, 50000000), labels=unit_format(unit = "M", scale = 1e-6)) +
  geom_vline(xintercept = 1990, lty=3) + geom_hline(yintercept=co2_GBR[21], lty=3)

Ratio(forecast_GBR, co2_EU1990)

