# terraform-aws-lambda-edge-azure-auth

>[nickshine/lambda-edge-azure-auth/aws][lambda-edge-azure-auth-terraform-registry]

Terraform module for [nickshine/lambda-edge-azure-auth].

This terraform module pulls down the [nickshine/lambda-edge-azure-auth] pre-packaged lambda
function (using a [local-exec] provisioner with __curl__), generates the required `config.json`
file based on the configured input variables, packages and then creates the lambda function in AWS.

>Minimal dependecies required for Terraform environment (e.g. Terraform Cloud/Enterprise)
>
>* only `curl` and `unzip` needed
>* `node` __not__ required in Terraform environment to generate config

## Usage

```hcl
module "lambda-edge-azure-auth" {
  source = "nickshine/lambda-edge-azure-auth/aws"
  version = "0.1.0"

  client_id     = var.client_id
  client_secret = var.client_secret
  tenant        = var.tenant
  redirect_uri  = var.redirect_uri
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| `client_id` | Microsoft Azure AD Application ID | `string` | | yes |
| `client_secret` | Microsoft Azure AD Client Secret | `string` | | yes |
| `function_name` | Name for the lambda function | `string` | `lambda-edge-azure-auth` | no |
| `lambda_role_name` | Name for the lambda IAM role | `string` | `lambda-edge-azure-auth-role` | no |
| `lambda_policy_name` | Name for the lambda IAM policy | `string` | `lambda-edge-azure-auth-policy` | no |
| `redirect_uri` | Registered Microsoft Azure AD Application Redirect URI | `string` | | yes |
| `session_duration` | Authenticated session duration, in hours | `number` | `168` | no |
| `tags` | Tags to attach to the lambda | `map(string)` | `{}` | no |
| `tenant` | Microsoft Azure AD Tenant ID | `string` | | yes |

## Outputs

| Name | Description | Sensitive |
|------|-------------| :-------: |
| `client_id` | Microsoft Azure AD Application ID | no |
| `client_secret` | Microsoft Azure AD Client Secret | yes |
| `public_key` | RSA Public Key generated for the lambda@edge function `config.json` | no |
| `public_key_openssh` | RSA Public Key generated for the lambda@edge function `config.json` | no |
| `private_key` | RSA Private Key generated for the lambda@edge function `config.json` | yes |
| `session_duration` | Auth session duration in seconds | no |

---

Example generated `config.json` (gets added to the lambda package):

```json
{
  "AUTH_REQUEST": {
      "client_id": "xxxxx-xxxx-xxxx-xxxx-xxxxxxxx",
      "redirect_uri": "http://localhost:1313/_callback",
      "response_type": "code",
      "response_mode": "query",
      "scope": "openid email profile"
  },
  "TOKEN_REQUEST": {
      "client_id": "xxxxx-xxxx-xxxx-xxxx-xxxxxxxx",
      "grant_type": "authorization_code",
      "redirect_uri": "http://localhost:1313/_callback",
      "client_secret": "xxxxx-xxxx-xxxx-xxxx-xxxxxxxx"
  },
  "DISTRIBUTION": "lambda-edge-azure-auth",
  "PRIVATE_KEY": "-----BEGIN RSA PRIVATE KEY-----\nxxxxxxxxxx\n-----END RSA PRIVATE KEY-----\n",
  "PUBLIC_KEY": "-----BEGIN PUBLIC KEY-----\nxxxxxxxxxxxxxxxxxxxxx\n-----END PUBLIC KEY-----\n",
  "TENANT": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "DISCOVERY_DOCUMENT": "https://login.microsoftonline.com/<tenant>/v2.0/.well-known/openid-configuration",
  "SESSION_DURATION": 604800,
  "CALLBACK_PATH": "/_callback"
}
```

[nickshine/lambda-edge-azure-auth]:https://github.com/nickshine/lambda-edge-azure-auth
[local-exec]:https://www.terraform.io/docs/provisioners/local-exec.html
[lambda-edge-azure-auth-terraform-registry]:https://registry.terraform.io/modules/nickshine/lambda-edge-azure-auth/aws
