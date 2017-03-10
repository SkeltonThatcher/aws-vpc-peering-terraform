variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "KEY_NAME" {}

variable "VPC1_CIDR_PREFIX" {
  default = "10.50"
}

variable "VPC2_CIDR_PREFIX" {
  default = "10.100"
}

variable "VPC3_CIDR_PREFIX" {
  default = "10.150"
}
