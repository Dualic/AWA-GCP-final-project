/*resource "google_dialogflow_agent" "full_agent" {
  display_name = "dialogflow-agent" #required
  default_language_code = "en" #required
  supported_language_codes = ["fr","de","es"]
  time_zone = "America/New_York" #required
  description = "Example description."
  avatar_uri = "https://cloud.google.com/_static/images/cloud/icons/favicons/onecloud/super_cloud.png"
  enable_logging = true
  match_mode = "MATCH_MODE_ML_ONLY"
  classification_threshold = 0.3
  api_version = "API_VERSION_V2_BETA_1"
  tier = "TIER_STANDARD"
}

resource "google_dialogflow_agent" "basic_agent" {
  display_name = "example_agent"#required
  default_language_code = "en"
  time_zone = "America/New_York"
}

resource "google_dialogflow_agent" "RoboBob" {
  display_name = "RoboBob" #required
  default_language_code = "en" #required
  time_zone = "Europe/Kaliningrad" #required
  avatar_uri = "https://www.clipartmax.com/png/small/140-1400962_vee-chatbot-meet-vee.png"
  enable_logging = true
  api_version = "API_VERSION_V2_BETA_1"
}

resource "google_dialogflow_fulfillment" "basic_fulfillment" {
  depends_on = [google_dialogflow_agent.RoboBob]
  display_name = "basic-fulfillment"
  enabled    = true
  generic_web_service {
            uri      = "https://us-central1-loppuprojekti-325208.cloudfunctions.net/dialogfunction"
    }
}

resource "google_dialogflow_intent" "MLdataForRoboBob" {
  project = var.project_id
  depends_on = [google_dialogflow_agent.RoboBob]
  display_name = "MLdataForRoboBob"
  webhook_state = "WEBHOOK_STATE_ENABLED"
  priority = 1
  training_phrases {
     parts {
         text = "Japan situation on 5.10.2021"
     }
     parts {
         text = "I want to go Sweden next Friday"
     }
     repeat_count = 1
  }

  parameters {
    id          = "geo-country"
    entity_type = "projects/loppuprojekti-325208/locations/RoboBob/agents/MLdataForRoboBob/entityTypes/sys.geo-country"
  }

  parameters{
    id = "date-time"
    entity_type = "projects/loppuprojekti-325208/locations/RoboBob/agents/MLdataForRoboBob/entityTypes/sys.date-time"
  }
}