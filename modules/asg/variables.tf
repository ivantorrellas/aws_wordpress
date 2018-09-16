
variable "lc_name_prefix" { }
variable "instance_type" { }
variable "key_name" { }
variable "security_groups" { type = "list" default = [] }
variable "associate_public_ip_address" { default = "false" }
variable "user_data" { }
variable "asg_name" { }
variable "min_size" { }
variable "max_size" { }
variable "vpc_zone_identifier" { type = "list" default = [] }
variable "target_group_arns" { type = "list" default = [] }
