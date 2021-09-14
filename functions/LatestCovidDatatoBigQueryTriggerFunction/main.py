import os
import requests
import json
from google.cloud import secretmanager

#This function is triggered by the finalization of "owid-covid-latest.csv" file in covid-raw-data bucket.

def dataprep_job_gcs_trigger(event, context):

    # Create the Secret Manager client.
    client = secretmanager.SecretManagerServiceClient()

    # Build the resource name of the secret version.
    name = f"projects/loppuprojekti-325208/secrets/datapreptoken/versions/1"

    # Access the secret version.
    response = client.access_secret_version(request={"name": name})

    payload = response.payload.data.decode("UTF-8")

    #dataprep section:
    newfilename = event['name']  
    newfilepath = event['bucket'] 

    datataprep_auth_token = payload
    dataprep_jobid = 3410117
    listen_for_file = "owid-covid-latest.csv"
    
    
    print(context.event_type)
    print(newfilepath)
    

    # if statement makes sure that correct file is listened to:
    
    if context.event_type == 'google.storage.object.finalize' and newfilename == listen_for_file:  

        print('Run Dataprep job on new file: {}'.format(newfilename))

        dataprep_runjob_endpoint = 'https://api.clouddataprep.com/v4/jobGroups'
        datataprep_job_param = {
            "wrangledDataset": {"id": dataprep_jobid},
            "runParameters": {"overrides": {"data": [{"key": "FileName","value": newfilename}]}}
        }
        print('Run Dataprep job param: {}'.format(datataprep_job_param))
        dataprep_headers = {
            "Content-Type":"application/json",
            "Authorization": "Bearer "+datataprep_auth_token
        }        

        resp = requests.post(
            url=dataprep_runjob_endpoint,
            headers=dataprep_headers,
            data=json.dumps(datataprep_job_param)
        )

        print('Status Code : {}'.format(resp.status_code))      
        print('Result : {}'.format(resp.json()))

    
    
    return resp.status_code