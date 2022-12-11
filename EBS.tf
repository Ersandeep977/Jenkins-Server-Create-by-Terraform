# AWS EBS Volume for Main server Create
resource "aws_ebs_volume" "vol-1" {
  availability_zone = "us-east-2a"
  size              = 1
  tags = {
    "Name" = "Vol-1"
  }
}

# AWS EBS Volume Attachment Main server
resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.vol-1.id
  instance_id = aws_instance.Main_server.id
}

# AWS Snapshot for ebs volume for Main server
resource "aws_ebs_snapshot" "Main_server_snapshot" {
  volume_id = aws_ebs_volume.vol-1.id
  tags = {
    "Name" = "Main_server_snapshot"
  }
  depends_on = [
    aws_instance.Main_server
  ]
}
