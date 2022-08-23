module "aws-portworx" {
  source = "github.com/cloud-native-toolkit/terraform-aws-portworx?ref=v0.1.0"

  access_key = var.access_key
  cluster_config_file = module.cluster.config_file_path
  disk_size = var.aws-portworx_disk_size
  enable_encryption = var.aws-portworx_enable_encryption
  kvdb_disk_size = var.aws-portworx_kvdb_disk_size
  portworx_spec = var.aws-portworx_portworx_spec
  portworx_spec_file = var.aws-portworx_portworx_spec_file
  provision = var.aws-portworx_provision
  px_enable_csi = var.aws-portworx_px_enable_csi
  px_enable_monitoring = var.aws-portworx_px_enable_monitoring
  region = var.region
  secret_key = var.secret_key
}
module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ocp-login?ref=v1.4.2"
  server_url = var.server_url
  login_user = var.cluster_login_user
  login_password = var.cluster_login_password
  login_token =""
  
}
