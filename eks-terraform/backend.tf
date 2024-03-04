terraform {
  backend "s3" {
    bucket = "terraform-statefile-eks-dev-sec-ops-us-east-2" # Replace with your actual S3 bucket name
    key    = "EKS/terraform.tfstate"
    region = "us-east-2"
  }
}
