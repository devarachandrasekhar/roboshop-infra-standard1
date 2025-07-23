data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.env}/vpc_id"
}

data "aws_ssm_parameter" "vpn_sg_id" {
  name = "/${var.project_name}/${var.env}/vpn_sg_id"
}

data "aws_ssm_parameter" "mongodb_sg_id" {
  name        = "/${var.project_name}/${var.env}/mongodb_sg_id"
}

data "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.project_name}/${var.env}/database_subnet_ids"
}

data "aws_ami" "amazon_linux_Redhat" {
  most_recent = true
  owners = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
    
  }

}


