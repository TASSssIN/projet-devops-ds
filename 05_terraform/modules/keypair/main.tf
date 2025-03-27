resource "aws_key_pair" "ds_key" {
  key_name   = var.ds_key
  public_key = tls_private_key.ds_private_key.public_key_openssh
}

resource "tls_private_key" "ds_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "local_file" "ds_file" {
  filename =  var.ds_key_filename
  content =  tls_private_key.ds_private_key.private_key_pem
  file_permission = "0400"
}