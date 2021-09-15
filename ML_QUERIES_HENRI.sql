#MAKES ARIMA-MODELS

CREATE or REPLACE MODEL ML_test_1.new_deaths_smoothed_per_million_prod
OPTIONS(
    model_type='ARIMA_PLUS', 
    time_series_timestamp_col='date',
    time_series_data_col='new_deaths_smoothed_per_million',
    time_series_id_col='location',
    horizon = 30,
    auto_arima = TRUE,
    auto_arima_max_order = 5,
    data_frequency = 'daily') AS


      SELECT 
    
      date,
      new_deaths_smoothed_per_million,
      location
 
FROM
    `loppuprojekti-325208.testidata.coviddata`
WHERE
date >= '2021-01-01'
AND new_deaths_smoothed_per_million >= 0

CREATE or REPLACE MODEL ML_test_1.new_cases_smoothed_per_million_prod
OPTIONS(
    model_type='ARIMA_PLUS', 
    time_series_timestamp_col='date',
    time_series_data_col='new_cases_smoothed_per_million',
    time_series_id_col='location',
    horizon = 30,
    auto_arima = TRUE,
    auto_arima_max_order = 5,
    data_frequency = 'daily') AS


      SELECT 
    
      date,
      new_cases_smoothed_per_million,
      location
 
FROM
    `loppuprojekti-325208.testidata.coviddata`
WHERE
date >= '2021-01-01'
AND new_cases_smoothed_per_million >= 0

CREATE or REPLACE MODEL ML_test_1.people_fully_vaccinated_prod
OPTIONS(
    model_type='ARIMA_PLUS', 
    time_series_timestamp_col='date',
    time_series_data_col='people_fully_vaccinated',
    time_series_id_col='location',
    horizon = 30,
    auto_arima = TRUE,
    auto_arima_max_order = 5,
    data_frequency = 'daily') AS


      SELECT 
    
      date,
      people_fully_vaccinated,
      location
 
FROM
    `loppuprojekti-325208.testidata.coviddata`
WHERE
date >= '2021-01-01'
AND people_fully_vaccinated IS NOT NULL

CREATE or REPLACE MODEL ML_test_1.stringency_index_prod
OPTIONS(
    model_type='ARIMA_PLUS', 
    time_series_timestamp_col='date',
    time_series_data_col='stringency_index',
    time_series_id_col='location',
    horizon = 30,
    auto_arima = TRUE,
    auto_arima_max_order = 5,
    data_frequency = 'daily') AS


      SELECT 
    
      date,
      stringency_index,
      location
 
FROM
    `loppuprojekti-325208.testidata.coviddata`
WHERE
date >= '2021-01-01'


#MAKES FORECASTS FROM ARIMA-MODELS

SELECT 
location, 
forecast_timestamp as date,  
(case when forecast_value < 0 then 0 else forecast_value  end) AS new_cases_smoothed_per_million
FROM 
ML.FORECAST(MODEL `loppuprojekti-325208.ML_test_1.new_cases_smoothed_per_million_prod`, STRUCT(30 AS horizon, 0.90 AS confidence_level))

SELECT 
location, 
forecast_timestamp as date,  
(case when forecast_value < 0 then 0 else forecast_value  end) AS new_deaths_smoothed_per_million
FROM 
ML.FORECAST(MODEL `loppuprojekti-325208.ML_test_1.new_deaths_smoothed_per_million_prod`, STRUCT(30 AS horizon, 0.90 AS confidence_level))

SELECT 
location, 
forecast_timestamp as date,  
(case when forecast_value < 0 then 0 else forecast_value  end) AS people_fully_vaccinated_per_hundred
FROM 
ML.FORECAST(MODEL `loppuprojekti-325208.ML_test_1.people_fully_vaccinated_per_hundred_prod`, STRUCT(30 AS horizon, 0.90 AS confidence_level))

SELECT 
location, 
forecast_timestamp as date,  
(case when forecast_value < 0 then 0 else forecast_value  end) AS stringency_index
FROM 
ML.FORECAST(MODEL `loppuprojekti-325208.ML_test_1.stringency_index_prod`, STRUCT(30 AS horizon, 0.90 AS confidence_level))

#MAKE TABLE FROM FORECASTS

