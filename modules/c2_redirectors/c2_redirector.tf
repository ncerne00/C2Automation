resource "aws_instance" "c2_redirector" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids  = [var.c2_redirector_sg_id]
  tags          = {
    Name = "c2-redirector"
  }
}

/* Output the Redirector's Public IP */
output "c2_redirector_public_ip" {
  value = aws_instance.c2_redirector.public_ip
}