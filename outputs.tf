# output "database_host" {
#   value = "${module.db.this_db_instance_address}"
# }
output "dns_name" {
  value = "${module.lb.dns_name}"
}
