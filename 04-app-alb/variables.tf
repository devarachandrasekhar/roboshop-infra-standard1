variable "common_tags" {
  default = {
    Project = "Roboshop"
    Component= "APP-ALB"
    Environment = "DEV"
    Terraform = true
  }
}

variable "project_name" {
  default = "Roboshop"
}


variable "sg_tags" {
  default = {}
}

variable "env" {
default = "DEV" 
}
