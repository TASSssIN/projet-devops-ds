data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals {
  az = "${var.aws_region}a"
  key_path = "./keypair/${var.ds_keyname}.pem"
  key_name = var.ds_keyname
}



module "ec2" {
  source = "./modules/ec2"
  ds_ami = data.aws_ami.ubuntu
  ds_keyname = local.key_name
  ds_instance_type =var.ds_instance_type
  ds_instance_name = var.ds_instance_name
  ds_private_key =  local.key_path
  ds_username = var.ds_username
  ds_sg_name = module.security_group.ds_sg_name
  ds_az = local.az
}

module "ebs" {
  source = "./modules/ebs"
  ds_az = local.az
  ds_volume_name = var.ds_volume_name
  ds_volume_size = var.ds_volume_size
  ds_instance_id = module.ec2.ds_instance_id
}

module "security_group" {
  source = "./modules/security_group"
  ds_sg_name =  var.ds_sg_name 
  ds_sg_ports = var.ds_sg_ports
}

module "keypair" {
  source = "./modules/keypair"
  ds_key_filename = local.key_path
  ds_key = local.key_name
}