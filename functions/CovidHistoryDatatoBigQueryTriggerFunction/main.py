import os
import requests
import json
from google.cloud import secretmanager


#This function is triggered by the finalization of "owid-covid-data.csv" file in covid-raw-data bucket.

def dataprep_job_gcs_trigger(event, context):

    newfilename = event['name']  
    newfilepath = event['bucket']

    client = secretmanager.SecretManagerServiceClient()
    ip2 = client.access_secret_version(request={"name": "projects/844731295003/secrets/datapreptoken/versions/latest"})
    ip = ip2.payload.data.decode("UTF-8")

    #prints for dev:
    #print("newfilepath on")
    #print(newfilepath)
    #print("event name")
    #print(event['name'])
    #print("event kokonaisuudessaan")
    #print(event)


    datataprep_auth_token = ip
    dataprep_jobid = 3391912 
    listen_for_file = "owid-covid-data.csv"
    
    
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