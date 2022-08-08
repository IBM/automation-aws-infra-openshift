dependencies {
        paths = ["../110-aws-std-openshift-vpc"]
}
dependency "ocp-info" {
    config_path = "../110-aws-std-openshift-vpc"

    mock_outputs_allowed_terraform_commands = ["init","validate","plan"]
    mock_outputs = {
        server_url = "https://fake.url.org:6443"
        username = "fakeuser"
        password = "fakepassword"
    }
}

inputs = {
    server_url = dependency.ocp-info.outputs.server_url
    cluster_login_user = dependency.ocp-info.outputs.username
    cluster_login_password = dependency.ocp-info.outputs.password
    #cluster_login_token=dependency.ocp-info.outputs.token 
    cluster_login_token=""

}

terraform {
    # Connect to VPN if required for terraform (checks the bom.yaml)
    before_hook "check_vpn" {
        commands        = ["apply","plan","destroy","validate","output"]
        execute         = ["bash", "../check-vpn.sh"]
        run_on_error    = true
    }
    # Ensures paralellism never exceed three modules at any time
    extra_arguments "reduced_parallelism" {
        commands  = get_terraform_commands_that_need_parallelism()
        arguments = ["-parallelism=3"]
    }
}
