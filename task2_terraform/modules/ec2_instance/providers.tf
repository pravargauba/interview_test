provider "aws" {
  region              = var.region
  allowed_account_ids = [var.aws_account_id]

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/${var.provider_role}"
  }
}