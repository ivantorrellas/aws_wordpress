# Credentials
variable "profile" { default = "PROFILE" }

# Global vars
variable "aws_region" { default = "us-east-1" }
variable "public_key" {
  description = "To create a new key pair run 'ssh-keygen -t rsa -b 4096 -C noname'"
  default = "~/.ssh/it_key.pub"
  type = "string"
}
variable "key_name" {
  default = "it_key"
}

# VPC variables
variable "vpc_name" {
  default = "wordpress"
  description = "VPC name"
}
variable "vpc_cidr" {
  default = "172.16.0.0/20"
  description = "CIDR Range for VPC"
}
variable "vpc_azs" {
  default = [ "us-east-1e", "us-east-1b", "us-east-1c" ]
  description = "Availability zones for VPC"
}
variable "vpc_priv_sub" {
  default = [ "172.16.0.0/24", "172.16.1.0/24", "172.16.2.0/24" ]
  description = "Private Subnets for VPC"
}
variable "vpc_pub_sub" {
  default = [ "172.16.12.0/24", "172.16.11.0/24", "172.16.10.0/24" ]
  description = "Public Subnets for VPC"
}

# Bastion vars
variable "bastion_ami" {
  default = "ami-b70554c8" # "ami-cfe4b2b0"
}
variable "bastion_type" {
  default = "t2.micro"
}

# RDS Database variables
variable "db_username" {
  default = "username"
}
variable "db_password" {
  default = "wordpressPassword!"
}
variable "db_instance_class" {
  default = "db.t2.medium"
}

# ASG variables
variable "instance_type" { default = "t2.micro" }
variable "min_size" { default = "1" }
variable "max_size" { default = "1" }
variable "image_tag" { default = "4" }
