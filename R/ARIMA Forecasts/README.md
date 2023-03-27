# ARIMA forecasts on EU CO2 emissions

This project aims to forecast the CO2 emissions of the EU states using the Autoregressive Integrated Moving Average (ARIMA) model. 
The data used for this analysis is sourced from Our World in Data and consists of the CO2 emissions of every country from 1750 to 2021.

The primary objective of the analysis is to predict whether the EU countries can reduce their emissions by 55% w.r.t their CO2 emissions in 1990,
as per the "Fit for 55" goal set by the European Union.

## Analysis Steps
 
The first step is to perform data cleaning and preparation by selecting only the time series related to the 27 members of the European Union. 

The time series will start in 1970 for two reasons: avoid missing values and analyzing only the period affected by agreements and protocol against climate 
change, as the first United Nations conference on the human environment happened in 1972. 

Finally, we make predictions for the future 9 years using ARIMA models.

## Conclusion
The analysis showed that the ARIMA model could accurately forecast the CO2 emissions of the EU member states and the EU as a whole. 
The forecasts suggested that the EU countries may not be able to achieve the 55% reduction target by 2030, based on their current emissions trends.

However, this project only considers the historical data and does not take into account any future policies or changes that may affect CO2 emissions, 
therefore, the 55% objective could still be achieved with targeted policies and interventions.
