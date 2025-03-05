resource "aws_eip" "c2_server_eip" {
  domain = "vpc"
  tags = {
    Name = "C2 Server Elastic IP"
  }
}

resource "aws_instance" "c2_server" {
  ami                     = var.ami
  instance_type           = var.instance_type
  key_name                =  var.key_pair
  vpc_security_group_ids  = [var.c2_traffic_sg_id, var.ssh_sg_id]

  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = var.volume_size
  }
 
  tags                    = {
    Name = "c2-server"
  }
}

resource "aws_eip_association" "c2_server_eip_assoc" {
  instance_id   = aws_instance.c2_server.id
  allocation_id = aws_eip.c2_server_eip.id
}

/* Output the c2 server's Public IP */
output "c2_server_public_ip" {
  value = aws_eip.c2_server_eip.public_ip
}