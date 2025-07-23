locals {
  db_subnet = element(split(",",data.aws_ssm_parameter.database_subnet_ids.value),0)
   #split(",",data.aws_ssm_parameter.database_subnet_ids.id)
}
output "db_subnets" {
     sensitive = true

  value = local.db_subnet
}
  