module "vpc" {
  source = "./modules/vpc"

  name = "${var.vpc_name}"
  cidr = "${var.vpc_cidr}"

  azs = "${var.vpc_azs}"
  private_subnets = "${var.vpc_priv_sub}"
  public_subnets  = "${var.vpc_pub_sub}"

  enable_vpn_gateway = false
  enable_nat_gateway  = true
  single_nat_gateway  = true
  reuse_nat_ips       = true
  external_nat_ip_ids = ["${aws_eip.nat_vpc.*.id}"]

  tags = {
    Terraform = "true"
    Name = "${var.vpc_name}"
  }
  enable_dns_hostnames = true
  enable_s3_endpoint = true
  propagate_private_route_tables_vgw = true
}

resource "aws_eip" "nat_vpc" {
  count = 1
  vpc = true
}
