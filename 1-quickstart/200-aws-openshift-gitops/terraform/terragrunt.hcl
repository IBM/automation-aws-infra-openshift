dependencies {
        paths = ["../105-aws-vpc-openshift"]
}
dependency "ocp-info" {
    config_path = "../105-aws-vpc-openshift"

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
    cluster_login_token=dependency.ocp-info.outputs.token 
}