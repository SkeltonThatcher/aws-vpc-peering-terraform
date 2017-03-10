# README #

Terraform scripts to create two peered AWS VPCs.

The TF plan will create x2 VPCs, each with the following resources:

* x1 public route table
* x1 IGW
* x2 public subnets
* x2 private subnets
* x1 peering connection
* x1 peering connection route

The plan also contains an init.sh script. This script enables remote state to AWS S3:

### How do I get set up? ###

* Install Terraform
* Clone the repo
* Create terraform.tfvars
* Create an S3 bucket
* Update the init.sh BUCKET var with the S3 bucket name
* Run the init.sh file
* Run terraform plan
* Run terraform apply
* Run terraform destroy

### Who do I talk to? ###

* Rich Bos