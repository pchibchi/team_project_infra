terraform {
  backend "s3" {
    bucket         = "teamproject-state-921203910441"
    key            = "dev/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "teamproject-lock"
  }
}
