resource "aws_security_group" "c2_sg" {
  vpc_id = data.aws_vpc.default.id
  name   = "c2-server-sg"

  # Allow C2 traffic only from specified IPs
  dynamic "ingress" {
    for_each = var.c2_traffic_ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.c2_traffic_allowed_ips
    }
  }
}

resource "aws_security_group" "ssh" {
  vpc_id = data.aws_vpc.default.id
  name   = "ssh"

  # Allow ssh traffic only from specified IPs
  ingress {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.ssh_allowed_ips
    }
}
