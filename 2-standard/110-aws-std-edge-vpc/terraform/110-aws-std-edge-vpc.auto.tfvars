## provision: Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up
#provision="true"

## name_prefix: Prefix to be added to the names of resources which are being provisioned
#name_prefix="aws-std"

## resource_group_name: The name of the resource group where the VPC is deployed. On AWS this value becomes a tag.
#resource_group_name="edge"

## region: the value of region
#region="ap-south-1"

## access_key: the value of access_key
#access_key=""

## secret_key: the value of secret_key
#secret_key=""

## edge-vpn_allowed_cidr_ranges: List of CIDR ranges from which access is allowed
#edge-vpn_allowed_cidr_ranges="10.0.0.0/16"

## edge-vpn_client_cidr_block: client cidr block
#edge-vpn_client_cidr_block="172.13.0.0/16"

## edge-vpn_authentication_saml_provider_arn: (Optional) The ARN of the IAM SAML identity provider if type is federated-authentication.
#edge-vpn_authentication_saml_provider_arn=""

## edge-vpn_dns_servers: List of DNS Servers.
#edge-vpn_dns_servers="10.0.0.2"

## aws-ec2-bastion_ami_id: AMI ID for bastion host
#aws-ec2-bastion_ami_id="ami-08df646e18b182346"

## aws-ec2-bastion_instance_type: EC2 Instance Type 2 default
#aws-ec2-bastion_instance_type="t2.micro"

## storage_kms_user_arn: the value of storage_kms_user_arn
#storage_kms_user_arn="arn:aws:iam::005990573564:root"

## edge-nat_connectivity_type: (Optional) Connectivity type for the gateway. Valid values are private and public. Defaults to public.
#edge-nat_connectivity_type="public"
