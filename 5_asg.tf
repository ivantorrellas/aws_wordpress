module "asg" {
  source = "./modules/asg"

  lc_name_prefix = "${var.vpc_name}-lc-"
  instance_type = "${var.instance_type}"
  key_name = "${module.key_pair.key_name}"
  security_groups = [
    "${aws_security_group.allow_icmp.id}",
    "${aws_security_group.allow_http.id}"
  ]
  # "${module.bastion_sg.this_security_group_id}",

  user_data = "${data.template_file.user_data.rendered}"
  asg_name = "${var.vpc_name}-asg"
  min_size = "${var.min_size}"
  max_size = "${var.max_size}"
  vpc_zone_identifier = "${module.vpc.private_subnets}"
  target_group_arns = ["${module.lb.lb_target_arn}"]
}

module "efs" {
  source = "./modules/efs"

  vcount = "${var.vpc_priv_sub}"
  efs_name = "${var.vpc_name}-efs"
  subnet_id = "${module.vpc.private_subnets}"
}

data "template_file" "user_data" {
  template = "${file("files/user_data.sh")}"

  vars {
      WORDPRESS_DB_HOST = "${module.db.this_db_instance_address}"
      WORDPRESS_DB_USER = "${var.db_username}"
      WORDPRESS_DB_PASSWORD = "${var.db_password}"
      EFS_MOUNT_DNS = "${element(module.efs.mount_dns_name, 0)}"
  }
}

module "lb" {
  source = "./modules/lb"

  lb_name = "${var.vpc_name}-alb"
  lb_sg = ["${aws_security_group.allow_http.id}"]
  lb_subnets = "${module.vpc.public_subnets}"
  vpc_id = "${module.vpc.vpc_id}"
}
