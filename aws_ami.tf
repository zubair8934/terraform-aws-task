# Create the AMI from the EC2 instance
resource "aws_launch_configuration" "wp-launch-template" {
  name_prefix     = "wp-launch-template" # Replace with your desired AMI name
  image_id        = "ami-03a6eaae9938c858c"
  instance_type   = "t2.micro"
  key_name        = "MyKp"
  security_groups = [aws_security_group.my_wp_SG.id]

  lifecycle {
    create_before_destroy = true
  }

  user_data  = data.template_file.configure_wordpress.rendered
  depends_on = [aws_db_instance.wp-db-cluster]


}