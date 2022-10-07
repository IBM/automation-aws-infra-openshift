## AWS SSH Module 

AWS SHH Module to create a Privte Key and Register an ssh public key into the AWS Cloud  for use in accessing EC2 resources


**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

### Software dependencies

The module depends on the following software components:

#### Command-line tools

- terraform >= v0.15

#### Terraform providers

- IBM Cloud provider >= 1.5.3

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

module "sshmodul" {
  source      = "./module"
  name_prefix = var.name_prefix
  public_key  = var.public_key
  private_key = var.private_key
  rsa_bits    = var.rsa_bits
}

```
