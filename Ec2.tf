# Main Server Cration 
resource "aws_instance" "Main_server" {
  ami                         = data.aws_ami.AmazonAmiName.id
  instance_type               = "t2.micro"
  key_name                    = "DevOpsKey"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  availability_zone           = "us-east-2a"
  vpc_security_group_ids      = [aws_security_group.Main_server_SG.id]
  iam_instance_profile        = aws_iam_instance_profile.Profile_Ec2.name
  user_data                   = file("yum.sh")
  #user_data                   = file("apt.sh")
  tags = {
    "Name" = "Main-server"
  }
}

# Second Server Creation
resource "aws_instance" "os2" {
  ami                         = data.aws_ami.AmazonAmiName.id
  instance_type               = "t2.micro"
  key_name                    = "DevOpsKey"
  subnet_id                   = aws_subnet.private.id
  associate_public_ip_address = false
  
  tags = {
    "Name" = "MyNewOs2"
  }
}

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
