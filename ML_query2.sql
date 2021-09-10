
SELECT date,
    new_cases_smoothed
      
FROM
    `loppuprojekti-325208.testidata.covid_data_machine_learning`
WHERE
    location = "France"
    AND date BETWEEN '2021-06-28T00:00:00' AND '2021-07-27T00:00:00'
ORDER BY 
    date