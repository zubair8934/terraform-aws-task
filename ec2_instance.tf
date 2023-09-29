# Creating private EC2 instance
resource "aws_instance" "my_wp_instance" {
  ami                         = "ami-03a6eaae9938c858c"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.my_wp_SG.id}"]
  subnet_id                   = aws_subnet.us_east_1a_priv.id
  key_name                    = "MyKp"
  count                       = 1
  associate_public_ip_address = false
  user_data                   = data.template_file.configure_wordpress.rendered
  depends_on                  = [aws_db_instance.wp-db-cluster]
  tags = {
    Name = "my_wp_instance"
  }

}

data "template_file" "configure_wordpress" {
  template = file("configure_wordpress.sh")

  vars = {
    db_username = aws_db_instance.wp-db-cluster.username
    db_password = aws_db_instance.wp-db-cluster.password
    db_host     = aws_db_instance.wp-db-cluster.endpoint
    db_name     = "wordpress" # Replace with your actual database name
  }
}
