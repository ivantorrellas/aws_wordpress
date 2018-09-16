module "key_pair" {
  source = "./modules/key_pair"

  key_name = "${var.key_name}"
  public_key = "${file(var.public_key)}"
}

module "ec2_instance" {
  source = "./modules/ec2-instance"

  name = "bastion-${var.vpc_name}"
  instance_count = 1
  ami = "${var.bastion_ami}"
  instance_type = "${var.bastion_type}"
  key_name = "${module.key_pair.key_name}"
  monitoring = true
  vpc_security_group_ids = [ "${module.bastion_sg.this_security_group_id}", "${aws_security_group.allow_icmp.id}" ]
  subnet_id = "${element(module.vpc.public_subnets, 0)}"
  associate_public_ip_address = true
  tags = {
    name = "bastion-${var.vpc_name}"
    billing = "${var.vpc_name}"
  }
}
