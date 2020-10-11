provider "aws" {
  region = "us-west-2"
}

variable "keypair_name" {
  description = "the name of the ssh key used to access the ec2 instances"
  type        = string
  default     = "nickhil_sethi_ec2_ssh"
}

variable "ingress_port" {
  description = "port at which webservice can be accessed"
  type        = number
  default     = 80
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = 0
    to_port     = var.ingress_port
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
  image_id               = "ami-0d5d1a3aa3516231f"
  instance_type          = "t2.large"
  security_groups = [aws_security_group.instance.id]
  key_name               = "${var.keypair_name}"
  user_data              = <<-EOF
              #!/bin/bash
              sudo yum install -y git golang
              iptables -A PREROUTING -t nat -p tcp --dport ${var.ingress_port} -j REDIRECT --to-ports 8080
              export HOME=/home/ec2-user
              cd /home/ec2-user; git clone https://github.com/Nickhil-Sethi/vigilant-robot.git
              cd vigilant-robot; go build -o hello ./hello-world
              ./hello &
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}