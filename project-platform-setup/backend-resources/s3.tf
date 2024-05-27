resource "aws_s3_bucket" "bucket" {
    bucket = "ed-eos-terraform-state"

    object_lock_configuration {
        object_lock_enabled = "Enabled"
    }
    tags = {
        Name = "S3 Remote Terraform State Store"
    }
}
