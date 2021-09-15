CREATE or REPLACE MODEL ML_test_1.ML_global_forecast
OPTIONS(
    model_type='ARIMA_PLUS', 
    time_series_timestamp_col='date',
    time_series_data_col='people_fully_vaccinated_per_hundred',
    time_series_id_col='location',
    horizon = 30,
    auto_arima = TRUE,
    auto_arima_max_order = 5,
    data_frequency = 'daily') AS


      SELECT 
    
      date,
      people_fully_vaccinated_per_hundred,
      location
 
FROM
    `loppuprojekti-325208.testidata.covid_data_machine_learning`
WHERE
    
    date BETWEEN '2021-01-01T00:00:00' AND '2021-09-06T00:00:00'