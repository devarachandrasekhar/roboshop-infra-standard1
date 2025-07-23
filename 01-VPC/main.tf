module "vpc" {
  source = "../../terraform-aws-vpc2-advanced"
  cidr_block = var.cidr_block
  common_tags = var.common_tags
  project_name = var.project_name
  igw_tags = var.igw_tags
  env = var.env
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  db_subnet_cidr = var.db_subnet_cidr

  is_peering_requried = true
  requester_default_vpc_id = data.aws_vpc.default.id
  custom_vpc_id = local.custom_vpc_id 
  defaut_route_table_id = data.aws_vpc.default.main_route_table_id
  default_vpc_cidr = data.aws_vpc.default.cidr_block
}