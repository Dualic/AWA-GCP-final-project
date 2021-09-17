resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "Covid_Currency"
  description                 = "Potential correlation between covid and currencies"
  location                    = "US"
  project = var.project

  /* access {
    role          = "OWNER" #selvitä mikä best practice
    group_by_email = #tee ryhmä ml-tiimille
  }
  access {
    role = "VIEWER" #pipelinelle omat jutut ym., lisää access-lohkoja tarvittaessa
    group_by_email = #tee ryhmä pipeline-tiimille
  } */

}

resource "google_bigquery_dataset" "error_dataset" {
  dataset_id                  = "errorhistory"
  description                 = "Logs sink"
  location                    = "US"
  project = var.project
}

resource "google_bigquery_table" "covid-table" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "Covid-data"
  #bq show --format=prettyjson loppuprojekti-325208:testidata.covid_data_machine_learning | jq '.schema.fields'
  #tähän tapaan vaikka public datasetistä kamaa
  schema = <<EOF
[
  {
    "name": "iso_code",
    "type": "STRING"
  },
  {
    "name": "continent",
    "type": "STRING"
  },
  {
    "name": "location",
    "type": "STRING"
  },
  {
    "name": "date",
    "type": "DATETIME"
  },
  {
    "name": "total_cases",
    "type": "FLOAT"
  },
  {
    "name": "new_cases",
    "type": "FLOAT"
  },
  {
    "name": "new_cases_smoothed",
    "type": "FLOAT"
  },
  {
    "name": "total_deaths",
    "type": "FLOAT"
  },
  {
    "name": "new_deaths",
    "type": "FLOAT"
  },
  {
    "name": "new_deaths_smoothed",
    "type": "FLOAT"
  },
  {
    "name": "total_cases_per_million",
    "type": "FLOAT"
  },
  {
    "name": "new_cases_per_million",
    "type": "FLOAT"
  },
  {
    "name": "new_cases_smoothed_per_million",
    "type": "FLOAT"
  },
  {
    "name": "total_deaths_per_million",
    "type": "FLOAT"
  },
  {
    "name": "new_deaths_per_million",
    "type": "FLOAT"
  },
  {
    "name": "new_deaths_smoothed_per_million",
    "type": "FLOAT"
  },
  {
    "name": "reproduction_rate",
    "type": "FLOAT"
  },
  {
    "name": "icu_patients",
    "type": "FLOAT"
  },
  {
    "name": "icu_patients_per_million",
    "type": "FLOAT"
  },
  {
    "name": "hosp_patients",
    "type": "FLOAT"
  },
  {
    "name": "hosp_patients_per_million",
    "type": "FLOAT"
  },
  {
    "name": "weekly_icu_admissions",
    "type": "FLOAT"
  },
  {
    "name": "weekly_icu_admissions_per_million",
    "type": "FLOAT"
  },
  {
    "name": "weekly_hosp_admissions",
    "type": "FLOAT"
  },
  {
    "name": "weekly_hosp_admissions_per_million",
    "type": "FLOAT"
  },
  {
    "name": "new_tests",
    "type": "FLOAT"
  },
  {
    "name": "total_tests",
    "type": "FLOAT"
  },
  {
    "name": "total_tests_per_thousand",
    "type": "FLOAT"
  },
  {
    "name": "new_tests_per_thousand",
    "type": "FLOAT"
  },
  {
    "name": "new_tests_smoothed",
    "type": "FLOAT"
  },
  {
    "name": "new_tests_smoothed_per_thousand",
    "type": "FLOAT"
  },
  {
    "name": "positive_rate",
    "type": "FLOAT"
  },
  {
    "name": "tests_per_case",
    "type": "FLOAT"
  },
  {
    "name": "tests_units",
    "type": "STRING"
  },
  {
    "name": "total_vaccinations",
    "type": "FLOAT"
  },
  {
    "name": "people_vaccinated",
    "type": "FLOAT"
  },
  {
    "name": "people_fully_vaccinated",
    "type": "FLOAT"
  },
  {
    "name": "total_boosters",
    "type": "FLOAT"
  },
  {
    "name": "new_vaccinations",
    "type": "FLOAT"
  },
  {
    "name": "new_vaccinations_smoothed",
    "type": "FLOAT"
  },
  {
    "name": "total_vaccinations_per_hundred",
    "type": "FLOAT"
  },
  {
    "name": "people_vaccinated_per_hundred",
    "type": "FLOAT"
  },
  {
    "name": "people_fully_vaccinated_per_hundred",
    "type": "FLOAT"
  },
  {
    "name": "total_boosters_per_hundred",
    "type": "FLOAT"
  },
  {
    "name": "new_vaccinations_smoothed_per_million",
    "type": "FLOAT"
  },
  {
    "name": "stringency_index",
    "type": "FLOAT"
  },
  {
    "name": "population",
    "type": "FLOAT"
  },
  {
    "name": "population_density",
    "type": "FLOAT"
  },
  {
    "name": "median_age",
    "type": "FLOAT"
  },
  {
    "name": "aged_65_older",
    "type": "FLOAT"
  },
  {
    "name": "aged_70_older",
    "type": "FLOAT"
  },
  {
    "name": "gdp_per_capita",
    "type": "FLOAT"
  },
  {
    "name": "extreme_poverty",
    "type": "FLOAT"
  },
  {
    "name": "cardiovasc_death_rate",
    "type": "FLOAT"
  },
  {
    "name": "diabetes_prevalence",
    "type": "FLOAT"
  },
  {
    "name": "female_smokers",
    "type": "FLOAT"
  },
  {
    "name": "male_smokers",
    "type": "FLOAT"
  },
  {
    "name": "handwashing_facilities",
    "type": "FLOAT"
  },
  {
    "name": "hospital_beds_per_thousand",
    "type": "FLOAT"
  },
  {
    "name": "life_expectancy",
    "type": "FLOAT"
  },
  {
    "name": "human_development_index",
    "type": "FLOAT"
  },
  {
    "name": "excess_mortality",
    "type": "FLOAT"
  }
]
EOF
}

