
#enable apis
gcloud services enable bigquerydatatransfer.googleapis.com \
cloudbuild.googleapis.com \
cloudfunctions.googleapis.com \
cloudidentity.googleapis.com \
cloudresourcemanager.googleapis.com \
cloudscheduler.googleapis.com \
compute.googleapis.com \
container.googleapis.com \
containerregistry.googleapis.com \
dataflow.googleapis.com \
datafusion.googleapis.com \
dataproc-control.googleapis.com \
dataproc.googleapis.com \
deploymentmanager.googleapis.com \
iam.googleapis.com \
iamcredentials.googleapis.com \
oslogin.googleapis.com \
pubsub.googleapis.com \
secretmanager.googleapis.com \
source.googleapis.com \
sourcerepo.googleapis.com \
texttospeech.googleapis.com \
workflowexecutions.googleapis.com \
workflows.googleapis.com \
aiplatform.googleapis.com \
datapipelines.googleapis.com \
dialogflow.googleapis.com \
ml.googleapis.com \
run.googleapis.com \
servicenetworking.googleapis.com \
sqladmin.googleapis.com

#create backend bucket for terraform state
gsutil mb gs://backend-bucket-final-project

#create cloud build trigger
gcloud beta builds triggers create cloud-source-repositories \
--repo=github_dualic_awa-gcp-final-project \
--branch-pattern=master \
--build-config=cloudbuild.yaml \
--service-account=SERVICE_ACCOUNT \
--require-approval

#connect github to cloud source repositories
#https://cloud.google.com/source-repositories/docs/mirroring-a-github-repository

