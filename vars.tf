variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-west-1"
}

variable "vpc1_cidr_prefix" {
  default = "10.50"
}

variable "vpc2_cidr_prefix" {
  default = "10.100"
}

variable "vpc3_cidr_prefix" {
  default = "10.150"
}
