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
variable "provision" {
  type = bool
  description = "Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up"
  default = true
}
variable "aws-vpc_instance_tenancy" {
  type = string
  description = "Instance is shared / dedicated, etc. #[default, dedicated, host]"
  default = "default"
}
variable "name_prefix" {
  type = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default = "sw-bom9"
}
variable "aws-vpc_enable_dns_support" {
  type = string
  description = "default is true. [true, false]]"
  default = "true"
}
variable "aws-vpc_enable_dns_hostnames" {
  type = string
  description = "Default is false. [true, false]]. Set to true for ROSA cluster"
  default = "true"
}
variable "resource_group_name" {
  type = string
  description = "The name of the resource group where the VPC is deployed. On AWS this value becomes a tag."
  default = "default"
}
variable "region" {
  type = string
  description = "the value of region"
  default = "ap-south-1"
}
variable "access_key" {
  type = string
  description = "the value of access_key"
}
variable "secret_key" {
  type = string
  description = "the value of secret_key"
}
variable "igw_name" {
  type = string
  description = "The name of the IGW instance"
  default = ""
}
variable "aws-kms_description" {
  type = string
  description = "The description of the key as viewed in AWS console."
  default = "Storage-kms"
}
variable "aws-kms_key_spec" {
  type = string
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1"
  default = "SYMMETRIC_DEFAULT"
}
variable "aws-kms_enabled" {
  type = bool
  description = "Specifies whether the key is enabled."
  default = true
}
variable "aws-kms_policy_file" {
  type = string
  description = "Specifies the file name for kms policy."
  default = "scripts/kms-policy/kms-policy.json"
}
variable "aws-kms_rotation_enabled" {
  type = bool
  description = "Specifies whether key rotation is enabled."
  default = true
}
variable "aws-kms_alias" {
  type = string
  description = "The display name of the key."
  default = "Storage-kms"
}
variable "aws-kms_kms_alias" {
  type = string
  description = "The description of the key alias as viewed in AWS console."
  default = "Storage-kms"
}
variable "pri_subnets_resource_group_name" {
  type = string
  description = "The name of the resource group where the VPC is deployed. On AWS this value becomes a tag."
  default = "default"
}
variable "pri_subnets_label" {
  type = string
  description = "label to define type of subnet"
  default = "private"
}
variable "pri_subnets_pri_subnets_cidrs" {
  type = string
  description = "(Required) The CIDR block for the  subnet."
  default = "[\"10.0.4.0/24\",\"10.0.5.0/24\",\"10.0.6.0/24\"]"
}
variable "pri_subnets_availability_zones" {
  type = string
  description = "List of availability zone ids"
  default = "[\"ap-south-1a\",\"ap-south-1b\",\"ap-south-1c\"]"
}
variable "pri_subnets_customer_owned_ipv4_pool" {
  type = string
  description = "Type of the subnet: Public / Private"
  default = ""
}
variable "pri_subnets_map_customer_owned_ip_on_launch" {
  type = string
  description = "Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address. The customer_owned_ipv4_pool and  arguments must be specified when set to true. Default is false."
  default = "false "
}
variable "pri_subnets_map_public_ip_on_launch" {
  type = string
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is fals"
  default = "false"
}
variable "pri_subnets_acl_rules" {
  type = string
  description = "the value of pri_subnets_acl_rules"
  default = "[]"
}
variable "ngw_name" {
  type = string
  description = "The name of the NGW instance"
  default = ""
}
variable "ngw_resource_group_name" {
  type = string
  description = "The name of the resource group where the VPC is deployed. On AWS this value becomes a tag."
  default = "default"
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
variable "pub_subnets_resource_group_name" {
  type = string
  description = "The name of the resource group where the VPC is deployed. On AWS this value becomes a tag."
  default = "default"
}
variable "pub_subnets_label" {
  type = string
  description = "label to define type of subnet"
  default = "public"
}
variable "pub_subnets_pub_subnet_cidrs" {
  type = string
  description = "(Required) The CIDR block for the  subnet."
  default = "[\"10.0.1.0/24\",\"10.0.2.0/24\",\"10.0.3.0/24\"]"
}
variable "pub_subnets_availability_zones" {
  type = string
  description = "List of availability zone ids"
  default = "[\"ap-south-1a\",\"ap-south-1b\",\"ap-south-1c\"]"
}
variable "pub_subnets_customer_owned_ipv4_pool" {
  type = string
  description = "Type of the subnet: Public / Private"
  default = ""
}
variable "pub_subnets_map_customer_owned_ip_on_launch" {
  type = string
  description = "Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address. The customer_owned_ipv4_pool and  arguments must be specified when set to true. Default is false."
  default = "false "
}
variable "pub_subnets_map_public_ip_on_launch" {
  type = string
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is fals"
  default = "false"
}
variable "pub_subnets_acl_rules" {
  type = string
  description = "the value of pub_subnets_acl_rules"
  default = "[]"
}
variable "rosa-cluster_rosa_token" {
  type = string
  description = "get an offline access token at https://cloud.redhat.com/openshift/token/rosa "
  default = ""
}
variable "rosa-cluster_dry_run" {
  type = bool
  description = "Set to true to dry the command just to verify. Else set to false to actually run the cmd"
  default = false
}
variable "rosa-cluster_existing_vpc" {
  type = bool
  description = "Flag to identify if VPC already exists. Default set to true. Used to identify to pass the subnet ids to create the ROSA cluster"
  default = true
}
variable "rosa-cluster_cluster_name" {
  type = string
  description = "Name of the RedHat OpenShift Cluster"
  default = ""
}
variable "rosa-cluster_ocp_version" {
  type = string
  description = "Version of OpenShift that will be used to install the cluster"
  default = "4.9.15"
}
variable "rosa-cluster_no_of_compute_nodes" {
  type = number
  description = "Number of worker nodes to be provisioned"
  default = 3
}
variable "rosa-cluster_compute-machine-type" {
  type = string
  description = "Instance type for the compute nodes. Determines the amount of memory and vCPU allocated to each compute node."
  default = ""
}
variable "rosa-cluster_machine-cidr" {
  type = string
  description = "ipNet Block of IP addresses used by OpenShift while installing the cluster, for example 10.0.0.0/16 "
  default = "10.0.0.0/16"
}
variable "rosa-cluster_service-cidr" {
  type = string
  description = "ipNet Block of IP addresses for services, for example 172.30.0.0/16 "
  default = "172.30.0.0/16"
}
variable "rosa-cluster_pod-cidr" {
  type = string
  description = "ipNet Block of IP addresses from which Pod IP addresses are allocated, for example 10.128.0.0/14 "
  default = "10.128.0.0/14"
}
variable "rosa-cluster_host-prefix" {
  type = number
  description = "Subnet prefix length to assign to each individual node. For example, if host prefix is set to 23, then each node is assigned a /23 subnet out of the given CIDR."
  default = 23
}
variable "rosa-cluster_etcd-encryption" {
  type = string
  description = "Add etcd encryption. By default etcd data is encrypted at rest. This option configures etcd encryption on top of existing storage encryption."
  default = ""
}
variable "rosa-cluster_subnet_ids" {
  type = string
  description = "To create cluster in existing VPC, public and private Subnet ids should be given ."
  default = "[]"
}
variable "rosa-cluster_multi-zone-cluster" {
  type = bool
  description = " Deploy to multiple data centers"
  default = true
}
variable "rosa-cluster_private-link" {
  type = bool
  description = "Provides private connectivity between VPCs, AWS services, and your on-premises networks, without exposing your traffic to the public internet"
  default = false
}
