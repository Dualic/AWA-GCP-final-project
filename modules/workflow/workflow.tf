resource "google_workflows_workflow" "pipeline-workflow" {
  provider = google-beta
  name            = "pipeline-workflow"
  region          = var.region
  description     = "Magic"
  service_account = var.service_account
  source_contents = <<EOF
  main:
    params: [input]
    steps:
    - getTodaysCurrencies:
        try:
          call: http.get
          args:
            url: https://us-central1-loppuprojekti-325208.cloudfunctions.net/todayscurrencies
          result: ok
                #condition: pyyttonin palauttamista vaihtoehdoista
        retry: $${http.default_retry}      
    - dataAddedToHistory:
        try:
          call: http.get
          args:
            url: https://us-central1-loppuprojekti-325208.cloudfunctions.net/current-to-history
          result: ok
        retry: $${http.default_retry}
    - transferToBQ:
        try:
          call: http.get
          args:
            url: https://us-central1-loppuprojekti-325208.cloudfunctions.net/bq-data-transfer
          result: ok
        retry: $${http.default_retry}
    - deleteDailyData:
        try:
          call: http.get
          args:
            url: https://us-central1-loppuprojekti-325208.cloudfunctions.net/delete-func
          result: ok
        retry: $${http.default_retry}
EOF
}