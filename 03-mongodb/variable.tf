variable "sg_name" {
  default = "allow_only_myip"
}



variable "common_tags" {
  default = {
    Project     = "Roboshop"
    Environment = "DEV"
    Terraform   = true
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

variable "zone_name" {
  default = "practicedevops.store"
}
