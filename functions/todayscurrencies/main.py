from google.cloud import storage
import requests
from datetime import date
import json

def currency_today(request):

    #today:
    date_now = date.today()
    todays_date = date_now.strftime("%Y-%m-%d")
    print("todaysdate on", todays_date)
    #get the data:
    url = f'https://api.exchangerate.host/{todays_date}'
    response = requests.get(url)
    data = response.json()

    #storagebucket:
    bucket_name = "currency-raw-data-json"
    # The ID of your GCS object
    destination_blob_name = "todayscurrencydata.json"
    
    data2 = json.dumps(data)
    #save data to storage bucket
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)
    blob.upload_from_string(data2, content_type='application/json')

    return 'success'