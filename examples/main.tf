provider "aws" {
  region = "us-east-1"
}

module "lambda-edge-azure-auth" {
  source = "../"

  client_id     = var.client_id
  client_secret = var.client_secret
  tenant        = var.tenant
  redirect_uri  = var.redirect_uri
  tags          = var.tags
}
