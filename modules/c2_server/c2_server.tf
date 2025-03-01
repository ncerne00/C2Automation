resource "aws_instance" "c2_server" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = aws_security_group.c2_sg.name
}

/* Output the c2 server's Public IP */
output "c2_server_public_ip" {
  value = aws_instance.c2_server.public_ip
}