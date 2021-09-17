resource "google_pubsub_topic" "pubsub_topic" {
  name = var.topic_name[count.index]
}

resource "google_pubsub_subscription" "pubsub_subscription" {
  name  = var.subscription_name[count.index]
  topic = google_pubsub_topic.pubsub_topic.name[count.index]
}