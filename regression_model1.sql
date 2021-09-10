CREATE or REPLACE MODEL ML_test_1.fra1_model
OPTIONS
  (model_type='linear_reg', labels=['new_cases_smoothed']) AS 
      SELECT 
      stringency_index,
      new_vaccinations_smoothed,
      new_tests_smoothed,
      new_deaths,
      icu_patients,
      hosp_patients,
      new_cases_smoothed
 
FROM
    `loppuprojekti-325208.testidata.covid_data_machine_learning`
WHERE
    location = "France"
    AND date BETWEEN '2021-01-01T00:00:00' AND '2021-06-27T00:00:00'