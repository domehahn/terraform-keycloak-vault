terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "4.3.1"
    }
  }
}
# configure keycloak provider
provider "keycloak" {
  client_id                = "admin-cli"
  username                 = "admin"
  password                 = "admin"
  url                      = "http://keycloak:8080"
  tls_insecure_skip_verify = true
}
# configure vault provider
provider "vault" {
  address = "http://vault:8200"
  token   = "root"
}