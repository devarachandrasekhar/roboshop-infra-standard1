variable "common_tags" {
  default = {
    Project = "Roboshop"
    Component= "catalogue"
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
