#cloud logging routers filtterit:


#cloud logging haku sinkiä varten. sink: pub/sub "workflow-errors"
resource.labels.function_name: currency-history
OR resource.labels.function_name: currency-history-to-csv
AND severity >= WARNING

#cloud logging haku sinkiä varten
# sink: bigquery dataset "errorhistory"
resource.labels.function_name: todays-currencies
OR resource.labels.function_name: daily-to-history
OR resource.labels.function_name: bq-transfer
OR resource.labels.function_name: delete-func
AND severity >= WARNING

#covid functioiden logging errorit
# 1. sink:pubsub topic "covid-functions-errors-topic"
# 2. sink: bigquery dataset "errorhistory"
resource.labels.function_name: get-covid-latest
OR resource.labels.function_name: LatestCovidDatatoBigQueryTriggerFunction
OR resource.labels.function_name: get-covid-history
OR resource.labels.function_name: CovidHistoryDatatoBigQueryTriggerFunction
AND severity >= WARNING
