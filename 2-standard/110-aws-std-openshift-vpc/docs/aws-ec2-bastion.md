# Starter kit for a Terraform module

This is a Starter kit to help with the creation of Terraform modules. The basic structure of a Terraform module is fairly
simple and consists of the following basic values:

- README.md - provides a description of the module
- main.tf - defiens the logic for the module
- variables.tf (optional) - defines the input variables for the module
- outputs.tf (optional) - defines the values that are output from the module

Beyond those files, any other content can be added and organized however you see fit. For example, you can add a `scripts/` directory
that contains shell scripts executed by a `local-exec` `null_resource` in the terraform module. The contents will depend on what your
module does and how it does it.

## Instructions for creating a new module

1. Update the title and description in the README to match the module you are creating
2. Fill out the remaining sections in the README template as appropriate
3. Implement your logic in the in the main.tf, variables.tf, and outputs.tf
4. Use releases/tags to manage release versions of your module

## Module overview

### Description

Description of module

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

### Software dependencies

The module depends on the following software components:

#### Command-line tools

- terraform >= v0.15

#### Terraform providers

- IBM Cloud provider >= 1.5.3

### Module dependencies

This module makes use of the output from other modules:

- Cluster - github.com/cloud-native-toolkit/terraform-ibm-container-platform.git
- Namespace - github.com/cloud-native-toolkit/terraform-cluster-namespace.git
- etc

### Example usage

```hcl-terraform
module "argocd" {
  source = "github.com/cloud-native-toolkit/terraform-tools-argocd.git"

  cluster_config_file = module.dev_cluster.config_file_path
  cluster_type        = module.dev_cluster.type
  app_namespace       = module.dev_cluster_namespaces.tools_namespace_name
  ingress_subdomain   = module.dev_cluster.ingress_hostname
  olm_namespace       = module.dev_software_olm.olm_namespace
  operator_namespace  = module.dev_software_olm.target_namespace
  name                = "argocd"
}
```

## Development

Development of the module should follow standard open source development practices with Git. DevOps automation has been provided in the repository to support this approach:

1. If necessary, create a fork of the repository.
2. Create a branch where the development will take place. (Even if the development is done in a fork it is a good practice to make the changes in a branch on the fork instead of making the changes directly in `main`.)
3. Push the branch early to the remote repository and create a pull request. If the pull request is not ready to be merged yet then create the pull request as a `draft`.
4. Automated checks will run against the pull request to verify the module. If the checks all pass then the pull request can be merged.
5. After a pull request is merged the automation workflows will publish a release of the module.
6. After a release is published, the module metadata is generated and published to GitHub pages on the `gh-pages` branch. Also, the [cloud-native-toolkit/automation-modules](https://github.com/cloud-native-toolkit/automation-modules) repository is notified of the new version of the module so that the module catalog will be updated. 

### Repository automation

The module provides GitHub actions to perform automation for different events 

#### Automated validation

- The terraform template for the test is placed in `test/stages`
- Dependencies of the module under test should be represented in modules that reference the git repo
- The source of the module under test should be './module' (the verify process copies the contents of the module into a folder named 'module')
- The GitHub Action automation logic is defined in `.github/workflows/verify.yaml`. The workflow runs on every pull request against the main branch and every commit pushed to the main branch.
- The test case(s) that will be applied in the test are listed in the `strategy.matrix.testcase` variable of the workflow. The test case definitions are provided in the https://github.com/cloud-native-toolkit/action-module-verify repository in the `env` folder.
- The workflow uses a number of GitHub secrets for privileged information. These values are stored in the Cloud Native Toolkit org and shared by all the repositories. If a fork of the module is created then the secrets will need to be added to the fork repository as well.
    - `IBMCLOUD_API_KEY` - the api key of the account
    - `GIT_ADMIN_USERNAME` - username for gitops tests
    - `GIT_ADMIN_TOKEN` - personal access token for gitops tests
    - `GIT_ORG` - org for gitops tests

#### Module metadata 

- Module metadata is generated with each release and published to gh-pages
- The module.yaml in the repo defines the name and description of the module as well as any external dependencies
- The key values to provide are the name and description values. If the module uses the IBM Cloud terraform provider, it should be included in the in the providers section.
