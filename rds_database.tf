# creating subnet group for the rds instance
resource "aws_db_subnet_group" "wp_db_subnet_group" {
  name = "wp_db_subnet_group"
  subnet_ids = [
    aws_subnet.us_east_1a_priv.id,
    aws_subnet.us_east_1b_priv.id,
  ]
  description = "Subnet group for database instance"

  tags = {
    Name = "wp_db_subnet_group"
  }
}


# creating rds instance
resource "aws_db_instance" "wp-db-cluster" {
  engine                 = "mysql"
  engine_version         = "8.0.31"
  multi_az               = false
  identifier             = "wp-db-cluster"
  username               = "zubair"
  password               = "Password1"
  instance_class         = "db.t2.micro"
  allocated_storage      = 200
  db_subnet_group_name   = aws_db_subnet_group.wp_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.My-RDS-SG.id]
  db_name                = "wordpress"
  skip_final_snapshot    = true
}