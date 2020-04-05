variable "client_id" {
  description = "Microsoft Azure application ID"
  type        = string
}

variable "client_secret" {
  description = "Microsoft Azure Client Secret"
  type        = string
}

variable "function_name" {
  description = "Name for the lambda function"
  type        = string
  default     = "lambda-edge-azure-auth"
}

variable "lambda_role_name" {
  description = "Name for the lambda IAM role"
  type        = string
  default     = "lambda-edge-azure-auth-role"
}

variable "lambda_policy_name" {
  description = "Name for the lambda IAM policy"
  type        = string
  default     = "lambda-edge-azure-auth-role"
}

variable "redirect_uri" {
  description = "Registered Microsoft Azure AuthoCode Redirect URI"
  type        = string
}

variable "session_duration" {
  description = "Authenticated session duration, in hours"
  type        = number
  default     = 168 # 168 hours / 24 = 7 days
}

variable "tags" {
  description = "Tags to attach to the lambda"
  type        = map(string)
}

variable "tenant" {
  description = "Microsoft Azure Tenant ID"
  type        = string
}
