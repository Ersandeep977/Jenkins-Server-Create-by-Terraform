# Creates a PEM (and OpenSSH) formatted private key ,Generates a secure private key and encodes
# Create Private key
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = "terraform_key"
  public_key = tls_private_key.rsa.public_key_openssh
}