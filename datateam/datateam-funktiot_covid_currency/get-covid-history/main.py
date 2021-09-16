from google.cloud import storage
from urllib.request import Request, urlopen
from datetime import date

def upload_blob_history(request):
    today = date.today()

    # The ID of your GCS bucket (test names are being used, bucket name to be updated)
    bucket_name1 = "covid-raw-data"
    bucket_name2 = "covid-archive"

    # The path to your file to upload    
    req = Request("https://covid.ourworldindata.org/data/owid-covid-data.csv")
    webpage = urlopen(req, timeout=10).read()

    # The ID of your GCS object
    destination_blob_name1 = "owid-covid-data.csv"
    destination_blob_name2 = "owid-covid-data{}.csv".format(today)
    

    storage_client = storage.Client()

    bucket1 = storage_client.bucket(bucket_name1)
    blob1 = bucket1.blob(destination_blob_name1)
    blob1.upload_from_string(webpage, content_type='application/vnd.ms-excel')

    bucket2 = storage_client.bucket(bucket_name2)
    blob2 = bucket2.blob(destination_blob_name2)
    blob2.upload_from_string(webpage, content_type='application/vnd.ms-excel')

    return 'success'
