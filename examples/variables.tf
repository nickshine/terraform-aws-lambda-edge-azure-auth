variable "client_id" {}
variable "client_secret" {}
variable "redirect_uri" {}
variable "tags" {
  description = "Tags to attach to the lambda"
  type        = map(string)
}
variable "tenant" {}
