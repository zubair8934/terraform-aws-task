provider "aws" {
  region = "us-east-1"
}


output "aws_security_grp_id" {

  value = aws_security_group.my_wp_SG.id
}