

variable "common_tags" {
  default = {
    Project = "Roboshop"
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
