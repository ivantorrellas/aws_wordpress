variable "lb_name" { }
variable "lb_internal" { default = false }
variable "lb_type" { default = "application" }
variable "lb_sg" { type = "list" default = [] }
variable "lb_subnets" { type = "list" default = [] }
variable "vpc_id" { }
