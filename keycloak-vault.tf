locals {
  vault_realm_id  = "vault"
  vault_client_id = "vault"
}

#create realm
resource "keycloak_realm" "vault_realm" {
  realm        = local.vault_realm_id
  enabled      = true
  display_name = local.vault_realm_id
}

# create user
resource "keycloak_user" "vault_user" {
  realm_id = keycloak_realm.vault_realm.id
  username = "vault-admin"
}

# create group
resource "keycloak_group" "vault_group" {
  realm_id = keycloak_realm.vault_realm.id
  name     = "vault-admin"
}

# add user to group
resource "keycloak_user_groups" "vault_user_groups" {
  realm_id = keycloak_realm.vault_realm.id
  user_id  = keycloak_user.vault_user.id

  group_ids = [
    keycloak_group.vault_group.id
  ]
}

# create vault openid client
resource "keycloak_openid_client" "vault_client" {
  realm_id                     = keycloak_realm.vault_realm.id
  client_id                    = local.vault_client_id
  name                         = local.vault_client_id
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  client_secret                = "vault-client-secret"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris = [
    "http://vault:8250/oidc/oidc/callback",
    "http://vault:8200/ui/vault/auth/oidc/oidc/callback"
  ]
  root_url = "http://vault:8200"
  base_url = "http://vault:8200"
  web_origins = [
    "http://vault:8200"
  ]
}

# map group to claim
resource "keycloak_openid_group_membership_protocol_mapper" "group_membership_mapper" {
  realm_id   = keycloak_realm.vault_realm.id
  client_id  = keycloak_openid_client.vault_client.id
  name       = "groups"
  claim_name = "groups"
  full_path  = false
}