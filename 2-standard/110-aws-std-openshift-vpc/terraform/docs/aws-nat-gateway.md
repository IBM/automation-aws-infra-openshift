# AWS Cloud VPC NAT Gateway Module

Provisions a NAT Gateway for VPC. 



### Description

### Software dependencies

 NA

#### Command-line tools

- terraform >= v0.15

#### Terraform providers

- AWS Cloud provider ~> 3.0

### Module dependencies

- aws-vpc
- aws-vpc-subnets

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

module "dev_ngw" {

  source = "github.com/cloud-native-toolkit/terraform-aws-nat-gateway"
    _count = 1
    provision = var.provision
    resource_group_name = var.resource_group_name
    name_prefix = var.name_prefix
    connectivity_type = var.connectivity_type
    subnet_ids = module.dev_pub_subnet.subnet_ids    

}
```
