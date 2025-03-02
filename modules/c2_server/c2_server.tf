resource "aws_instance" "c2_server" {
  ami                     = var.ami
  instance_type           = var.instance_type
  vpc_security_group_ids  = [var.c2_traffic_sg_id, var.ssh_sg_id]
  tags                    = {
    Name = "c2-server"
  }
}

/* Output the c2 server's Public IP */
output "c2_server_public_ip" {
  value = aws_instance.c2_server.public_ip
}