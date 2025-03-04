resource "aws_security_group" "c2_traffic_sg" {
  name   = "c2-server-sg"

  # Allow C2 traffic only from specified IPs
  dynamic "ingress" {
    for_each = var.c2_traffic_ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["${var.redirector_public_ip}/32"] // Output from redirector resource
    }
  }

  # Allow outbound traffic to the internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "c2_redirector_sg" {
  name   = "c2-redirector-sg"

  # Allow traffic from the internet
  dynamic "ingress" {
    for_each = var.c2_traffic_ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
  # Allow outbound traffic to the internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "certbot-sg" {
  name   = "certbot-sg"

  # Allow traffic from the internet
  dynamic "ingress" {
    for_each = var.c2_traffic_ingress_ports
    content {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_security_group" "ssh" {
  name   = "ssh"

  # Allow ssh traffic only from specified IPs
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.ssh_allowed_ips
    }
}

output "c2_traffic_sg_id" {
  value = aws_security_group.c2_traffic_sg.id
}

output "c2_redirector_sg_id" {
  value = aws_security_group.c2_redirector_sg.id
}

output "ssh_sg_id" {
  value = aws_security_group.ssh.id
}

output "certbot_sg_id" {
  value = aws_security_group.certbot-sg.id
}
