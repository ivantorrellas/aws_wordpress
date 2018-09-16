resource "aws_lb" "lb" {
  name = "${var.lb_name}"
  internal = "${var.lb_internal}"
  load_balancer_type = "${var.lb_type}"
  security_groups = ["${var.lb_sg}"]
  subnets = ["${var.lb_subnets}"]

  ## Change this to TRUE for production environment.
  enable_deletion_protection = false

  tags {
    Name = "${var.lb_name}"
  }
}


resource "aws_lb_target_group" "lb-tg" {
  name = "${var.lb_name}-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = "${var.vpc_id}"
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = "${aws_lb.lb.arn}"
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.lb-tg.arn}"
  }
}
