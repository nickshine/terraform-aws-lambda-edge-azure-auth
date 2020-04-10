variable "client_id" {
  description = "Microsoft Azure AD Application ID"
  type        = string
}

variable "client_secret" {
  description = "Microsoft Azure AD Client Secret"
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
  default     = "lambda-edge-azure-auth-policy"
}

variable "redirect_uri" {
  description = "Registered Microsoft Azure AD Application Redirect URI"
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
  default     = {}
}

variable "tenant" {
  description = "Microsoft Azure AD Tenant ID"
  type        = string
}

variable "trailing_slash_redirects_enabled" {
  description = "Enables 301 redirects for directory paths not ending in a forward slash. e.g. www.example.com/about -> www.example.com/about/"
  type        = bool
  default     = false
}

variable "simple_urls_enabled" {
  description = "Appends index.html on to directory paths (e.g. www.example.com/about/ retrieves www.example.com/about/index.html from a backend s3 origin.)"
  type        = bool
  default     = true
}
