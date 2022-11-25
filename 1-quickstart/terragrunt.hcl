terraform {
  extra_arguments "reduced_parallelism" {
    commands  = get_terraform_commands_that_need_parallelism()
    arguments = ["-parallelism=6"]
  }

  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()

    required_var_files = [
      "${get_parent_terragrunt_dir()}/cluster.tfvars",
      "${get_parent_terragrunt_dir()}/gitops.tfvars"
    ]
  }
}

retryable_errors = [
  "(?s).*igc gitops-module.*",
  "(?s).*Error.*failed.*timed out waiting for the condition.*",
  "(?s).*Error.*timed out waiting for the condition.*",
  "(?s).*Error.*Error logging in to.*",
  "(?s).*Error.*running.*command.*argocd-bootstrap.sh",
  "(?s).*Error.*bootstrap_argocd",
  "(?s).*Error creating repo.*",
  "(?s).x509: certificate signed by unknown authority.*"
  
]

retry_sleep_interval_sec = 60
retry_max_attempts = 5
skip = true
