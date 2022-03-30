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
variable "name_prefix" {
  type = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default = "swe"
}
variable "aws-vpc_enable_dns_support" {
  type = string
  description = "default is true. [true, false]]"
  default = "true"
}
variable "aws-vpc_enable_dns_hostnames" {
  type = string
  description = "Default is false. [true, false]]. Set to true for ROSA cluster"
  default = "false"
}
variable "resource_group_name" {
  type = string
  description = "The name of the resource group where the VPC is deployed. On AWS this value becomes a tag."
  default = "default"
}
variable "region" {
  type = string
  description = "the value of region"
}
variable "access_key" {
  type = string
  description = "the value of access_key"
}
variable "secret_key" {
  type = string
  description = "the value of secret_key"
}
variable "aws-vpc-subnets_provision" {
  type = bool
  description = "Provision Subnet if  true."
  default = true
}
variable "aws-vpc-subnets_resource_group_name" {
  type = string
  description = "The name of the resource group where the VPC is deployed. On AWS this value becomes a tag."
  default = "default"
}
variable "aws-vpc-subnets_name_prefix" {
  type = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default = "swe"
}
variable "aws-vpc-subnets_label" {
  type = string
  description = "label to define type of subnet"
  default = "private"
}
variable "aws-vpc-subnets_gateways" {
  type = string
  description = "List of gateway ids and zones"
  default = "[]"
}
variable "aws-vpc-subnets_subnet_cidrs" {
  type = string
  description = "(Required) The CIDR block for the  subnet."
  default = "[]"
}
variable "aws-vpc-subnets_availability_zones" {
  type = string
  description = "List of availability zone ids"
  default = "[]"
}
variable "aws-vpc-subnets_customer_owned_ipv4_pool" {
  type = string
  description = "Type of the subnet: Public / Private"
  default = ""
}
variable "aws-vpc-subnets_map_customer_owned_ip_on_launch" {
  type = string
  description = "Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address. The customer_owned_ipv4_pool and  arguments must be specified when set to true. Default is false."
  default = "false"
}
variable "aws-vpc-subnets_map_public_ip_on_launch" {
  type = string
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is fals"
  default = "false"
}
variable "aws-vpc-subnets_allocation_id" {
  type = string
  description = " For NAT Gateway. Required if connectivity_type is public."
  default = ""
}
variable "aws-vpc-subnets_connectivity_type" {
  type = string
  description = "For NAT Gateway. Valid values are private and public. Defaults to public."
  default = "public"
}
variable "aws-vpc-subnets_acl_rules" {
  type = string
  description = "the value of aws-vpc-subnets_acl_rules"
  default = "[]"
}
variable "rosa-cluster_prefix_name" {
  type = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default = "swe"
}
variable "rosa_token" {
  type = string
  description = "get an offline access token at https://cloud.redhat.com/openshift/token/rosa "
  default = ""
}
variable "dry_run" {
  type = bool
  description = "Set to true to dry the command just to verify. Else set to false to actually run the cmd"
  default = true
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
  default = 2
}
variable "rosa-cluster_compute-machine-type" {
  type = string
  description = "Instance type for the compute nodes. Determines the amount of memory and vCPU allocated to each compute node."
  default = ""
}
variable "machine-cidr" {
  type = string
  description = "ipNet Block of IP addresses used by OpenShift while installing the cluster, for example 10.0.0.0/16 "
  default = ""
}
variable "service-cidr" {
  type = string
  description = "ipNet Block of IP addresses for services, for example 172.30.0.0/16 "
  default = ""
}
variable "pod-cidr" {
  type = string
  description = "ipNet Block of IP addresses from which Pod IP addresses are allocated, for example 10.128.0.0/14 "
  default = ""
}
variable "host-prefix" {
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
variable "public_subnet_ids" {
  type = string
  description = "To create cluster in existing VPC, public and private Subnet ids should be given ."
  default = "[]"
}
variable "private_subnet_ids" {
  type = string
  description = "To create cluster in existing VPC, public and private Subnet ids should be given ."
  default = "[]"
}
variable "rosa-cluster_multi-zone-cluster" {
  type = string
  description = " Deploy to multiple data centers"
  default = ""
}
variable "rosa-cluster_private-link" {
  type = string
  description = "Provides private connectivity between VPCs, AWS services, and your on-premises networks, without exposing your traffic to the public internet"
  default = ""
}
variable "rosa-cluster_subnet-ids" {
  type = string
  description = "The Subnet IDs to use when installing the cluster. Format should be a comma-separated list. Leave empty for installer provisioned subnet IDs"
  default = ""
}
variable "aws-internet-gateway_name" {
  type = string
  description = "The name of the IGW instance"
  default = """ "
}
variable "aws-internet-gateway_provision" {
  type = bool
  description = "Flag to determine whether to provision Internet gateway or not. Defautl set to true"
  default = true
}
