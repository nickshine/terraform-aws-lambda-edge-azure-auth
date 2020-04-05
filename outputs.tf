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
