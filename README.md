# AWS Cloud Reference Architecture - Automation

> This collection of AWS Cloud terraform automation bundles has been crafted from a set of [Terraform modules](https://modules.cloudnativetoolkit.dev/) created by the IBM Ecosystem Labs team part of the [IBM Ecosystem organization](https://www.ibm.com/partnerworld/public?mhsrc=ibmsearch_a&mhq=partnerworld). Please contact **Matthew Perrins** __mjperrin@us.ibm.com__, **Sean Sundberg** __seansund@us.ibm.com__, **Indira Kalagara** __indira.kalagara@in.ibm.com__, **Sivasailam Vellaisamy** __sivasaivm@in.ibm.com__ or **Andrew Trice** __amtrice@us.ibm.com__ for more details or raise an issue on the [repository](https://github.com/cloud-native-toolkit/software-everywhere) for bugs or feature requests.

Three different flavors of the reference architecture are provided with different levels of complexity.

- QuickStart - minimum to get OpenShift with public endpoints running on basic VPC + Subnet with ROSA
- Standard - a simple robust architecture that can support a production workload in a single VPC with a VPN+Private Endpoints and a ROSA cluster
- Advanced - a sophisticated architecture isolating DMZs, Development and Production VPCs for best practices

## Reference architectures

This set of automation packages was generated using the open-source [`isacable`](https://github.com/cloud-native-toolkit/iascable) tool. This tool enables a [Bill of Material yaml](https://github.com/cloud-native-toolkit/automation-solutions/tree/main/boms) file to describe your AWS Cloud architecture, which it then generates the terraform modules into a package of infrastructure as code that you can use to accelerate the configuration of your AWS Cloud environment. Iascable generates standard terraform templates that can be executed from any terraform environment.

> The `iascable` tool is targeted for use by advanced SRE developers. It requires deep knowledge of how the modules plug together into a customized architecture. This repository is a fully tested output from that tool. This makes it ready to consume for projects.

### Quick Start

![QuickStart](1-quickstart/aws_quickstart_architecture.png)

### Standard

TBD

### Advanced

TBD

## Automation

### Prerequisites

1. Have access to an AWS Cloud Account. An Enterprise account is best for workload isolation but this terraform can be run in a Pay Go account as well.

2. (Optional) Install and start Colima to run the terraform tools in a local bootstrapped container image.

    ```shell
    brew install docker colima
    colima start
    ```

### Planning

1. Determine which flavor of reference architecture you will provision: Quick Start, Standard, or Advanced.
2. View the README in the automation directory for detailed instructions for installation steps and required information:
    - [Quick Start](1-quickstart)
    - [Standard](2-standard)
    - [Advanced](3-advanced)

### Setup

1. Clone this repository to your local SRE laptop or into a secure terminal. Open a shell into the cloned directory.
2. Copy **credentials.template** to **credentials.properties**.
    ```shell
    cp credentials.template credentials.properties
    ```
3. Provide values for the variables in **credentials.properties** (**Note:** `*.properties` has been added to **.gitignore** to ensure that the file containing the apikey cannot be checked into Git.)
    - **TF_VAR_aws_access_key_id** - The API key for the AWS Cloud account where the infrastructure will be provisioned.
    - **TF_VAR_aws_secret_access_key** - The API key for the AWS Cloud account where the infrastructure will be provisioned.
    - **AWS_ACCESS_KEY_ID=** - The API key for the AWS Cloud account where the infrastructure will be provisioned.
    - **AWS_SECRET_ACCESS_KEY** - The API key for the AWS Cloud account where the infrastructure will be provisioned.
    - **TF_VAR_rosa_token** - The offline rosa token used to provision  ROSA cluster

    ```
    Users can download ROSA token from [RHN Link](https://cloud.redhat.com/openshift/token/rosa) using RHN Login credentails.
    ```
    - **TF_VAR_gitops_repo_username** - The username on github.com that will be used to provision the gitops repository.
    - **TF_VAR_gitops_repo_token** - The personal access token that will be used to authenticate to github.com to provision the gitops repository. (The user should have necessary access in the org to create the repository and the token should have `delete_repo` permission.)
    - **TF_VAR_gitops_repo_org** - (Optional) The github.com org where the gitops repository will be provisioned. If not provided the org will default to the username.
    

4. Run **./launch.sh**. This will start a container image with the prompt opened in the `/terraform` directory, pointed to the repo directory.
5. Create a working copy of the terraform by running **./setup-workspace.sh**. The script makes a copy of the terraform in `/workspaces/current` and set up a "terraform.tfvars" file populated with default values. The script can be run interactively by just running ./setup-workspace.sh or by providing command line parameters as specified below.

    ```
   Usage: setup-workspace.sh [-f FLAVOR] [-s STORAGE] [-r REGION] [-n PREFIX_NAME]

where:
  - **FLAVOR** - the type of deployment `quickstart`, `standard` or `advanced`. If not provided, will default to quickstart.
  - **STORAGE** - The storage provider. Possible options are `portworx` or `odf`. If not provided as an argument, a prompt will be shown.
  - **REGION** - the AWS location where the infrastructure will be provided ([available regions](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html)). Codes for each location can be obtained from the CLI using,
        ```shell
        aws ec2 describe-regions --output table
        ```
    If not provided the value defaults to `us-west-1`

    Note : User should always chose a AWS Region with minimum 3 AZs

  - **PREFIX_NAME** - the name prefix that should be added to all the resources. If not provided a prefix will not be added. Note : PREFIX_NAME should not exceed 5 characters.
    
    ```
6. Change the directory to the current workspace where the automation was configured (e.g. `/workspaces/current`).
7. Inspect **terraform.tfvars** to see if there are any variables that should be changed. (The **setup-workspace.sh** script has generated **terraform.tfvars** with default values and can be used without updates, if desired.)

    **Note:** A soft link has been created to the **terraform.tfvars** in each of the terraform subdirectories so the configuration is shared between all of them. 

#### Run all the terraform layers automatically

From the **/workspace/current** directory, run the following:

```
./apply-all.sh
```

The script will run through each of the terraform layers in sequence to provision the entire infrastructure.

#### Run all the terraform layers manually

From the **/workspace/current** directory, run change directory into each of the layer subdirectories and run the following:

```shell
terragrunt init
terragrunt apply -auto-approve
```
