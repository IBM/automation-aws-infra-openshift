# AWS Cloud VPC Internet Gateway Module

Provisions a Internet Gateway for VPC.



### Description

### Software dependencies

 NA

#### Command-line tools

- terraform >= v0.15

#### Terraform providers

- AWS Cloud provider ~> 3.0

### Module dependencies

- aws-vpc

### Example usage

```hcl-terraform

terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "dev_igw" {

  source = "github.com/cloud-native-toolkit/terraform-aws-internet-gateway.git"
    provision= var.provision
    resource_group_name = var.resource_group_name
    name_prefix = var.name_prefix
    vpc_name=module.dev_vpc.vpc_name
  
}
```
