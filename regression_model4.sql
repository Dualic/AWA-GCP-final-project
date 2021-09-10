CREATE or REPLACE MODEL ML_test_1.thai1_model
OPTIONS
  (model_type='linear_reg', labels=['THB']) AS 
      SELECT 
      stringency_index,
      new_vaccinations_smoothed,
      new_tests_smoothed,
      new_deaths,
      icu_patients,
      new_cases_smoothed,
      THB
 
FROM `loppuprojekti-325208.ML_test_1.thai1_model`
    
WHERE
    date BETWEEN '2021-01-01' AND '2021-09-06'
