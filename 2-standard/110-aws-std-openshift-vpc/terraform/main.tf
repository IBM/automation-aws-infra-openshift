module "aws-ec2-bastion" {
  source = "github.com/cloud-native-toolkit/terraform-aws-bastion?ref=v1.4.0"

  allow_ssh_from = var.aws-ec2-bastion_allow_ssh_from == null ? null : jsondecode(var.aws-ec2-bastion_allow_ssh_from)
  ami_id = var.aws-ec2-bastion_ami_id
  base_security_group = var.aws-ec2-bastion_base_security_group
  init_script = var.aws-ec2-bastion_init_script
  instance_type = var.aws-ec2-bastion_instance_type
  label = var.aws-ec2-bastion_label
  name_prefix = var.name_prefix
  pri_instance_monitoring = var.aws-ec2-bastion_pri_instance_monitoring
  public_subnet_ids = var.aws-ec2-bastion_public_subnet_ids == null ? null : jsondecode(var.aws-ec2-bastion_public_subnet_ids)
  publicIP = var.aws-ec2-bastion_publicIP
  publickey = var.aws-ec2-bastion_publickey
  pubnet_ids = var.aws-ec2-bastion_pubnet_ids == null ? null : jsondecode(var.aws-ec2-bastion_pubnet_ids)
  root_block_device_encrypted = var.aws-ec2-bastion_root_block_device_encrypted
  root_volume_size = var.aws-ec2-bastion_root_volume_size
  root_volume_type = var.aws-ec2-bastion_root_volume_type
  security_group_rules = var.aws-ec2-bastion_security_group_rules == null ? null : jsondecode(var.aws-ec2-bastion_security_group_rules)
  ssh_key = module.bastion_access_key.swesshkeyname
  subnet_count_private = var.aws-ec2-bastion_subnet_count_private
  subnet_count_public = module.pub_subnets.count
  subnet_id = var.aws-ec2-bastion_subnet_id == null ? null : jsondecode(var.aws-ec2-bastion_subnet_id)
  subnet_ids_pri = var.aws-ec2-bastion_subnet_ids_pri == null ? null : jsondecode(var.aws-ec2-bastion_subnet_ids_pri)
  subnet_ids_pub = module.pub_subnets.subnet_ids
  vpc_id = module.aws-vpc.vpc_id
  vpc_subnet_count = var.aws-ec2-bastion_vpc_subnet_count
  vpc_subnets = var.aws-ec2-bastion_vpc_subnets
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
  provision = var.aws-vpc_provision
  resource_group_name = var.resource_group_name
}
module "bastion_access_key" {
  source = "github.com/cloud-native-toolkit/terraform-aws-ssh-key?ref=v1.1.2"

  access_key = var.bastion_access_key_access_key
  label = var.bastion_access_key_label
  name = var.bastion_access_key_name
  name_prefix = var.name_prefix
  private_key = var.bastion_access_key_private_key
  private_key_file = var.bastion_access_key_private_key_file
  public_key = var.bastion_access_key_public_key
  public_key_file = var.bastion_access_key_public_key_file
  region = var.region
  rsa_bits = var.bastion_access_key_rsa_bits
  secret_key = var.bastion_access_key_secret_key
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
  private_subnet_ids = module.worker_subnets.subnet_ids
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
  provision = var.igw_provision
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
  provision = var.ngw_provision
  resource_group_name = var.resource_group_name
  subnet_ids = module.pub_subnets.subnet_ids
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
  provision = var.pub_subnets_provision
  region = var.region
  resource_group_name = var.resource_group_name
  subnet_cidrs = var.pub_subnets_subnet_cidrs == null ? null : jsondecode(var.pub_subnets_subnet_cidrs)
  vpc_name = module.aws-vpc.vpc_name
}
module "storage_kms" {
  source = "github.com/cloud-native-toolkit/terraform-aws-kms?ref=v1.1.1"

  alias = var.storage_kms_alias
  description = var.storage_kms_description
  enabled = var.storage_kms_enabled
  key_spec = var.storage_kms_key_spec
  kms_alias = var.storage_kms_kms_alias
  name_prefix = var.name_prefix
  policy_file = var.storage_kms_policy_file
  region = var.region
  resource_group_name = var.resource_group_name
  rotation_enabled = var.storage_kms_rotation_enabled
  user_arn = var.storage_kms_user_arn
}
module "vpn" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpn-server?ref=v1.3.1"

  additional_routes = var.vpn_additional_routes == null ? null : jsondecode(var.vpn_additional_routes)
  allowed_cidr_ranges = var.vpn_allowed_cidr_ranges == null ? null : jsondecode(var.vpn_allowed_cidr_ranges)
  authentication_saml_provider_arn = var.vpn_authentication_saml_provider_arn
  authentication_type = var.vpn_authentication_type
  client_cidr_block = var.vpn_client_cidr_block
  create_vpn = var.vpn_create_vpn
  dns_servers = var.vpn_dns_servers == null ? null : jsondecode(var.vpn_dns_servers)
  existing_vpn_id = var.vpn_existing_vpn_id
  ingress_rules = var.vpn_ingress_rules == null ? null : jsondecode(var.vpn_ingress_rules)
  log_group_name = var.vpn_log_group_name
  logs_retention = var.vpn_logs_retention
  name_prefix = var.name_prefix
  name_vpn = var.vpn_name_vpn
  number_additional_routes = var.vpn_number_additional_routes
  number_subnets_association = var.vpn_number_subnets_association
  region = var.region
  resource_group_name = var.resource_group_name
  security_group_id = var.vpn_security_group_id
  split_tunnel = var.vpn_split_tunnel
  subnet_ids = module.worker_subnets.subnet_ids
  vpc_id = var.vpn_vpc_id
}
module "worker_subnets" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets?ref=v2.3.0"

  acl_rules = var.worker_subnets_acl_rules == null ? null : jsondecode(var.worker_subnets_acl_rules)
  availability_zones = var.worker_subnets_availability_zones == null ? null : jsondecode(var.worker_subnets_availability_zones)
  customer_owned_ipv4_pool = var.worker_subnets_customer_owned_ipv4_pool
  gateways = module.ngw.ids
  label = var.worker_subnets_label
  map_customer_owned_ip_on_launch = var.worker_subnets_map_customer_owned_ip_on_launch
  map_public_ip_on_launch = var.worker_subnets_map_public_ip_on_launch
  multi-zone = var.multi-zone
  name_prefix = var.name_prefix
  provision = var.worker_subnets_provision
  region = var.region
  resource_group_name = var.resource_group_name
  subnet_cidrs = var.worker_subnets_subnet_cidrs == null ? null : jsondecode(var.worker_subnets_subnet_cidrs)
  vpc_name = module.aws-vpc.vpc_name
}
