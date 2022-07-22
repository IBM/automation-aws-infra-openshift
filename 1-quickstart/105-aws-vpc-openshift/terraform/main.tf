module "aws-kms" {
  source = "github.com/cloud-native-toolkit/terraform-aws-kms?ref=v1.1.1"

  alias = var.aws-kms_alias
  description = var.aws-kms_description
  enabled = var.aws-kms_enabled
  key_spec = var.aws-kms_key_spec
  kms_alias = var.aws-kms_kms_alias
  name_prefix = var.name_prefix
  policy_file = var.aws-kms_policy_file
  region = var.region
  resource_group_name = var.resource_group_name
  rotation_enabled = var.aws-kms_rotation_enabled
  user_arn = var.aws-kms_user_arn
}
module "aws-vpc" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc?ref=v1.6.0"

  enable_dns_hostnames = var.aws-vpc_enable_dns_hostnames
  enable_dns_support = var.aws-vpc_enable_dns_support
  external_cidr = var.aws-vpc_external_cidr
  instance_tenancy = var.aws-vpc_instance_tenancy
  internal_cidr = var.aws-vpc_internal_cidr
  name = var.aws-vpc_name
  name_prefix = var.name_prefix
  provision = var.provision
  resource_group_name = var.resource_group_name
}
module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-aws-rosa?ref=v1.5.0"

  cluster_name = var.cluster_cluster_name
  compute-machine-type = var.cluster_compute-machine-type
  dry_run = var.cluster_dry_run
  etcd-encryption = var.cluster_etcd-encryption
  existing_vpc = var.cluster_existing_vpc
  host-prefix = var.cluster_host-prefix
  machine-cidr = module.aws-vpc.vpc_cidr
  multi-zone-cluster = var.multi-zone
  name_prefix = var.name_prefix
  no_of_compute_nodes = var.cluster_no_of_compute_nodes
  ocp_version = var.cluster_ocp_version
  pod-cidr = var.cluster_pod-cidr
  private_subnet_ids = module.pri_subnets.subnet_ids
  private-link = var.cluster_private-link
  public_subnet_ids = module.pub_subnets.subnet_ids
  region = var.region
  resource_group_name = var.resource_group_name
  rosa_token = var.rosa_token
  service-cidr = var.cluster_service-cidr
  subnet_ids = var.cluster_subnet_ids == null ? null : jsondecode(var.cluster_subnet_ids)
}
module "igw" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc-gateways?ref=v1.2.1"

  name = var.igw_name
  name_prefix = var.name_prefix
  provision = var.provision
  resource_group_name = var.resource_group_name
  vpc_name = module.aws-vpc.vpc_name
}
module "ngw" {
  source = "github.com/cloud-native-toolkit/terraform-aws-nat-gateway?ref=v1.1.1"

  _count = var.ngw__count
  allocation_id = var.ngw_allocation_id
  connectivity_type = var.ngw_connectivity_type
  name = var.ngw_name
  name_prefix = var.name_prefix
  provision = var.provision
  resource_group_name = var.resource_group_name
  subnet_ids = module.pub_subnets.subnet_ids
}
module "pri_subnets" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets?ref=v2.3.0"

  acl_rules = var.pri_subnets_acl_rules == null ? null : jsondecode(var.pri_subnets_acl_rules)
  availability_zones = var.pri_subnets_availability_zones == null ? null : jsondecode(var.pri_subnets_availability_zones)
  customer_owned_ipv4_pool = var.pri_subnets_customer_owned_ipv4_pool
  gateways = module.ngw.ids
  label = var.pri_subnets_label
  map_customer_owned_ip_on_launch = var.pri_subnets_map_customer_owned_ip_on_launch
  map_public_ip_on_launch = var.pri_subnets_map_public_ip_on_launch
  multi-zone = var.multi-zone
  name_prefix = var.name_prefix
  provision = var.provision
  region = var.region
  resource_group_name = var.resource_group_name
  subnet_cidrs = var.pri_subnets_pri_subnets_cidrs == null ? null : jsondecode(var.pri_subnets_pri_subnets_cidrs)
  vpc_name = module.aws-vpc.vpc_name
}
module "pub_subnets" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets?ref=v2.3.0"

  acl_rules = var.pub_subnets_acl_rules == null ? null : jsondecode(var.pub_subnets_acl_rules)
  availability_zones = var.pub_subnets_availability_zones == null ? null : jsondecode(var.pub_subnets_availability_zones)
  customer_owned_ipv4_pool = var.pub_subnets_customer_owned_ipv4_pool
  gateways = module.igw.ids
  label = var.pub_subnets_label
  map_customer_owned_ip_on_launch = var.pub_subnets_map_customer_owned_ip_on_launch
  map_public_ip_on_launch = var.pub_subnets_map_public_ip_on_launch
  multi-zone = var.multi-zone
  name_prefix = var.name_prefix
  provision = var.provision
  region = var.region
  resource_group_name = var.resource_group_name
  subnet_cidrs = var.pub_subnets_pub_subnet_cidrs == null ? null : jsondecode(var.pub_subnets_pub_subnet_cidrs)
  vpc_name = module.aws-vpc.vpc_name
}
