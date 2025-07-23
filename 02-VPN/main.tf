# module "vpn_sg" {
#   source = "../../terraform-aws-security_group"
#   sg_name = var.sg_name
#   sg_description = "allowing all ports from my home ip"
#   vpc_id = data.aws_vpc.default.id
#   common_tags = var.common_tags
#   project_name = var.project_name

# }

# # making the rule to connect the only from our home ip
# resource "aws_security_group_rule" "vpn" {
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "tcp"
#   cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
#   #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
#   security_group_id = module.vpn_sg.sg_id 
# }

module "vpn_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.amazon_linux_Redhat.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  # this is optional . if we dont give this will be provisioned inside default subnet of default vpc
  subnet_id = data.aws_subnet.default.id
   
  tags = merge (
    {
    Name= "Roboshop-VPN"
  },var.common_tags
  )
} 