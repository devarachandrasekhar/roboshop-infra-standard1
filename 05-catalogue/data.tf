data "aws_ssm_parameter" "vpc_id" {
name = "/${var.project_name}/${var.env}/vpc_id"
}

data "aws_ssm_parameter" "app_alb_sg_id" {
 name = "/${var.project_name}/${var.env}/app_alb_sg_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
name  = "/${var.project_name}/${var.env}/private_subnet_ids"  
}

data "aws_ssm_parameter" "catalogue_sg_id" {
 name        = "/${var.project_name}/${var.env}/catalogue_sg_id"
}


data "aws_ssm_parameter" "app_alb_listener_arn" {
  name  = "/${var.project_name}/${var.env}/app_alb_listener_arn"
}


data "aws_ami" "amazon_linux_Redhat" {
  most_recent = true
  owners = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
    
  }

}