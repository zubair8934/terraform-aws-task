provider "aws" {
  region = "us-east-1"
}

# output "aws_security_grp_id" {

#   value = aws_security_group.my_wp_SG.id
# }

output "Alb-DNS-Name" {

  value = aws_lb.My-Wp-ALB.dns_name

}

output "EFS-DNS-Name" {

  value = aws_efs_file_system.my_wp_efs.dns_name

}

output "EFS-IP" {

  value = aws_efs_mount_target.efs_mount_tg[0].ip_address

}