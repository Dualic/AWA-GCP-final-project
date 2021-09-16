from google.cloud import bigquery
from google.cloud import storage
from google.cloud import logging

def upload_to_bq(request):
    try:
        client = bigquery.Client()

        table_id = "loppuprojekti-325208.testidata.Currency-data"

        job_config = bigquery.LoadJobConfig(
            
            skip_leading_rows=1
        )
        job_config.write_disposition = 'WRITE_TRUNCATE'
        uri = "gs://currency_csv_bucket/history.csv"

        load_job = client.load_table_from_uri(
            uri, table_id, job_config=job_config
        )  

        load_job.result()  

        destination_table = client.get_table(table_id)  
        print("Loaded {} rows.".format(destination_table.num_rows))
        return 'success'
    except:
        logger_name = "logger_1"
        logging_client = logging.Client()
        logger = logging_client.logger(logger_name)
        logger.log_text("bq-transfer function failed!", severity="ERROR")
        return 'failed'