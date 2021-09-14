from google.cloud import storage
from datetime import date
import requests
import json

def currency_history(request):

    start_date = "2020-01-05"
    #today:
    date_now = date.today()
    end_date = date_now.strftime("%Y-%m-%d")

    #get the data:
    url = f'https://api.exchangerate.host/timeseries?start_date={start_date}&end_date={end_date}'
    response = requests.get(url)
    data = response.json()

    #storagebucket:
    bucket_name = "currency-raw-data-json"
    # The ID of your GCS object
    destination_blob_name = "currency-history.json"
    #tallennetaan data storagebukettiin
    data2 = json.dumps(data)

    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)
    blob.upload_from_string(data2, content_type='application/json')
    return 'success'