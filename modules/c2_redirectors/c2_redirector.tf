resource "aws_eip" "c2_redirector_eip" {
  domain = "vpc"
  tags = {
    Name = "C2 Redirector Server Elastic IP"
  }
}

resource "aws_instance" "c2_redirector" {
  ami                     = var.ami
  instance_type           = var.instance_type
  key_name                =  var.key_pair
  vpc_security_group_ids  = [var.c2_redirector_sg_id, var.ssh_sg_id, var.certbot_sg_id]
  
  /* Adding variables to our bash script to configure nginx */ 
  user_data = templatefile("${path.module}/setup/install_nginx.sh.tpl", {
    c2_server_ip = var.c2_server_ip_address
    redirector_domain_name = var.redirector_domain_name
    approved_user_agent = var.approved_user_agent
  })

  tags          = {
    Name = "c2-redirector"
  }
}

resource "aws_eip_association" "c2_server_eip_assoc" {
  instance_id   = aws_instance.c2_redirector.id
  allocation_id = aws_eip.c2_redirector_eip.id
}

/* Output the Redirector's Public IP */
output "c2_redirector_public_ip" {
  value = aws_eip.c2_redirector_eip.public_ip
}