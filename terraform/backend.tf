terraform {
  backend "s3" {
    bucket = "awscourse-s3-288757602165-us-east-1-an"
    key    = "k8s-vanilla-lab/terraform.tfstate"
    region = "us-east-1"
  }
}
