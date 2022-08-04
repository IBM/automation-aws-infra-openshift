# AWS Cloud VPC Subnet module

Provisions public and private subnet for VPC. The full list of resources provisioned is as follows:

- Can create a Single zone or multi-zone subnets. By default mutlizone subnets are created.
- Create a Public Subnet by attaching Internet Gateway
- Create a Private Subnet by attaching Nat Gateway

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
  - terraform-aws-vpc module https://github.com/cloud-native-toolkit/terraform-aws-vpc

Also has optional dependencies on the following modules in case Internet Gateway or Nat Gateway is attached to VPC /Subnet
  - terraform-aws-vpc-gateways module github.com/cloud-native-toolkit/terraform-aws-vpc-gateways
  - terraform-aws-nat-gateway module  github.com/cloud-native-toolkit/terraform-aws-nat-gateway

### Example usage

The following will create a multizone subnet. To create subnets in single zone, set multi-zone to false

  - To create a public subnet with internet gateway attached, make sure to set  label as 'public' and proivde the internet gateway ID

  - To create a private subnet,  make sure to set  label as 'private' and in case to attach Nat Gateway, proivde the nat gateway ID


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




module "dev_pub_subnet" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets.git"
  
  provision=var.provision #default true
  region = var.region # ap-south-1
  name_prefix = var.name_prefix 
  label = "public"
  vpc_name = module.dev_vpc.vpc_name
  subnet_cidrs = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  #acl_rules = var.acl_rules_pub 
  #map_customer_owned_ip_on_launch = false
  #map_public_ip_on_launch = false
  
  gateways = [module.dev_igw.igw_id] #Inernet Gateway ID
}

module "dev_priv_subnet" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets.git" 
  provision=var.provision
  region=var.region
  name_prefix = var.name_prefix
  label = "private"
  vpc_name = module.dev_vpc.vpc_name
  subnet_cidrs = ["10.0.128.0/20","10.0.144.0/20"]
  #acl_rules = var.acl_rules_pri
  #map_customer_owned_ip_on_launch = false
  #map_public_ip_on_launch         = false
  
  #gateways = module.dev_ngw.ngw_id  
  
}

```
