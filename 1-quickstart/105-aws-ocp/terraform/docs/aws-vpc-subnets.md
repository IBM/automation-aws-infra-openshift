# AWS Cloud VPC Subnet module

Provisions public and private subnet for VPC. The full list of resources provisioned is as follows:

- Public / Private subnet
- Add Internet Gateway 
- Nat Gateway and update routing tables 
  

### Description

Description of module

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

### Software dependencies

The module depends on the following software components:

#### Command-line tools

- terraform >= v0.15

#### Terraform providers

- AWS Cloud provider ~> 3.0

### Module dependencies

This module makes use of the output from other modules:
  - terraform_aws_vpc module https://github.com/cloud-native-toolkit/terraform-aws-vpc

### Example usage

```hcl-terraform

terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "dev_vpc_subnet" {
  source                          = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets"
  vpc_id                          = module.dev_vpc.vpc_id
  provision=var.provision
  provision_igw = var.provision
  provision_ngw = var.provision
  prefix_name = var.prefix_name
  private_subnet_cidr             = var.private_subnet_cidr
  public_subnet_cidr              = var.public_subnet_cidr
  availability_zones              = var.availability_zones
  map_customer_owned_ip_on_launch = false
  map_public_ip_on_launch         = false
  tags                            = var.tags
  public_subnet_tags              = var.public_subnet_tags
  private_subnet_tags             = var.private_subnet_tags
  acl_rules_pub_in = var.acl_rules_pub_in
  acl_rules_pub_out = var.acl_rules_pub_out
  acl_rules_pri_in= var.acl_rules_pri_in
  acl_rules_pri_out = var.acl_rules_pri_out
}

```
