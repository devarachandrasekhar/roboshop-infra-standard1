data "aws_vpc" "default" {
  default = true
} 

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.env}/vpc_id"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
