from google.cloud import storage
from google.cloud import logging

def delete_blob(request):
    try:
        bucket_name = "currency-raw-data-json"
        blob_name = "todayscurrencydata.json"

        storage_client = storage.Client()

        bucket = storage_client.bucket(bucket_name)
        blob = bucket.blob(blob_name)
        blob.delete()

        print ("Blob {} deleted.".format(blob_name))
        return 'success'
    except:
        logger_name = "logger_1"
        logging_client = logging.Client()
        logger = logging_client.logger(logger_name)
        logger.log_text("delete-func function failed!", severity="ERROR")
        return 'failed'