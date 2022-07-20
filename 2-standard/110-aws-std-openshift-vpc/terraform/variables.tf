variable "resource_group_name" {
  type = string
  description = "The name of the resource group where the VPC is deployed. On AWS this value becomes a tag."
  default = "default"
}
variable "name_prefix" {
  type = string
  description = "Prefix to be added to the names of resources which are being provisioned"
}
variable "storage_kms_description" {
  type = string
  description = "The description of the key as viewed in AWS console."
  default = "Storage-kms"
}
variable "storage_kms_user_arn" {
  type = string
  description = "the value of storage_kms_user_arn"
  default = "arn:aws:iam::005990573564:root"
}
variable "storage_kms_key_spec" {
  type = string
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1"
  default = "SYMMETRIC_DEFAULT"
}
variable "storage_kms_enabled" {
  type = bool
  description = "Specifies whether the key is enabled."
  default = true
}
variable "storage_kms_policy_file" {
  type = string
  description = "Specifies the file name for kms policy."
  default = "scripts/kms-policy/kms-policy.json"
}
variable "storage_kms_rotation_enabled" {
  type = bool
  description = "Specifies whether key rotation is enabled."
  default = true
}
variable "storage_kms_alias" {
  type = string
  description = "The display name of the key."
  default = "Storage-kms"
}
variable "region" {
  type = string
  description = "the value of region"
  default = "ap-south-1"
}
variable "storage_kms_kms_alias" {
  type = string
  description = "The description of the key alias as viewed in AWS console"
  default = ""
}
variable "bastion_access_key_access_key" {
  type = string
  description = "the value of bastion_access_key_access_key"
  default = ""
}
variable "bastion_access_key_secret_key" {
  type = string
  description = "the value of bastion_access_key_secret_key"
  default = ""
}
variable "bastion_access_key_name" {
  type = string
  description = "the value of bastion_access_key_name"
  default = ""
}
variable "bastion_access_key_label" {
  type = string
  description = "the value of bastion_access_key_label"
  default = "prd"
}
variable "bastion_access_key_public_key_file" {
  type = string
  description = "the value of bastion_access_key_public_key_file"
  default = ""
}
variable "bastion_access_key_private_key_file" {
  type = string
  description = "the value of bastion_access_key_private_key_file"
  default = ""
}
variable "bastion_access_key_public_key" {
  type = string
  description = "the value of bastion_access_key_public_key"
  default = ""
}
variable "bastion_access_key_private_key" {
  type = string
  description = "the value of bastion_access_key_private_key"
  default = ""
}
variable "bastion_access_key_rsa_bits" {
  type = number
  description = "the value of bastion_access_key_rsa_bits"
  default = 3072
}
variable "access_key" {
  type = string
  description = "the value of access_key"
}
variable "secret_key" {
  type = string
  description = "the value of secret_key"
}
variable "aws-vpc_name" {
  type = string
  description = "The name of the VPC instance"
  default = ""
}
variable "aws-vpc_internal_cidr" {
  type = string
  description = "The cidr range of the internal network for the AWS VPC. Either provide manually or chose from AWS IPAM poolsß"
  default = "10.0.0.0/16"
}
variable "aws-vpc_external_cidr" {
  type = string
  description = "The cidr range of the external network for the AWS VPC."
  default = "0.0.0.0/0"
}
variable "aws-vpc_provision" {
  type = bool
  description = "Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up"
  default = true
}
variable "aws-vpc_instance_tenancy" {
  type = string
  description = "Instance is shared / dedicated, etc. #[default, dedicated, host]"
  default = "default"
}
variable "aws-vpc_enable_dns_support" {
  type = string
  description = "default is true. [true, false]]"
  default = "true"
}
variable "aws-vpc_enable_dns_hostnames" {
  type = string
  description = "Default is true. [true, false]]. ROSA cluster requires this to be set as true"
  default = "true"
}
variable "igw_name" {
  type = string
  description = "The name of the IGW instance"
  default = ""
}
variable "igw_provision" {
  type = bool
  description = "Flag to determine whether to provision Internet gateway or not. Defautl set to true"
  default = true
}
variable "bastion_pub_subnets_provision" {
  type = bool
  description = "Provision Subnet if  true."
  default = true
}
variable "multi-zone" {
  type = bool
  description = "Create subnets in multiple zones"
  default = true
}
variable "bastion_pub_subnets_label" {
  type = string
  description = "label to define type of subnet"
  default = "public"
}
variable "bastion_pub_subnets_subnet_cidrs" {
  type = string
  description = "(Required) The CIDR block for the  subnet."
  default = "[\"10.0.1.0/24\",\"10.0.2.0/24\",\"10.0.3.0/24\"]"
}
variable "bastion_pub_subnets_availability_zones" {
  type = string
  description = "List of availability zone ids"
  default = "[]"
}
variable "bastion_pub_subnets_customer_owned_ipv4_pool" {
  type = string
  description = "Type of the subnet: Public / Private"
  default = ""
}
variable "bastion_pub_subnets_map_customer_owned_ip_on_launch" {
  type = string
  description = "Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address. The customer_owned_ipv4_pool and  arguments must be specified when set to true. Default is false."
  default = "false "
}
variable "bastion_pub_subnets_map_public_ip_on_launch" {
  type = string
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is fals"
  default = "false"
}
variable "bastion_pub_subnets_acl_rules" {
  type = string
  description = "the value of bastion_pub_subnets_acl_rules"
  default = "[]"
}
variable "worker_subnets_provision" {
  type = bool
  description = "Provision Subnet if  true."
  default = true
}
variable "worker_subnets_label" {
  type = string
  description = "label to define type of subnet"
  default = "private"
}
variable "worker_subnets_subnet_cidrs" {
  type = string
  description = "(Required) The CIDR block for the  subnet."
  default = "[\"10.0.4.0/24\",\"10.0.5.0/24\",\"10.0.6.0/24\"]"
}
variable "worker_subnets_availability_zones" {
  type = string
  description = "List of availability zone ids"
  default = "[]"
}
variable "worker_subnets_customer_owned_ipv4_pool" {
  type = string
  description = "Type of the subnet: Public / Private"
  default = ""
}
variable "worker_subnets_map_customer_owned_ip_on_launch" {
  type = string
  description = "Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address. The customer_owned_ipv4_pool and  arguments must be specified when set to true. Default is false."
  default = "false "
}
variable "worker_subnets_map_public_ip_on_launch" {
  type = string
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is fals"
  default = "false"
}
variable "worker_subnets_acl_rules" {
  type = string
  description = "the value of worker_subnets_acl_rules"
  default = "[]"
}
variable "vpn_additional_routes" {
  type = string
  description = "List of additonal routes to add in VPN"
  default = "[]"
}
variable "vpn_number_additional_routes" {
  type = number
  description = "cont of additonal routes to add in VPN"
  default = 0
}
variable "vpn_allowed_cidr_ranges" {
  type = string
  description = "List of CIDR ranges from which access is allowed"
  default = "[\"10.0.0.0/16\"]"
}
variable "vpn_create_vpn" {
  type = bool
  description = "Indicates whether you want to  create vpn"
  default = true
}
variable "vpn_existing_vpn_id" {
  type = string
  description = "VPC Id to create resources"
  default = ""
}
variable "vpn_security_group_id" {
  type = string
  description = "Optional security group id to use instead of the default created"
  default = ""
}
variable "vpn_client_cidr_block" {
  type = string
  description = "client cidr block"
  default = "172.13.0.0/16"
}
variable "vpn_logs_retention" {
  type = string
  description = "Retention in days for CloudWatch Log Group"
  default = "365"
}
variable "vpn_name" {
  type = string
  description = "Name for vpn log gruop"
  default = "vpn-swe"
}
variable "vpn_name_vpn" {
  type = string
  description = "Name of resource  VPN to create"
  default = ""
}
variable "vpn_authentication_type" {
  type = string
  description = "The type of client authentication to be used. Specify certificate-authentication to use certificate-based authentication, directory-service-authentication to use Active Directory authentication, or federated-authentication to use Federated Authentication via SAML 2.0."
  default = "certificate-authentication"
}
variable "vpn_authentication_saml_provider_arn" {
  type = string
  description = "(Optional) The ARN of the IAM SAML identity provider if type is federated-authentication."
  default = null
}
variable "vpn_split_tunnel" {
  type = string
  description = "With split_tunnel false, all client traffic will go through the VPN."
  default = "true"
}
variable "vpn_number_subnets_association" {
  type = number
  description = "list of subnets to attch with vpn"
  default = 3
}
variable "vpn_dns_servers" {
  type = string
  description = "List of DNS Servers."
  default = "[\"10.0.0.2\"]"
}
variable "aws-ec2-bastion_subnet_id" {
  type = string
  description = "the value of aws-ec2-bastion_subnet_id"
  default = "[]"
}
variable "aws-ec2-bastion_public_subnet_ids" {
  type = string
  description = "the value of aws-ec2-bastion_public_subnet_ids"
  default = "[]"
}
variable "aws-ec2-bastion_pubnet_ids" {
  type = string
  description = "the value of aws-ec2-bastion_pubnet_ids"
  default = "[]"
}
variable "aws-ec2-bastion_subnet_ids_pri" {
  type = string
  description = "the value of aws-ec2-bastion_subnet_ids_pri"
  default = "[]"
}
variable "aws-ec2-bastion_subnet_count_private" {
  type = number
  description = "the value of aws-ec2-bastion_subnet_count_private"
  default = 0
}
variable "aws-ec2-bastion_ami_id" {
  type = string
  description = "AMI ID for bastion host"
  default = ""
}
variable "aws-ec2-bastion_instance_type" {
  type = string
  description = "EC2 Instance Type 2 default"
  default = "t2.micro"
}
variable "aws-ec2-bastion_publickey" {
  type = string
  description = "EC2   Instance Public Key"
  default = ""
}
variable "aws-ec2-bastion_publicIP" {
  type = bool
  description = "Whether to attach a public IP to EC2 instance"
  default = true
}
variable "aws-ec2-bastion_root_volume_type" {
  type = string
  description = "Type of root volume. Can be standard, gp2 or io1"
  default = "gp2"
}
variable "aws-ec2-bastion_root_block_device_encrypted" {
  type = bool
  description = "Whether   to encrypt the root block device"
  default = true
}
variable "aws-ec2-bastion_root_volume_size" {
  type = number
  description = "Size of the root volume in gigabytes"
  default = 10
}
variable "aws-ec2-bastion_pri_instance_monitoring" {
  type = bool
  description = "Enable  EC2 private instance advance monitoring"
  default = false
}
variable "aws-ec2-bastion_label" {
  type = string
  description = "the value of aws-ec2-bastion_label"
  default = "bastion"
}
variable "aws-ec2-bastion_allow_ssh_from" {
  type = string
  description = "An IP address, a CIDR block, or a single security group identifier to allow incoming SSH connection to the virtual server"
  default = "[\"0.0.0.0/0\"]"
}
variable "aws-ec2-bastion_base_security_group" {
  type = string
  description = "ID of the base security group(SG) to use for the ec2 instance. If not provided a new SG  will be created."
  default = null
}
variable "aws-ec2-bastion_security_group_rules" {
  type = string
  description = "List of security group rules to set on the bastion security group in addition to the SSH rules"
  default = "[]"
}
variable "aws-ec2-bastion_vpc_subnet_count" {
  type = number
  description = "the value of aws-ec2-bastion_vpc_subnet_count"
  default = 0
}
variable "aws-ec2-bastion_vpc_subnets" {
  type = string
  description = "the value of aws-ec2-bastion_vpc_subnets"
  default = ""
}
variable "aws-ec2-bastion_init_script" {
  type = string
  description = "Script to run during the instance initialization. Defaults to an Ubuntu specific script when set to empty"
  default = ""
}
variable "ngw_name" {
  type = string
  description = "The name of the NGW instance"
  default = ""
}
variable "ngw_provision" {
  type = bool
  description = "Flag to determine whether to provision Internet gateway or not. Defautl set to true"
  default = true
}
variable "ngw__count" {
  type = number
  description = "Number of resources to be provisioned"
  default = 3
}
variable "ngw_connectivity_type" {
  type = string
  description = "(Optional) Connectivity type for the gateway. Valid values are private and public. Defaults to public."
  default = "public"
}
variable "ngw_allocation_id" {
  type = string
  description = "(Optional) The Allocation ID of the Elastic IP address for the gateway. Required for connectivity_type of public"
  default = ""
}
variable "rosa_token" {
  type = string
  description = "get an offline access token at https://cloud.redhat.com/openshift/token/rosa "
  default = ""
}
variable "cluster_dry_run" {
  type = bool
  description = "Set to true to dry the command just to verify. Else set to false to actually run the cmd"
  default = false
}
variable "cluster_existing_vpc" {
  type = bool
  description = "Flag to identify if VPC already exists. Default set to true. Used to identify to pass the subnet ids to create the ROSA cluster"
  default = true
}
variable "cluster_cluster_name" {
  type = string
  description = "Name of the RedHat OpenShift Cluster"
  default = ""
}
variable "cluster_ocp_version" {
  type = string
  description = "Version of OpenShift that will be used to install the cluster"
  default = "4.9.15"
}
variable "cluster_no_of_compute_nodes" {
  type = number
  description = "Number of worker nodes to be provisioned"
  default = 1
}
variable "cluster_compute-machine-type" {
  type = string
  description = "Instance type for the compute nodes. Determines the amount of memory and vCPU allocated to each compute node. Default m5.xlarge"
  default = "m5.xlarge"
}
variable "cluster_service-cidr" {
  type = string
  description = "ipNet Block of IP addresses for services, for example 172.30.0.0/16 "
  default = "172.30.0.0/16"
}
variable "cluster_pod-cidr" {
  type = string
  description = "ipNet Block of IP addresses from which Pod IP addresses are allocated, for example 10.128.0.0/14 "
  default = "10.128.0.0/14"
}
variable "cluster_host-prefix" {
  type = number
  description = "Subnet prefix length to assign to each individual node. For example, if host prefix is set to 23, then each node is assigned a /23 subnet out of the given CIDR."
  default = 23
}
variable "cluster_etcd-encryption" {
  type = string
  description = "Add etcd encryption. By default etcd data is encrypted at rest. This option configures etcd encryption on top of existing storage encryption."
  default = ""
}
variable "cluster_subnet_ids" {
  type = string
  description = "To create cluster in existing VPC, public and private Subnet ids should be given ."
  default = "[]"
}
variable "cluster_private-link" {
  type = bool
  description = "Provides private connectivity between VPCs, AWS services, and your on-premises networks, without exposing your traffic to the public internet"
  default = true
}
