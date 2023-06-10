#!/bin/bash
sudo su
yum update -y
yum upgrade -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd 
yum install git -y
git clone https://github.com/Yogeshmane2611/Sign-up-page
cp Sign-up-page/* /var/www/html/ 
systemctl restart httpd
