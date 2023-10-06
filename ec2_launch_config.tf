resource "aws_launch_template" "wp-launch-template" {
  name_prefix            = "wp-launch-template"
  image_id               = "ami-03a6eaae9938c858c"
  instance_type          = "t2.micro"
  key_name               = "MyKp"
  vpc_security_group_ids = [aws_security_group.my_wp_SG.id]
  user_data              = base64encode(data.template_file.configure_wordpress.rendered)

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8
      volume_type = "gp2"
    }
  }

  depends_on = [aws_db_instance.wp-db-cluster, aws_efs_file_system.my_wp_efs, aws_efs_mount_target.efs_mount_tg]
}
