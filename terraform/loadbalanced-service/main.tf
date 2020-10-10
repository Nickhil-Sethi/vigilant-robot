provider "aws" {
  region = "us-west-2"
}

variable "keypair_name" {
  description = "the name of the ssh key used to access the ec2 instances"
  type        = string
  default     = "nickhil_sethi_ec2_ssh"
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "example" {
  ami                    = "ami-0d5d1a3aa3516231f"
  instance_type          = "t2.large"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = "${var.keypair_name}"
  user_data              = <<-EOF
              #!/bin/bash
              sudo yum install -y git golang
              export HOME=/home/ec2-user
              cd /home/ec2-user; git clone https://github.com/Nickhil-Sethi/vigilant-robot.git
              cd vigilant-robot; go build -o hello ./hello-world
              ./hello &
              EOF

  tags = {
    Name = "terraform-example"
  }
}

output "public_ip" {
  value = aws_instance.example.public_ip
  description = "the public ip address of the deployed ec2 instance"
}