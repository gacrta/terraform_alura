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

provider "aws" {
    alias = "us-east-2"
    region = "us-east-2"
}

resource "aws_instance" "dev" {
    count = 3
    ami = "ami-04505e74c0741db8d"
    instance_type = var.instance_type
    key_name = var.key_name
    tags = {
        Name = "dev${count.index}"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}


resource "aws_instance" "dev5" {
    provider = aws.us-east-2
    ami = var.amis["us-east-2"]
    instance_type = var.instance_type
    key_name = var.key_name
    tags = {
        Name = "dev5"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
    depends_on = [aws_dynamodb_table.dynamodb-dev5]
}

resource "aws_dynamodb_table" "dynamodb-dev5" {
  provider = aws.us-east-2
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}
