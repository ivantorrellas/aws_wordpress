module "db" {
  source = "./modules/rds"

  identifier = "${var.vpc_name}"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "${var.db_instance_class}"
  allocated_storage = 50
  storage_encrypted = false

  name = "${var.vpc_name}"

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  username = "${var.db_username}"
  password = "${var.db_password}"
  port = "3306"

  iam_database_authentication_enabled = true
  vpc_security_group_ids = ["${module.rds_sg.this_security_group_id}"]

  availability_zone = "${element(var.vpc_azs, 1)}"
  multi_az = "false"

  monitoring_interval = "30"
  monitoring_role_name = "MyRDSMonitoringRole"
  create_monitoring_role = true

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = 0

  tags = {
    name = "db-${var.vpc_name}"
    billing = "${var.vpc_name}"
  }

  # DB subnet group
  # subnet_ids = ["${data.aws_subnet_ids.all.ids}"]
  subnet_ids = ["${module.vpc.private_subnets}"]

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "dbwordpress-snap"
  parameters = [
    {
      name = "character_set_client"
      value = "utf8"
    },
    {
      name = "character_set_server"
      value = "utf8"
    }
  ]

}

module "rds_sg" {
  source = "./modules/security-group/modules/mysql"

  name        = "mysql-db"
  description = "Security group to allow access to rds from private subnets"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = "${var.vpc_priv_sub}"
}
