provider "aws" {
  region = var.region
}

resource "tls_private_key" "assignment" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.assignment.private_key_pem
  filename        = "${path.module}/${var.key_name}.pem"
  file_permission = "0400"
}


resource "aws_key_pair" "assignment" {
  key_name   = var.key_name
  public_key = tls_private_key.assignment.public_key_openssh
}


resource "aws_instance" "devops_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.assignment.key_name
  security_groups = [aws_security_group.ssh_restricted.name]
  user_data = file("${path.module}/../scripts/user_data.sh")

  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.stage}-devops-instance"
  Stage = var.stage
  }
}

resource "aws_security_group" "ssh_restricted" {
  name        = "ssh-from-my-ip"
  description = "Allow SSH access from my IP only"

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  description = "Access Server from Outside"
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

}

