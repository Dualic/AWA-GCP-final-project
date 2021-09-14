from google.cloud import storage


def delete_blob(request):
    
    bucket_name = "currency-raw-data-json"
    blob_name = "todayscurrencydata.json"

    storage_client = storage.Client()

    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(blob_name)
    blob.delete()

    return ("Blob {} deleted.".format(blob_name))
