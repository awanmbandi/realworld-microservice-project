resource "google_service_account" "devsecops_service_account" {
  account_id = "devsecops-service-account"
  display_name = "devsecops-service-account"
}

resource "google_project_iam_member" "devsecops_sa_owner_binding" {
  project = "essential-rig-415518"
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.devsecops_service_account.email}"
}