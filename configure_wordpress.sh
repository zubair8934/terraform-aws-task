#!/bin/bash
sudo yum update -y
sleep 5
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz
sleep 20
sudo cp -r wordpress/* /var/www/html/
sudo yum install php -y
sleep 5
sudo yum install php-mysqlnd -y
sudo mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo chown -R apache:apache /var/www/html/
sudo chmod -R 755 /var/www/html/
sudo systemctl restart httpd
sudo yum install mariadb105 -y
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www
sudo find /var/www -type d -exec sudo chmod 2775 {} \;
sudo systemctl restart httpd
sleep 20
sudo sed -i "s/database_name_here/${db_name}/g" /var/www/html/wp-config.php
sudo sed -i "s/username_here/${db_username}/g" /var/www/html/wp-config.php
sudo sed -i "s/password_here/${db_password}/g" /var/www/html/wp-config.php
sudo sed -i "s/localhost/${db_host}/g" /var/www/html/wp-config.php