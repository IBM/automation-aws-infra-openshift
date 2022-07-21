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
  ssh_key = module.ec2_access_key.swesshkeyname
  subnet_count_private = var.aws-ec2-bastion_subnet_count_private
  subnet_count_public = module.edge_bastion_pub_subnets.count
  subnet_id = var.aws-ec2-bastion_subnet_id == null ? null : jsondecode(var.aws-ec2-bastion_subnet_id)
  subnet_ids_pri = var.aws-ec2-bastion_subnet_ids_pri == null ? null : jsondecode(var.aws-ec2-bastion_subnet_ids_pri)
  subnet_ids_pub = module.edge_bastion_pub_subnets.subnet_ids
  vpc_id = module.edge_vpc.vpc_id
  vpc_subnet_count = var.aws-ec2-bastion_vpc_subnet_count
  vpc_subnets = var.aws-ec2-bastion_vpc_subnets
}
module "ec2_access_key" {
  source = "github.com/cloud-native-toolkit/terraform-aws-ssh-key?ref=v1.1.2"

  access_key = var.ec2_access_key_access_key
  label = var.ec2_access_key_label
  name = var.ec2_access_key_name
  name_prefix = var.name_prefix
  private_key = var.ec2_access_key_private_key
  private_key_file = var.ec2_access_key_private_key_file
  public_key = var.ec2_access_key_public_key
  public_key_file = var.ec2_access_key_public_key_file
  region = var.region
  rsa_bits = var.ec2_access_key_rsa_bits
  secret_key = var.ec2_access_key_secret_key
}
module "edge_bastion_pri_subnets" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets?ref=v2.3.0"

  acl_rules = var.edge_bastion_pri_subnets_acl_rules == null ? null : jsondecode(var.edge_bastion_pri_subnets_acl_rules)
  availability_zones = var.edge_bastion_pri_subnets_availability_zones == null ? null : jsondecode(var.edge_bastion_pri_subnets_availability_zones)
  customer_owned_ipv4_pool = var.edge_bastion_pri_subnets_customer_owned_ipv4_pool
  gateways = module.edge-ngw.ids
  label = var.edge_bastion_pri_subnets_label
  map_customer_owned_ip_on_launch = var.edge_bastion_pri_subnets_map_customer_owned_ip_on_launch
  map_public_ip_on_launch = var.edge_bastion_pri_subnets_map_public_ip_on_launch
  multi-zone = var.edge_bastion_pri_subnets_multi-zone
  name_prefix = var.name_prefix
  provision = var.provision
  region = var.region
  resource_group_name = var.resource_group_name
  subnet_cidrs = var.edge_bastion_pri_subnets_subnet_cidrs == null ? null : jsondecode(var.edge_bastion_pri_subnets_subnet_cidrs)
  vpc_name = module.edge_vpc.vpc_name
}
module "edge_bastion_pub_subnets" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets?ref=v2.3.0"

  acl_rules = var.edge_bastion_pub_subnets_acl_rules == null ? null : jsondecode(var.edge_bastion_pub_subnets_acl_rules)
  availability_zones = var.edge_bastion_pub_subnets_availability_zones == null ? null : jsondecode(var.edge_bastion_pub_subnets_availability_zones)
  customer_owned_ipv4_pool = var.edge_bastion_pub_subnets_customer_owned_ipv4_pool
  gateways = var.edge_bastion_pub_subnets_gateways == null ? null : jsondecode(var.edge_bastion_pub_subnets_gateways)
  label = var.edge_bastion_pub_subnets_label
  map_customer_owned_ip_on_launch = var.edge_bastion_pub_subnets_map_customer_owned_ip_on_launch
  map_public_ip_on_launch = var.edge_bastion_pub_subnets_map_public_ip_on_launch
  multi-zone = var.edge_bastion_pub_subnets_multi-zone
  name_prefix = var.name_prefix
  provision = var.provision
  region = var.region
  resource_group_name = var.resource_group_name
  subnet_cidrs = var.edge_bastion_pub_subnets_subnet_cidrs == null ? null : jsondecode(var.edge_bastion_pub_subnets_subnet_cidrs)
  vpc_name = module.edge_vpc.vpc_name
}
module "edge_vpc" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc?ref=v1.6.0"

  enable_dns_hostnames = var.edge_vpc_enable_dns_hostnames
  enable_dns_support = var.edge_vpc_enable_dns_support
  external_cidr = var.edge_vpc_external_cidr
  instance_tenancy = var.edge_vpc_instance_tenancy
  internal_cidr = var.edge_vpc_internal_cidr
  name = var.edge_vpc_name
  name_prefix = var.name_prefix
  provision = var.provision
  resource_group_name = var.resource_group_name
}
module "edge-ngw" {
  source = "github.com/cloud-native-toolkit/terraform-aws-nat-gateway?ref=v1.1.1"

  _count = var.edge-ngw__count
  allocation_id = var.edge-ngw_allocation_id
  connectivity_type = var.edge-ngw_connectivity_type
  name = var.edge-ngw_name
  name_prefix = var.name_prefix
  provision = var.provision
  resource_group_name = var.resource_group_name
  subnet_ids = module.edge_bastion_pub_subnets.subnet_ids
}
module "edge-vpn" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpn-server?ref=v1.2.1"

  additional_routes = var.edge-vpn_additional_routes == null ? null : jsondecode(var.edge-vpn_additional_routes)
  allowed_cidr_ranges = var.edge-vpn_allowed_cidr_ranges == null ? null : jsondecode(var.edge-vpn_allowed_cidr_ranges)
  authentication_saml_provider_arn = var.edge-vpn_authentication_saml_provider_arn
  authentication_type = var.edge-vpn_authentication_type
  client_cidr_block = var.edge-vpn_client_cidr_block
  create_vpn = var.edge-vpn_create_vpn
  dns_servers = var.edge-vpn_dns_servers == null ? null : jsondecode(var.edge-vpn_dns_servers)
  existing_vpn_id = var.edge-vpn_existing_vpn_id
  ingress_rules = var.edge-vpn_ingress_rules == null ? null : jsondecode(var.edge-vpn_ingress_rules)
  log_group_name = var.edge-vpn_log_group_name
  logs_retention = var.edge-vpn_logs_retention
  name_prefix = var.name_prefix
  name_vpn = var.edge-vpn_name_vpn
  number_additional_routes = var.edge-vpn_number_additional_routes
  number_subnets_association = var.edge-vpn_number_subnets_association
  region = var.region
  resource_group_name = var.resource_group_name
  security_group_id = var.edge-vpn_security_group_id
  split_tunnel = var.edge-vpn_split_tunnel
  subnet_ids = module.edge_bastion_pri_subnets.subnet_ids
  vpc_id = var.edge-vpn_vpc_id
}
module "igw" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc-gateways?ref=v1.2.1"

  name = var.igw_name
  name_prefix = var.name_prefix
  provision = var.provision
  resource_group_name = var.resource_group_name
  vpc_name = module.edge_vpc.vpc_name
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
