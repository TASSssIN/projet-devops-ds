resource "aws_ebs_volume" "ds_volume" {
  availability_zone = var.ds_az
  size              = var.ds_volume_size

  tags = {
    Name = var.ds_volume_name
  }
  
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ds_volume.id
  instance_id = var.ds_instance_id
}