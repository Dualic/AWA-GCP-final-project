from google.cloud import storage
from datetime import date
import requests
import json

def currency_history(request):

    start_date = "2021-01-01"
    #today:
    date_now = date.today()
    end_date = date_now.strftime("%Y-%m-%d")
    
    #get the data:
    url = f'https://api.exchangerate.host/timeseries?start_date={start_date}&end_date={end_date}'
    response = requests.get(url)
    data = response.json()

    #storagebucket:
    # The ID of your GCS bucket (test names are being used, bucket name to be updated)
    bucket_name1 = "currency-raw-data-json"
    bucket_name2 = "currency-archive"
    # The ID of your GCS object
    destination_blob_name1 = "currency-history.json"
    destination_blob_name2 = "currency-history{}.json".format(date_now)
    #tallennetaan data storagebukettiin
    data2 = json.dumps(data)

    storage_client = storage.Client()

    bucket1 = storage_client.bucket(bucket_name1)
    blob1 = bucket1.blob(destination_blob_name1)
    blob1.upload_from_string(data2, content_type='application/json')

    bucket2 = storage_client.bucket(bucket_name2)
    blob2 = bucket2.blob(destination_blob_name2)
    blob2.upload_from_string(data2, content_type='application/json')
    return 'success'