from google.cloud import storage
import requests
from datetime import date
import json
from google.cloud import logging


def currency_today(request):
    try:
        #today:
        date_now = date.today()
        todays_date = date_now.strftime("%Y-%m-%d")
        print("todaysdate on", todays_date)
        
        #get the data:
        url = f'https://api.exchangerate.host/{todays_date}'
        response = requests.get(url)
        data = response.json()

        #storagebucket:
        # The ID of your GCS bucket (test names are being used, bucket name to be updated)
        bucket_name1 = "currency-raw-data-json"
        bucket_name2 = "currency-archive"
        # The ID of your GCS object
        destination_blob_name1 = "todayscurrencydata.json"
        destination_blob_name2 = "todayscurrencydata{}.json".format(date_now)
        
        data2 = json.dumps(data)

        #save data to storage bucket
        storage_client = storage.Client()

        bucket1 = storage_client.bucket(bucket_name1)
        blob1 = bucket1.blob(destination_blob_name1)
        blob1.upload_from_string(data2, content_type='application/json')

        bucket2 = storage_client.bucket(bucket_name2)
        blob2 = bucket2.blob(destination_blob_name2)
        blob2.upload_from_string(data2, content_type='application/json')
        
        return 'success'
    except:
        logger_name = "logger_1"
        logging_client = logging.Client()
        logger = logging_client.logger(logger_name)
        logger.log_text("todays-currencies function failed", severity="ERROR")
        return 'failed'