module "vpn_sg" {
  source = "../../terraform-aws-security_group"
  sg_name = "vpn_sg"
  sg_description = "allowing all ports from my home ip"
  vpc_id = data.aws_vpc.default.id
  project_name = var.project_name
  common_tags = merge(var.common_tags,{
    Component = "VPN"
    Name = "roboshop_VPN"
  })

}


module "mongodb_sg" {
  source = "../../terraform-aws-security_group"
  sg_name = "mongodb"
  sg_description = "allowing traffic from VPN,catalogue and user"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  common_tags = merge(
    var.common_tags,
    {
    Component = "mongodb"
    Name = "mongodb"
  }
  )

}


module "catalogue_sg" {
  source = "../../terraform-aws-security_group"
  sg_name = "catalogue"
  sg_description = "allowing traffic from VPN,web"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  common_tags = merge(
    var.common_tags,
    {
    Component = "catalogue"
    Name = "catalogue"
  }
  )

}


module "web_sg" {
  source = "../../terraform-aws-security_group"
  sg_name = "web"
  sg_description = "allowing traffic from VPN,public alb"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  common_tags = merge(
    var.common_tags,
    {
    Component = "web"
    Name = "web_sg"
  }
  )
}

module "app_alb_sg" {
  source = "../../terraform-aws-security_group"
  sg_name = "app_alb"
  sg_description = "allowing traffic web"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  common_tags = merge(
    var.common_tags,
    {
    Component = "app"
    Name = "app_alb"
  }
  )
}


module "web_alb_sg" {
  source = "../../terraform-aws-security_group"
  sg_name = "web_alb"
  sg_description = "allowing traffic"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  common_tags = merge(
    var.common_tags,
    {
    Component = "web"
    Name = "web_alb"
  }
  )
}



# making the rule to connect the only from our home ip
resource "aws_security_group_rule" "vpn" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.vpn_sg.sg_id 
}

#Giving the ingress rules for Mongodb SG to allowing only vpn instance on port 22 for trouble shooting  
resource "aws_security_group_rule" "mongodb_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.sg_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mongodb_sg.sg_id 
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.catalogue_sg.sg_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mongodb_sg.sg_id 
}



resource "aws_security_group_rule" "catalogue_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.sg_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.catalogue_sg.sg_id 
}

resource "aws_security_group_rule" "catalogue_app_alb" {
  description = "allowing port number 8080 from app alb"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb_sg.sg_id
  security_group_id = module.catalogue_sg.sg_id 
}


resource "aws_security_group_rule" "app_alb_vpn" {
  description = "allowing port number 22 from vpn"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.sg_id
  security_group_id = module.app_alb_sg.sg_id 
}

resource "aws_security_group_rule" "app_alb_web" {
  description = "allowing port number 80 from web"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.web_sg.sg_id
  security_group_id = module.app_alb_sg.sg_id 
}

resource "aws_security_group_rule" "app_alb_catalogue" {
  description = "allowing port number 80 from catalogue"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.catalogue_sg.sg_id
  security_group_id = module.app_alb_sg.sg_id 
}

resource "aws_security_group_rule" "web_vpn" {
  description = "allowing port number 22 from vpn"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.sg_id
  security_group_id = module.web_sg.sg_id 
}

resource "aws_security_group_rule" "web_web_alb" {
  description = "allowing port number 80 from web_alb"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.web_alb_sg.sg_id
  security_group_id = module.web_sg.sg_id 
}



