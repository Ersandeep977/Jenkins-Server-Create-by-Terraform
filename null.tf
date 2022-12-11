resource "local_file" "TF_Key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "terraform_key.pem"
}