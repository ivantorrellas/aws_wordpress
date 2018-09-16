resource "aws_efs_file_system" "efs" {
  creation_token = "${var.efs_name}"

  tags {
    Name = "${var.efs_name}"
  }
}

resource "aws_efs_mount_target" "mount_target" {
  count = "${length(var.vcount)}"
  file_system_id = "${aws_efs_file_system.efs.id}"
  subnet_id = "${element(var.subnet_id, count.index)}"
}
