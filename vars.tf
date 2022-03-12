variable amis {
  type        = map
  default     = {
      "us-east-1" = "ami-04505e74c0741db8d"
      "us-east-2" = "ami-08b6f2a5c291246a0"
  }
  description = "AMIs usadas em cada region"
}

variable cdir_ssh {
    type = list(string)
    default = ["177.27.202.112/32"]
    description = "Lista de IPs para config do security_group"
}

variable key_name {
    type = string
    default = "terraform_aws"
    description = "key_name para instancias EC2"
}

variable instance_type {
    type = string
    default = "t2.micro"
    description = "instance_type para instancias EC2"
}