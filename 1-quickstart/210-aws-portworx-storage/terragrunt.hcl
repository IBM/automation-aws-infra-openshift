include "root" {
  path = find_in_parent_folders()
}

locals {
    px_spec = get_env("TF_VAR_portworx_spec")
    dependencies = yamldecode(file("${get_parent_terragrunt_dir()}/layers.yaml"))
    names_105 = local.dependencies.names_105
    filtered_names_105 = [for dir in local.names_105 : "${get_parent_terragrunt_dir()}/${dir}" if fileexists("${get_parent_terragrunt_dir()}/${dir}/terragrunt.hcl")]
    cluster_config_path = length(local.filtered_names_105) > 0 ? local.filtered_names_105[0] : "${get_parent_terragrunt_dir()}/.mocks/${local.mock_105}"
    mock_105 = local.dependencies.mock_105

}


# dependencies {
#         paths = ["../105-aws-vpc-openshift"]
# }


dependency "cluster" {
    #config_path = "../105-aws-vpc-openshift"
    config_path = local.cluster_config_path
    skip_outputs = false
    mock_outputs_allowed_terraform_commands = ["init","validate","plan", "destroy", "output"]
    mock_outputs = {
        server_url = ""
        username = ""
        password = ""
    }
}


inputs = {
    server_url = dependency.cluster.outputs.server_url
    cluster_login_user = dependency.cluster.outputs.username
    cluster_login_password = dependency.cluster.outputs.password
    #cluster_login_token=dependency.cluster.outputs.token 
    cluster_login_token=""
    aws-portworx_portworx_spec = local.px_spec

}

retry_max_attempts = 3
retry_sleep_interval_sec = 60