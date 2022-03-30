module "aws-internet-gateway" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc-gateways?ref=v1.1.0"

  name = var.aws-internet-gateway_name
  name_prefix = var.name_prefix
  provision = var.aws-internet-gateway_provision
  resource_group_name = var.resource_group_name
  vpc_name = module.aws-vpc.vpc_name
}
module "aws-vpc" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc?ref=v1.2.2"

  enable_dns_hostnames = var.aws-vpc_enable_dns_hostnames
  enable_dns_support = var.aws-vpc_enable_dns_support
  external_cidr = var.aws-vpc_external_cidr
  instance_tenancy = var.aws-vpc_instance_tenancy
  internal_cidr = var.aws-vpc_internal_cidr
  name = var.aws-vpc_name
  name_prefix = var.name_prefix
  provision = var.aws-vpc_provision
  resource_group_name = var.resource_group_name
}
module "aws-vpc-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets?ref=v2.0.0"

  acl_rules = var.aws-vpc-subnets_acl_rules == null ? null : jsondecode(var.aws-vpc-subnets_acl_rules)
  allocation_id = var.aws-vpc-subnets_allocation_id
  availability_zones = var.aws-vpc-subnets_availability_zones == null ? null : jsondecode(var.aws-vpc-subnets_availability_zones)
  connectivity_type = var.aws-vpc-subnets_connectivity_type
  customer_owned_ipv4_pool = var.aws-vpc-subnets_customer_owned_ipv4_pool
  gateways = var.aws-vpc-subnets_gateways == null ? null : jsondecode(var.aws-vpc-subnets_gateways)
  label = var.aws-vpc-subnets_label
  map_customer_owned_ip_on_launch = var.aws-vpc-subnets_map_customer_owned_ip_on_launch
  map_public_ip_on_launch = var.aws-vpc-subnets_map_public_ip_on_launch
  name_prefix = var.aws-vpc-subnets_name_prefix
  provision = var.aws-vpc-subnets_provision
  resource_group_name = var.aws-vpc-subnets_resource_group_name
  subnet_cidrs = var.aws-vpc-subnets_subnet_cidrs == null ? null : jsondecode(var.aws-vpc-subnets_subnet_cidrs)
  vpc_name = module.aws-vpc.vpc_name
}
module "rosa-cluster" {
  source = "github.com/cloud-native-toolkit/terraform-aws-rosa?ref=v1.0.0"

  cluster_name = var.rosa-cluster_cluster_name
  compute-machine-type = var.rosa-cluster_compute-machine-type
  dry_run = var.dry_run
  etcd-encryption = var.rosa-cluster_etcd-encryption
  existing_vpc = var.rosa-cluster_existing_vpc
  host-prefix = var.host-prefix
  machine-cidr = var.machine-cidr
  multi-zone-cluster = var.rosa-cluster_multi-zone-cluster
  no_of_compute_nodes = var.rosa-cluster_no_of_compute_nodes
  ocp_version = var.rosa-cluster_ocp_version
  pod-cidr = var.pod-cidr
  prefix_name = var.rosa-cluster_prefix_name
  private_subnet_ids = var.private_subnet_ids == null ? null : jsondecode(var.private_subnet_ids)
  private-link = var.rosa-cluster_private-link
  public_subnet_ids = var.public_subnet_ids == null ? null : jsondecode(var.public_subnet_ids)
  region = var.region
  rosa_token = var.rosa_token
  service-cidr = var.service-cidr
  subnet_ids = var.rosa-cluster_subnet_ids == null ? null : jsondecode(var.rosa-cluster_subnet_ids)
  subnet-ids = var.rosa-cluster_subnet-ids
}
