# Create Efs
resource "aws_efs_file_system" "my_wp_efs" {
  creation_token   = "efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  tags = {
    Name = "my_wp_efs"
  }
}



# Define a mount target in each availability zone
resource "aws_efs_mount_target" "efs_mount_tg" {
  count           = 2
  file_system_id  = aws_efs_file_system.my_wp_efs.id
  subnet_id       = element([aws_subnet.us_east_1a_pub.id, aws_subnet.us_east_1b_pub.id], count.index)
  security_groups = [aws_security_group.my_efs_SG.id]
}