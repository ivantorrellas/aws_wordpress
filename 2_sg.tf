module "bastion_sg" {
  source = "./modules/security-group/modules/ssh"

  name = "bastion-ssh"
  description = "Security group for SSH access to Bastion"
  vpc_id = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group" "allow_icmp" {
  name = "allow_icmp-${var.vpc_name}"
  description = "Allow all ICMP IPv4 inbound traffic"
  vpc_id = "${module.vpc.vpc_id}"

  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = [ "${var.vpc_cidr}" ]
    description = "Allow ICMP"
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_icmp-${var.vpc_name}"
  }
}

resource "aws_security_group" "allow_http" {
  name = "allow_http-${var.vpc_name}"
  description = "Allow all HTTP IPv4 inbound traffic"
  vpc_id = "${module.vpc.vpc_id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
    description = "Allow HTTP"
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_http-${var.vpc_name}"
  }
}
