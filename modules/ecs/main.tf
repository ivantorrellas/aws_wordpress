resource "aws_ecs_cluster" "cluster" {
  name = "${var.cluster_name}"
}

resource "aws_ecs_task_definition" "task" {
  family = "wordpress"
  container_definitions = "${var.container_definitions}"

  task_definition = ""
  revision = "latest"
}