resource "google_bigquery_table" "currency-table" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "Currency-data"
  #bq show --format=prettyjson loppuprojekti-325208:testidata.mikolleskeema | jq '.schema.fields'
  schema = <<EOF
[
  {
    "mode": "NULLABLE",
    "name": "date",
    "type": "DATE"
  },
  {
    "mode": "NULLABLE",
    "name": "AED",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "AFN",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "ALL",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "AMD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "ANG",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "AOA",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "ARS",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "AUD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "AWG",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "AZN",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BAM",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BBD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BDT",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BGN",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BHD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BIF",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BMD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BND",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BOB",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BRL",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BSD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BTC",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BTN",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BWP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BYN",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "BZD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "CAD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "CDF",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "CHF",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "CLF",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "CLP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "CNH",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "CNY",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "COP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "CRC",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "CUC",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "CUP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "CVE",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "CZK",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "DJF",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "DKK",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "DOP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "DZD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "EGP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "ERN",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "ETB",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "EUR",
    "type": "INTEGER"
  },
  {
    "mode": "NULLABLE",
    "name": "FJD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "FKP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "GBP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "GEL",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "GGP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "GHS",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "GIP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "GMD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "GNF",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "GTQ",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "GYD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "HKD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "HNL",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "HRK",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "HTG",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "HUF",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "IDR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "ILS",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "IMP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "INR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "IQD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "IRR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "ISK",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "JEP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "JMD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "JOD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "JPY",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "KES",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "KGS",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "KHR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "KMF",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "KPW",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "KRW",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "KWD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "KYD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "KZT",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "LAK",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "LBP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "LKR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "LRD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "LSL",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "LYD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MAD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MDL",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MGA",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MKD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MMK",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MNT",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MOP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MRO",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MRU",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MUR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MVR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MWK",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MXN",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MYR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "MZN",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "NAD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "NGN",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "NIO",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "NOK",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "NPR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "NZD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "OMR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "PAB",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "PEN",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "PGK",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "PHP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "PKR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "PLN",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "PYG",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "QAR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "RON",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "RSD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "RUB",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "RWF",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "SAR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "SBD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "SCR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "SDG",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "SEK",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "SGD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "SHP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "SLL",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "SOS",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "SRD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "SSP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "STD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "STN",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "SVC",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "SYP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "SZL",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "THB",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "TJS",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "TMT",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "TND",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "TOP",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "TRY",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "TTD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "TWD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "TZS",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "UAH",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "UGX",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "USD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "UYU",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "UZS",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "VES",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "VND",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "VUV",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "WST",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "XAF",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "XAG",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "XAU",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "XCD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "XDR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "XOF",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "XPD",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "XPF",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "XPT",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "YER",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "ZAR",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "ZMW",
    "type": "FLOAT"
  },
  {
    "mode": "NULLABLE",
    "name": "ZWL",
    "type": "FLOAT"
  }
  ]
  EOF
}