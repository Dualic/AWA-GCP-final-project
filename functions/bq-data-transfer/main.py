from google.cloud import bigquery
from google.cloud import storage

def upload_to_bq(request):

    client = bigquery.Client()

    table_id = "loppuprojekti-325208.Covid_Currency.Currency-data"

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