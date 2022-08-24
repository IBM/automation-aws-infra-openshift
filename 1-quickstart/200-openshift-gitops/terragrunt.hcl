include "root" {
  path = find_in_parent_folders()
}

locals {
  dependencies = yamldecode(file("${get_parent_terragrunt_dir()}/layers.yaml"))

  names_105 = local.dependencies.names_105
  filtered_names_105 = [for dir in local.names_105 : "${get_parent_terragrunt_dir()}/${dir}" if fileexists("${get_parent_terragrunt_dir()}/${dir}/terragrunt.hcl")]
  cluster_config_path = length(local.filtered_names_105) > 0 ? local.filtered_names_105[0] : "${get_parent_terragrunt_dir()}/.mocks/${local.mock_105}"
  mock_105 = local.dependencies.mock_105
}

terraform {
  extra_arguments "reduced_parallelism" {
    commands  = get_terraform_commands_that_need_parallelism()
    arguments = ["-parallelism=3"]
  }
    before_hook "wait_time" {                                             
      commands        = ["apply"]                                        
      execute         = ["bash","../waittime.sh"]                           
      run_on_error    = true                           
  }  
}

dependency "cluster" {
  config_path = local.cluster_config_path
  skip_outputs = false

  mock_outputs_allowed_terraform_commands = ["validate", "init", "plan", "destroy", "output"]
  mock_outputs = {
    server_url = ""
    cluster_login_user = ""
    cluster_login_password = ""
    cluster_login_token = ""
  }
}


inputs = {
    server_url = dependency.cluster.outputs.server_url
    cluster_login_user = dependency.cluster.outputs.username
    cluster_login_password = dependency.cluster.outputs.password
    cluster_login_token=""
}
