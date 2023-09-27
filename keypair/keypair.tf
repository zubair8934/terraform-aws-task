# Creating KeyPair
resource "aws_key_pair" "MyKp" {
  key_name   = "MyKp"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "MyKp" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "MyKp"
}