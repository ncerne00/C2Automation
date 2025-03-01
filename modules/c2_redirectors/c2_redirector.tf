resource "aws_instance" "c2_redirector" {
  ami           = var.c2_redirector_ami
  instance_type = var.c2_redirector_instance_type
}

/* Output the Redirector's Public IP */
output "c2_redirector_public_ip" {
  value = aws_instance.c2_redirector.public_ip
}