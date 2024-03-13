# terraform {
#   backend "gcs" {
#     bucket = "terraform-statefile-eks-dev-sec-ops-us-central1" // Replace with your actual S3 bucket name
#     key    = "eks/terraform.tfstate"
#     region = "us-central1" // You might have issues deploying this in N.Virginia, I'll suggest you use a different Region
#   }
# }
