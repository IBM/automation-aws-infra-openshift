## provision: Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up
provision="true"

## name_prefix: Prefix to be added to the names of resources which are being provisioned
name_prefix="sw-bom9"

## resource_group_name: The name of the resource group where the VPC is deployed. On AWS this value becomes a tag.
resource_group_name="quickstart"

## region: the value of region
region="ap-south-1"

## access_key: the value of access_key
#access_key=""

## secret_key: the value of secret_key
#secret_key=""

## ngw_connectivity_type: (Optional) Connectivity type for the gateway. Valid values are private and public. Defaults to public.
#ngw_connectivity_type="public"

## rosa-cluster_rosa_token: get an offline access token at https://cloud.redhat.com/openshift/token/rosa 
#rosa-cluster_rosa_token=""

## rosa-cluster_no_of_compute_nodes: Number of worker nodes to be provisioned
#rosa-cluster_no_of_compute_nodes="3"

