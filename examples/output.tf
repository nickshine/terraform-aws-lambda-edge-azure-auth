output "callback_path" {
  description = "Callback path derived from Redirect URI"
  value       = module.lambda-edge-azure-auth.callback_path
}
output "client_id" {
  description = "Client ID of the Azure application"
  value       = module.lambda-edge-azure-auth.client_id
}

output "client_secret" {
  description = "Client Secret of the Azure application"
  value       = module.lambda-edge-azure-auth.client_secret
  sensitive   = true
}

output "public_key" {
  description = "RSA Public Key generated for the lambda@edge function config.json"
  value       = module.lambda-edge-azure-auth.public_key
}

output "public_key_openssh" {
  description = "RSA Public Key generated for the lambda@edge function config.json"
  value       = module.lambda-edge-azure-auth.public_key_openssh
}

output "private_key" {
  description = "RSA Private Key generated for the lambda@edge function config.json"
  value       = module.lambda-edge-azure-auth.private_key
  sensitive   = true
}

output "session_duration" {
  description = "Auth session duration in seconds"
  value       = module.lambda-edge-azure-auth.session_duration
}
