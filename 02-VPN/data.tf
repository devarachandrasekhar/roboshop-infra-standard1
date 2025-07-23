data "aws_vpc" "default" {
  default = true
} 

data "aws_subnet" "default" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-1a"]
  }


}



data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}


data "aws_ssm_parameter" "vpn_sg_id" {
  name  = "/${var.project_name}/${var.env}/vpn_sg_id"
}


data "aws_ami" "amazon_linux_Redhat" {
  most_recent = true
  owners = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
    
  }

}