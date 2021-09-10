
SELECT 
    EXTRACT(DATE FROM forecast.date) AS date,
    stringency_index,
    new_vaccinations_smoothed,
    new_tests_smoothed,
    new_deaths,
    icu_patients,
    new_cases_smoothed,
    USD

FROM 
`loppuprojekti-325208.testidata.covid_data_machine_learning` AS forecast 

JOIN 
`loppuprojekti-325208.testidata.currency_test_dfi2` AS training
ON
forecast.date = training.date 
WHERE
    iso_code = "USA"
    AND forecast.date BETWEEN '2021-01-01' AND '2021-09-06'
GROUP BY
    stringency_index,
    new_vaccinations_smoothed,
    new_tests_smoothed,
    new_deaths,
    icu_patients,
    hosp_patients,
    new_cases_smoothed,
    forecast.date,
    USD
