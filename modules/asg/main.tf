data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-2.0.20180810-x86_64-gp2"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Canonical
}

resource "aws_launch_configuration" "lc" {
  name_prefix = "${var.lc_name_prefix}"
  image_id = "${data.aws_ami.amazon_linux.id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  security_groups = ["${var.security_groups}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data = "${var.user_data}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name = "${var.asg_name}"
  launch_configuration = "${aws_launch_configuration.lc.name}"
  min_size = "${var.min_size}"
  max_size = "${var.max_size}"
  vpc_zone_identifier = ["${var.vpc_zone_identifier}"]
  target_group_arns = ["${var.target_group_arns}"]

  lifecycle {
    create_before_destroy = true
  }
}
