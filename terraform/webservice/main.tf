provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0841edc20334f9287"
  instance_type = "t2.micro"
}