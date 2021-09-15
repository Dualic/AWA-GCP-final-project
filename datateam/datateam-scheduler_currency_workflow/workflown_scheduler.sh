#cloud scheduler workflowlle

###luodan service account
#gcloud iam service-accounts create SERVICE_ACCOUNT_NAME
gcloud iam service-accounts create workflow-scheduler-sa

###Grant your new service account the workflows.invoker role so that the account has permission to trigger your workflow:
#gcloud projects add-iam-policy-binding PROJECT_NAME \
#  --member serviceAccount:SERVICE_ACCOUNT_NAME@PROJECT_NAME.iam.gserviceaccount.com \
#  --role roles/workflows.invoker
gcloud projects add-iam-policy-binding loppuprojekti-325208 \
  --member serviceAccount:workflow-scheduler-sa@loppuprojekti-325208.iam.gserviceaccount.com \
  --role roles/workflows.invoker

###Create a Cloud Scheduler job that triggers your workflow, 
#using the service account you previously created to authenticate. 
#For example, schedule your workflow to execute every 5 minutes 
#(defining the interval using unix-cron format):
#gcloud scheduler jobs create http JOB_NAME \
#  --schedule="*/5 * * * *" \
#  --uri="https://workflowexecutions.googleapis.com/v1/projects/PROJECT_NAME/locations/REGION_NAME/workflows/WORKFLOW_NAME/executions" \
#  --message-body="{\"argument\": \"DOUBLE_ESCAPED_JSON_STRING\"}" \
#  --time-zone="TIME_ZONE" \
#  --oauth-service-account-email="SERVICE_ACCOUNT_NAME@PROJECT_NAME.iam.gserviceaccount.com"
#joka yö klo1 #HUOM! timezone muodossa "Europe/Helsinki"
gcloud scheduler jobs create http workflow-scheduler --schedule="0 1 * * *" --uri="https://workflowexecutions.googleapis.com/v1/projects/loppuprojekti-325208/locations/us-central1/workflows/testi-valuutta-workflow/executions" --time-zone="Europe/Helsinki" --oauth-service-account-email="workflow-scheduler-sa@loppuprojekti-325208.iam.gserviceaccount.com"
