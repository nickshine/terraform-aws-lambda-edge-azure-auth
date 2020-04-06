locals {
  lambda_version          = "0.1.0"
  lambda_filename         = "lambda-edge-azure-auth-${local.lambda_version}.zip"
  lambda_repo             = "https://github.com/nickshine/lambda-edge-azure-auth"
  oidc_discovery_document = "https://login.microsoftonline.com/${var.tenant}/v2.0/.well-known/openid-configuration"
  session_duration        = var.session_duration * 60 * 60                  # hours to seconds
  callback_path           = regex("https?://.*(/.*$)", var.redirect_uri)[0] # Endpoint used for the OAuth2 AuthCode Redirect URI
}

resource "null_resource" "copy_lambda" {
  triggers = {
    file_exists = fileexists("${path.module}/${local.lambda_filename}")
  }

  provisioner "local-exec" {
    command = <<EOF
if [ ! -d "${path.module}/lambda" ] && [ ! -L "${path.module}/lambda" ]; then
  curl -L ${local.lambda_repo}/releases/download/v${local.lambda_version}/${local.lambda_filename} -o ${path.module}/${local.lambda_filename}
  unzip -q ${path.module}/${local.lambda_filename} -d ${path.module}/lambda/
fi
EOF
  }
}

resource "local_file" "config" {
  content = templatefile("${path.module}/config.tmpl", {
    callback_path      = local.callback_path
    client_id          = var.client_id
    client_secret      = var.client_secret
    discovery_document = local.oidc_discovery_document
    private_key        = tls_private_key.key_pair.private_key_pem
    public_key         = tls_private_key.key_pair.public_key_pem
    redirect_uri       = var.redirect_uri
    session_duration   = local.session_duration
    tenant             = var.tenant
  })
  filename = "${path.module}/lambda/config.json"

  depends_on = [
    null_resource.copy_lambda,
  ]
}

data "null_data_source" "copy_lambda_sync" {
  inputs = {
    file    = "${path.module}/lambda.zip"
    trigger = null_resource.copy_lambda.id
  }
}

resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/lambda.zip"
  source_dir  = "${path.module}/lambda"
  depends_on = [
    local_file.config
  ]
}

resource "aws_lambda_function" "this" {
  depends_on = [
    null_resource.copy_lambda,
    local_file.config
  ]
  filename         = "${path.module}/lambda.zip"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  function_name    = var.function_name
  role             = aws_iam_role.lambda-role.arn
  handler          = "index.handler"
  runtime          = "nodejs12.x"
  publish          = true

  tags = var.tags
}

data "aws_iam_policy_document" "lambda-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "lambda-role" {
  name               = var.lambda_role_name
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role-policy.json
}

data "aws_iam_policy_document" "lambda-logging-permissions" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_policy" "lambda-logging-policy" {
  name   = var.lambda_policy_name
  policy = data.aws_iam_policy_document.lambda-logging-permissions.json
}

resource "aws_iam_role_policy_attachment" "lambda-logging-attachment" {
  role       = aws_iam_role.lambda-role.name
  policy_arn = aws_iam_policy.lambda-logging-policy.arn
}
