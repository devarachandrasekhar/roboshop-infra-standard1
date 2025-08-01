resource "aws_ssm_parameter" "vpc_id" {
  name        = "/${var.project_name}/${var.env}/vpc_id"
  type        = "String"
  value       = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project_name}/${var.env}/public_subnet_ids"
  type  = "StringList"
  value = join(",",module.vpc.public_subnet) # module should have the output declaration
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project_name}/${var.env}/private_subnet_ids"
  type  = "StringList"
  value = join(",",module.vpc.private_subnet) # module should have the output declaration
}

resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.project_name}/${var.env}/database_subnet_ids"
  type  = "StringList"
  value = join(",",module.vpc.db_subnet) # module should have the output declaration
}