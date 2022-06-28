resource null_resource print_inputs {

  provisioner "local-exec" {
    when    = create
    command = <<-EOF
      echo server_url  : ${var.server_url}
      echo cluster_login_user : ${var.cluster_login_user}
      echo cluster_login_password  : ${var.cluster_login_password}
      echo cluster_login_token  : ${var.cluster_login_token}
      echo cluster_skip  : ${var.cluster_skip}
    EOF
  }
}
