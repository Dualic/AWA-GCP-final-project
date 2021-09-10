
SELECT 
    stringency_index,
    new_vaccinations_smoothed,
    new_tests_smoothed,
    new_deaths,
    icu_patients,
    hosp_patients,
    new_cases_smoothed,
    EXTRACT(DATE FROM forecast.date) AS forecast.date,
    USD
FROM 
`loppuprojekti-325208.ML_test_1.ML_global_forecast_results` AS forecast 

JOIN 
`loppuprojekti-325208.testidata.covid_data_machine_learning` AS training
ON
forecast.date = training.date 
GROUP BY
    stringency_index,
    new_vaccinations_smoothed,
    new_tests_smoothed,
    new_deaths,
    icu_patients,
    hosp_patients,
    new_cases_smoothed,
    forecast.date
    USD


WHERE
    iso_code = "USA"
    AND date BETWEEN '2021-01-01' AND '2021-09-06'