SELECT cases.location, cases.date, new_cases_smoothed_per_million, new_deaths_smoothed_per_million, people_fully_vaccinated_per_hundred, stringency_index, travel_index  
FROM `loppuprojekti-325208.ML_test_1.forecast_new_cases_smoothed_per_million` AS cases
JOIN `loppuprojekti-325208.ML_test_1.forecast_new_deaths_smoothed_per_million` AS deaths ON cases.location = deaths.location AND cases.date = deaths.date
JOIN `loppuprojekti-325208.ML_test_1.forecast_people_fully_vaccinated_per_hundred` AS vaccinations ON cases.location = vaccinations.location AND cases.date = vaccinations.date
JOIN `loppuprojekti-325208.ML_test_1.forecast_stringency_index` AS stringency ON cases.location = stringency.location AND cases.date = stringency.date
GROUP BY 
cases.location,
cases.date,
new_cases_smoothed_per_million,
new_deaths_smoothed_per_million,
people_fully_vaccinated_per_hundred,
stringency_index

#MAKE INDEX

SELECT
location,
date,
normalized_cases*0.2+normalized_deaths*0.2+normalized_stringency_index*0.1+normalized_vaccinatedfully*0.5 as travel_index
FROM(SELECT
date,
location,
new_cases_smoothed_per_million,
 1-(new_cases_smoothed_per_million-Minnew_cases_smoothed_per_million)/new_cases_smoothed_per_millionRange as normalized_cases,
new_deaths_smoothed_per_million,
 1-(new_deaths_smoothed_per_million-Minnew_deaths_smoothed_per_million)/new_deaths_smoothed_per_millionRange as normalized_deaths,
 people_fully_vaccinated_per_hundred,
 (people_fully_vaccinated_per_hundred-Minpeople_fully_vaccinated_per_hundred)/people_fully_vaccinated_per_hundredRange as normalized_vaccinatedfully,
 stringency_index,
 1-(stringency_index-Minstringency_index)/stringency_indexRange as normalized_stringency_index,
FROM
(SELECT
date,
location,
new_cases_smoothed_per_million,
MIN(new_cases_smoothed_per_million) OVER () AS Minnew_cases_smoothed_per_million,
MAX(new_cases_smoothed_per_million) OVER () - MIN(new_cases_smoothed_per_million) OVER () AS new_cases_smoothed_per_millionRange,
new_deaths_smoothed_per_million,
MIN(new_deaths_smoothed_per_million) OVER () AS Minnew_deaths_smoothed_per_million,
MAX(new_deaths_smoothed_per_million) OVER () - MIN(new_deaths_smoothed_per_million) OVER () AS new_deaths_smoothed_per_millionRange,
people_fully_vaccinated_per_hundred,
MIN(people_fully_vaccinated_per_hundred) OVER () AS Minpeople_fully_vaccinated_per_hundred,
MAX(people_fully_vaccinated_per_hundred) OVER () - MIN(people_fully_vaccinated_per_hundred) OVER () AS people_fully_vaccinated_per_hundredRange,
stringency_index,
MIN(stringency_index) OVER () AS Minstringency_index,
MAX(stringency_index) OVER () - MIN(stringency_index) OVER () AS stringency_indexRange

      
FROM`loppuprojekti-325208.ML_test_1.forecasts_and_index_table`
GROUP BY 
date,
location,
new_cases_smoothed_per_million,
new_deaths_smoothed_per_million,
people_fully_vaccinated_per_hundred,
stringency_index
))

#MAKE END TABLE

SELECT cases.location, cases.date, new_cases_smoothed_per_million, new_deaths_smoothed_per_million, people_fully_vaccinated_per_hundred, stringency_index, travel_index  
FROM `loppuprojekti-325208.ML_test_1.forecast_new_cases_smoothed_per_million` AS cases
JOIN `loppuprojekti-325208.ML_test_1.forecast_new_deaths_smoothed_per_million` AS deaths ON cases.location = deaths.location AND cases.date = deaths.date
JOIN `loppuprojekti-325208.ML_test_1.forecast_people_fully_vaccinated_per_hundred` AS vaccinations ON cases.location = vaccinations.location AND cases.date = vaccinations.date
JOIN `loppuprojekti-325208.ML_test_1.forecast_stringency_index` AS stringency ON cases.location = stringency.location AND cases.date = stringency.date
JOIN `loppuprojekti-325208.ML_test_1.forecast_travel_index_fixed_weights` AS index  ON cases.location = index.location AND cases.date = index.date
GROUP BY 
cases.location,
cases.date,
new_cases_smoothed_per_million,
new_deaths_smoothed_per_million,
people_fully_vaccinated_per_hundred,
stringency_index,
travel_index 
