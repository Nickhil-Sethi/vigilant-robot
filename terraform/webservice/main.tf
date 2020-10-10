provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0d5d1a3aa3516231f"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}