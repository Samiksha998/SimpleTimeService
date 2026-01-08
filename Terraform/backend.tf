terraform {
  backend "s3" {
    bucket         = "terraform-eks-state-yourname"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-eks-locks"
    encrypt        = true
  }
}
