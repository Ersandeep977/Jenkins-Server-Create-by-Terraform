# AIM Profile Cration
resource "aws_iam_instance_profile" "Profile_Ec2" {
  name = "Ec2_Profile"
  role = aws_iam_role.Ec2_role.name
}

# IAM Role Cration
resource "aws_iam_role" "Ec2_role" {
  name               = "Ec2_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    "Name" = "Ec2-role"
  }
}

# IAM Policy Creation
resource "aws_iam_role_policy" "policy_Ec2" {
  name   = "Ec2_policy"
  role   = aws_iam_role.Ec2_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}