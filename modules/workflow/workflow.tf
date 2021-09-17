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

    - getTodaysCurrencies: #eka funktio, hakee päivittäisen datan
        try:
          call: http.get
          args:
            url: https://us-central1-leo-test-env-1.cloudfunctions.net/todays-currencies
          result: resp1     
        retry: $${http.default_retry}
#condition: pyyttonin palauttamista vaihtoehdoista
    - switch_step1:
        switch:
          - condition: $${resp1.body == "success"}
            next: dataAddedToHistory
          - condition: $${resp1.body == "failed"}
            steps:
            - publishToPubsub1:
                call: googleapis.pubsub.v1.projects.topics.publish
                args:
                  topic: "projects/leo-test-env-1/topics/workflow-errors"
                  body:
                    messages:
                    - data: "Z2V0VG9kYXlzQ3VycmVuY2llcyBmdW5jdGlvbiBmYWlsZWQ="
            next: end
        
    - dataAddedToHistory: #toka funktio, muokkaa päivittäisen csv:ksi ja yhdistää historiadatan kanssa
        try:
          call: http.get
          args:
            url: https://us-central1-leo-test-env-1.cloudfunctions.net/daily-to-history
          result: resp2
        retry: $${http.default_retry}
        #condition: pyyttonin palauttamista vaihtoehdoista
    - switch_step2:
        switch:
          - condition: $${resp2.body == "success"}
            next: transferToBQ
          - condition: $${resp2.body == "failed"}
            steps:
            - publishToPubsub2:
                call: googleapis.pubsub.v1.projects.topics.publish
                args:
                  topic: "projects/leo-test-env-1/topics/workflow-errors"
                  body:
                    messages:
                    - data: "ZGF0YUFkZGVkVG9IaXN0b3J5IGZ1bmN0aW9uIGZhaWxlZA=="
            next: end

    - transferToBQ: #transfers data from bucket to bigquery table
        try:
          call: http.get
          args:
            url: https://us-central1-leo-test-env-1.cloudfunctions.net/bq-transfer
          result: resp3
        retry: $${http.default_retry}
    - switch_step3:
        switch:
          - condition: $${resp3.body == "success"}
            next: deleteDailyData
          - condition: $${resp3.body == "failed"}
            steps:
            - publishToPubsub3:
                call: googleapis.pubsub.v1.projects.topics.publish
                args:
                  topic: "projects/leo-test-env-1/topics/workflow-errors"
                  body:
                    messages:
                    - data: "dHJhbnNmZXJUb0JRIGZ1bmN0aW9uIGZhaWxlZA=="
            next: end          
    - deleteDailyData: #kolmas funktio, poistaa päivittäisen json-tiedoston
        try:
          call: http.get
          args:
            url: https://us-central1-leo-test-env-1.cloudfunctions.net/delete-func
          result: resp4
        retry: $${http.default_retry}
    - switch_step4:
        switch:
          - condition: $${resp4.body == "success"}
            next: end
          - condition: $${resp4.body == "failed"}
            steps:
            - publishToPubsub4:
                call: googleapis.pubsub.v1.projects.topics.publish
                args:
                  topic: "projects/leo-test-env-1/topics/workflow-errors"
                  body:
                    messages:
                    - data: "ZGVsZXRlRGFpbHlEYXRhIGZ1bmN0aW9uIGZhaWxlZA=="
            next: end
EOF
}