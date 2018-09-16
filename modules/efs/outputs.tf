output "efs_id" {
  value = "${aws_efs_file_system.efs.id}"
}
output "efs_dns_name" {
  value = "${aws_efs_file_system.efs.dns_name}"
}

output "mount_id" {
  value = "${aws_efs_mount_target.mount_target.*.id}"
}
output "mount_dns_name" {
  value = "${aws_efs_mount_target.mount_target.*.dns_name}"
}
output "network_id" {
  value = "${aws_efs_mount_target.mount_target.*.network_interface_id}"
}
