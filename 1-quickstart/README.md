# AWS Cloud Reference Architecture - Automation

Automation to provision the Quick Start reference architecture on AWS Cloud. This architecture implements the minimum infrastructure required to stand up a managed Red Hat OpenShift cluster with public endpoints.

## Reference Architecture

![QuickStart](aws_quickstart_architecture.png)

The automation is delivered in a number of layers that are applied in order. Layer `110` provisions the infrastructure including the Red Hat OpenShift cluster and the remaining layers provide configuration inside the cluster. Each layer depends on resources provided in the layer before it (e.g. `200` depends on `110`). Where two layers have the same numbers (e.g. `205`), you have a choice of which layer to apply.

<table>
<thead>
<tr>
<th>Layer name</th>
<th>Layer description</th>
<th>Provided resources</th>
</tr>
</thead>
<tbody>
<tr>
<td>110 - AWS VPC OpenShift</td>
<td>This layer provisions the bulk of the AWS Cloud infrastructure</td>
<td>
<h4>Network</h4>
<ul>
<li>VPC network</li>
<li>VPC Subnet</li>
<li>VPC Public Gateways</li>
<li>Red Hat OpenShift cluster</li>
</ul>
<ul>
</ul>
</td>
</tr>
<tr>
<td>200 -  AWS OpenShift Gitops (TBD) </td>
<td>This layer provisions OpenShift CI/CD tools into the cluster, a GitOps repository, and bootstraps the repository to the OpenShift Gitops instance.</td>
<td>
<h4>Software (TBD)</h4>
<ul>
<li>OpenShift GitOps (ArgoCD)</li>
<li>OpenShift Pipelines (Tekton)</li>
<li>Sealed Secrets (Kubeseal)</li>
<li>GitOps repo</li>
</ul>
</td>
</tr>
<tr>
<td>205 - AWS Storage (TBD)</td>
<td>The storage layer offers two options: `odf` and `portworx`. Either odf or portworx storage can be installed (or in rare instances, both).</td>
<td>
<h4>ODF Storage</h4>
<ul>
<li>ODF operator</li>
<li>ODF storage classes</li>
</ul>
<h4>Portworx Storage</h4>
<ul>
<li>AWS Cloud storage volumes</li>
<li>Portworx operator</li>
<li>Portworx storage classes</li>
</ul>
</td>
</tr>
<tr>
<td>220 - Dev Tools (TBD)</td>
<td>The dev tools layer installs standard continuous integration (CI) pipelines that integrate with tools that support the software development lifecycle.</td>
<td>
<h4>Software</h4>
<ul>
<li>Artifactory</li>
<li>Developer Dashboard</li>
<li>Pact Broker</li>
<li>Sonarqube</li>
<li>Tekton Resources</li>
</ul>
</td>
</tr>
</tbody>
</table>

## Automation

### Prerequisites

1. Have access to an AWS Cloud Account. An Enterprise account is best for workload isolation but this terraform can be run in a Pay Go account as well.

2. (Optional) Install and start Colima to run the terraform tools in a local bootstrapped container image.

    ```shell
    brew install docker colima
    colima start
    ```

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
    - **TF_VAR_gitops_repo_username** - The username on github.com that will be used to provision the gitops repository.
    - **TF_VAR_gitops_repo_token** - The personal access token that will be used to authenticate to github.com to provision the gitops repository. (The user should have necessary access in the org to create the repository and the token should have `delete_repo` permission.)
    - **TF_VAR_gitops_repo_org** - (Optional) The github.com org where the gitops repository will be provisioned. If not provided the org will default to the username. 
4. Run **./launch.sh**. This will start a container image with the prompt opened in the `/terraform` directory, pointed to the repo directory.
5. Create a working copy of the terraform by running **./setup-workspace.sh**. The script makes a copy of the terraform in `/workspaces/current` and set up a "terraform.tfvars" file populated with default values. The **setup-workspace.sh** script has a number of optional arguments.

    ```
    Usage: setup-workspace.sh [-s STORAGE] [-r REGION] [-n PREFIX_NAME]
    
    where:
      - **STORAGE** - The storage provider. Possible options are `portworx` or `odf`. If not provided as an argument, a prompt will be shown.
      - **REGION** - the IBM Cloud region where the infrastructure will be provided ([available regions](https://cloud.ibm.com/docs/overview?topic=overview-locations#regions)). If not provided the value defaults to `us-east`
      - **PREFIX_NAME** - the name prefix that should be added to all the resources. If not provided a prefix will not be added.
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
terraform init
terraform apply -auto-approve
```
