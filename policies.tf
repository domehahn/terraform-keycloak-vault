resource "vault_policy" "vault_admin" {
  name   = "vault-admin"
  policy = <<EOT
# Enable and manage the key/value secrets engine at `secret/` path

# List, create, update, and delete key/value secrets
path "/secret/*"
{
  capabilities = ["read", "list"]
}
EOT
}