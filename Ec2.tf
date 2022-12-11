# Main Server Cration in side Server Have Jenkin and Ansible
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

#JumpServer Creation
resource "aws_instance" "jumpServer" {
  ami                         = data.aws_ami.AmazonAmiName.id
  instance_type               = "t2.micro"
  key_name                    = "DevOpsKey"
  subnet_id                   = aws_subnet.public.id
  iam_instance_profile        = aws_iam_instance_profile.profile_Ec2_role_admin_power.name
  associate_public_ip_address = true
  availability_zone           = "us-east-2a"
  vpc_security_group_ids      = [aws_security_group.JumpServer_server_SG.id]
  tags = {
    "Name" = "JumpServer"
  }
}

#Second Server Creation for DB server
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