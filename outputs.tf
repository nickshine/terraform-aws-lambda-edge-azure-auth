output "callback_path" {
  description = "Callback path derived from Redirect URI"
  value       = local.callback_path
}
output "client_id" {
  description = "Client ID of the Azure application"
  value       = var.client_id
}

output "client_secret" {
  description = "Client Secret of the Azure application"
  value       = var.client_secret
  # sensitive   = true
}

output "lambda_arn" {
  description = "The Amazon Resource Name (ARN) identifying the Lambda Function."
  value       = aws_lambda_function.this.arn
}

output "lambda_role_arn" {
  description = "ARN of the Lambda role"
  value       = aws_iam_role.lambda-role.arn
}

output "lambda_qualified_arn" {
  description = "Qualified ARN of the lambda function version"
  value       = aws_lambda_function.this.qualified_arn
}

output "lambda_version" {
  description = "Latest published version of the Lambda@Edge function"
  value       = aws_lambda_function.this.version
}

output "public_key" {
  description = "RSA Public Key generated for the lambda@edge function config.json"
  value       = tls_private_key.key_pair.public_key_pem
}

output "public_key_openssh" {
  description = "RSA Public Key generated for the lambda@edge function config.json"
  value       = tls_private_key.key_pair.public_key_openssh
}

output "private_key" {
  description = "RSA Private Key generated for the lambda@edge function config.json"
  value       = tls_private_key.key_pair.private_key_pem
  # sensitive   = true
}

output "session_duration" {
  description = "Auth session duration in seconds"
  value       = local.session_duration
}
