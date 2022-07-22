# AWS Cloud VPC module

Provisions a VPC instance and related resources. The full list of resources provisioned is as follows:

- VPC instance
- VPC network acl
  - allow internal ingress / egress
  - deny all external traffic
- VPC security group rules
  - *ping* - icmp type 8
  -  tcp - 80


### Description

### Software dependencies

NA

#### Command-line tools

- terraform >= v0.15

#### Terraform providers

- AWS Cloud provider ~> 3.0

### Module dependencies

NA

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

module "dev_vpc" {

  source = "github.com/cloud-native-toolkit/terraform-aws-vpc.git"
  
  /* New VPC Provisioning */
  provision = true
  name_prefix   = var.prefix_name
  internal_cidr = var.internal_cidr
  instance_tenancy = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
}
```
