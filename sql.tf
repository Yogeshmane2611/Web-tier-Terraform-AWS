
#Create SQL-server Security group
resource "aws_security_group" "sql-sg" {
  vpc_id = aws_vpc.web-vpc.id
  ingress {
    from_port = 1433
    to_port =  1433
    cidr_blocks = ["192.168.0.0/16"]
    protocol = "tcp"
  }
  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol = -1
  }
  tags = {
    Name = "SQL-sg"
  }
}


#Create SQL Server
resource "aws_instance" "SQL" {
  ami = var.ami.Ubuntu
  instance_type = "t2.micro"
  key_name = "Key"
  security_groups = [aws_security_group.sql-sg.id]
  subnet_id = aws_subnet.Private[0].id
  user_data = file("sql_bash.sh")
  tags = {
    Name = "SQL-Server"
  }
}


output "SQL-Private-IP" {
  value = aws_instance.SQL.private_ip
}