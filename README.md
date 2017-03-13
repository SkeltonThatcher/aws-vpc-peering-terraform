# README #

Terraform scripts to create three peered VPCs within a single AWS account.

The TF plan will create three VPCs. Each VPC contains the following resources:

* x1 public route table
* x1 IGW
* x2 public subnets
* x2 private subnets
* Peering connections and peering routes

The second and third VPCs are peered with first VPC.

There is no peering route between the second and third VPCs.

The plan also contains an init.sh script. This script enables remote state to AWS S3:

### Prerequisites ###

* AWS account - https://aws.amazon.com
* AWS IAM user account with AWS access/secret keys and permission to create specified resources
* Terraform installed - https://www.terraform.io
* Git account and git installed - https://github.com
* The ability to run .sh (shell) scripts if using Windows

### How do I get set up? ###

* Clone the repo
* Create an EC2 keypair in AWS
* Create terraform.tfvars
* Create an S3 bucket
* Update the init.sh BUCKET var with the S3 bucket name and the desired AWS region
* Run the init.sh file
* Run terraform plan (to plan the deployment)
* Run terraform apply (to apply the plan and deploy all resources)
* Run terraform destroy (to destroy all deployed resources)

### Who do I talk to? ###

* Rich Bos
