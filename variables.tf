variable "client_secret" {
  description = "Required: OIDC Client secret for Hashicorp Vault"
  type        = string
  default     = "vault-client-secret"
}

variable "client_id" {
  description = "Required: OIDC Client ID for Hashicorp Vault"
  type        = string
  default     = "vault"
}

variable "discovery_url" {
  description = "OIDC Discovery endpoint"
  type        = string
  default     = "http://keycloak:8080/realms/vault"
}

variable "authorized_redirects" {
  description = "List of authorized redirects for Okta OIDC"
  type        = list(string)
  default     = ["http://vault:8200/oidc/oidc/callback", "http://vault:8200/ui/vault/auth/oidc/oidc/callback", "http://localhost:8250/oidc/oidc/callback", "http://localhost:8200/ui/vault/auth/oidc/oidc/callback", "http://127.0.0.1:8200/oidc/oidc/callback", "http://127.0.0.1:8200/ui/vault/auth/oidc/oidc/callback"]
}