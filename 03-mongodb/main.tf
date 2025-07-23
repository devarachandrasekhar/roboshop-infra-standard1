# module "mongodb_sg" {
#   source         = "../../terraform-aws-security_group"
#   sg_name        = "mongodb"
#   sg_description = "allowing all ports from vpn nstance"
#   vpc_id         = data.aws_ssm_parameter.vpc_id.value
#   common_tags    = var.common_tags
#   project_name   = var.project_name

# }

# ## we are adding the rule to  the mongodb security group that is allowing traffic from vpn instance
# resource "aws_security_group_rule" "vpn" {
#   type                     = "ingress"
#   from_port                = 0
#   to_port                  = 65535
#   protocol                 = "tcp"
#   source_security_group_id = data.aws_ssm_parameter.vpn_sg_id.value
#   #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
#   #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
#   security_group_id = module.mongodb_sg.sg_id
# }


module "mongodb_instance" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami                    = data.aws_ami.amazon_linux_Redhat.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]
  subnet_id              = local.db_subnet
  user_data = file("mongodb.sh")
  tags = merge(
    {
      Name = "Mongodb_EC2"
    }, var.common_tags
  )
} 

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name 
  records = [
    {
      name    = "mongodb"
      type    = "A"
      ttl     = 1
      records = [
         module.mongodb_instance.private_ip
      ]
    }
  ] 
}