include "root" {
  path = find_in_parent_folders()
}

dependency "cluster" {
  config_path = local.cluster_config_path
  skip_outputs = false

  mock_outputs_allowed_terraform_commands = ["validate", "init", "plan", "destroy", "output"]
  mock_outputs = {
    cluster_server_url = ""
    cluster_username = ""
    cluster_password = ""
    cluster_token = ""
  }
}

locals {
  dependencies = yamldecode(file("${get_parent_terragrunt_dir()}/layers.yaml"))

  names_cluster = local.dependencies["cluster"].names
  mock_cluster = local.dependencies["cluster"].mock
  filtered_names_cluster = [for dir in local.names_cluster : "${get_parent_terragrunt_dir()}/${dir}" if fileexists("${get_parent_terragrunt_dir()}/${dir}/terragrunt.hcl")]
  cluster_config_path = length(local.filtered_names_cluster) > 0 ? local.filtered_names_cluster[0] : "${get_parent_terragrunt_dir()}/.mocks/${local.mock_cluster}"
}


inputs = {

    server_url             = dependency.cluster.outputs.cluster_server_url
    cluster_login_user = dependency.cluster.outputs.cluster_username
    cluster_login_password = dependency.cluster.outputs.cluster_password
    #cluster_login_token    = dependency.cluster.outputs.cluster_token
    cluster_login_token=""    

}

terraform {
  before_hook "check_vpn" {
      commands        = ["apply","plan","destroy","validate","output"]
      execute         = ["bash", "../check-vpn.sh"]
      run_on_error    = true
  }  
  before_hook "wait_time" {                                             
      commands        = ["apply"]                                        
      execute         = ["bash","../waittime.sh"]                           
      run_on_error    = true                           
  }    
}