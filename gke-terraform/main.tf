resource "google_service_account" "devsecops_service_account" {
  account_id = "devsecops-service-account"
  display_name = "devsecops-service-account"
}

resource "google_project_iam_member" "devsecops_sa_owner_binding" {
  project = "essential-rig-415518"
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.devsecops_service_account.email}"
}

resource "google_container_cluster" "gke_cluster" {
  name               = "gke-cluster"
  location           = "us-central1-a"
  initial_node_count = 1
  deletion_protection = false
  node_config {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.devsecops_service_account.email
    labels = {
      foo = "bar"
    }
    tags = ["name", "gke-cluster"]
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}