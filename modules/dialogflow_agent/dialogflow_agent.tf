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
            uri      = "https://us-central1-leo-test-env-1.cloudfunctions.net/dialogfunction"
    }
}