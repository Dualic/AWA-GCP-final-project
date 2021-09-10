CREATE or REPLACE MODEL ML_test_1.us1_model
OPTIONS
  (model_type='linear_reg', labels=['USD']) AS 
      SELECT 
      stringency_index,
      new_vaccinations_smoothed,
      new_tests_smoothed,
      new_deaths,
      icu_patients,
      new_cases_smoothed,
      USD
 
FROM `loppuprojekti-325208.ML_test_1.Combined_US_covid_and_currency_data`
    
WHERE
    date BETWEEN '2021-01-01' AND '2021-08-01'
