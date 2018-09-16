output "lb_target_arn" {
  value = "${aws_lb_target_group.lb-tg.arn}"
}
output "dns_name" {
  value = "${aws_lb.lb.dns_name}"
}
