##############################################################
# Security Group for Main server
resource "aws_security_group" "Main_server_SG" {
  name        = "Main_server_SG"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.MyVpc.id
  dynamic "ingress" {
    for_each = [22, 80, 8080, ]
    iterator = Port
    content {
      from_port   = Port.value
      to_port     = Port.value
      protocol    = "tcp"
      cidr_blocks = [aws_vpc.MyVpc.cidr_block]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "SG_for_Main_Server"
  }
}

###########################################################
# Security Group for DB server
resource "aws_security_group" "DB_server_SG" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.MyVpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.MyVpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "All-Port-Allow"
  }
}

########################################################################
# Security Group for JumpServer
resource "aws_security_group" "JumpServer_server_SG" {
  name        = "allow_SSH_jumpServer"
  description = "Allow 22 SSh Port in JumpServer"
  vpc_id      = aws_vpc.MyVpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "Jump_Server_SG"
  }
}