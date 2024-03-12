terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.20.0"
    }
  }
}

# Configure the AWS Provider
provider "google" {
  project     = "essential-rig-415518"
  region      = "us-central1"
}