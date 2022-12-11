# AIM Profile Cration
resource "aws_iam_instance_profile" "profile_Ec2_role_admin_power" {
  name = "profile_Ec2_role_admin_power"
  role = aws_iam_role.Ec2_role_admin_power.name
}

# IAM Role Cration
resource "aws_iam_role" "Ec2_role_admin_power" {
  name               = "Ec2_role_admin_power"
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
    "Name" = "Ec2_role_admin_power"
  }
}

# IAM Policy Creation
resource "aws_iam_role_policy" "Ec2_role_admin_power" {
  name   = "Ec2_policy"
  role   = aws_iam_role.Ec2_role_admin_power.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}