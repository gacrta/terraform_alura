terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.27"
        }
    }

    required_version = ">= 0.14.9"
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "dev" {
    count = 3
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    key_name = "terraform_aws"
    tags = {
        Name = "dev${count.index}"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

resource "aws_instance" "dev4" {
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    key_name = "terraform_aws"
    tags = {
        Name = "dev4"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
    depends_on = [aws_s3_bucket.dev4]
}

resource "aws_security_group" "acesso-ssh" {
  name = "acesso-ssh"
  description = "acesso-ssh"
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["177.27.202.112/32"]
  }
  tags = {
      Name = "ssh"
  }
}

resource "aws_s3_bucket" "dev4" {
  bucket = "gacrta-dev4"
  acl    = "private"

  tags = {
    Name = "gacrta-dev4"
  }
}