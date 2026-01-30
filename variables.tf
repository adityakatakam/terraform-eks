variable "env" {
  default = "dev"
}

variable "ami" {
  default = "ami-045a533d19c34eeb6"
}

variable "instance_type" {
  default = "t3.small"
}

variable "vpc_security_group_ids" {
  default = [ "sg-0325e8d801d32754b" ]
}

variable "zone_id" {
  default = "Z02346551HC8AOL8EM1LW"
}

variable "components" {
  default = {
    mongodb = ""
    mysql = ""
    rabbitmq = ""
    redis = ""
  }
}