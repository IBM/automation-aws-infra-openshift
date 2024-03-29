# AWS Cloud Reference Architecture - Automation

Automation to provision the Quick Start reference architecture on AWS Cloud. This architecture implements the minimum infrastructure required to stand up a managed Red Hat OpenShift cluster with public endpoints.

## Reference Architecture

![Standard](aws_standard_architecture.png)

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
<h4>Shared Services</h4>
<ul>
<li>Object Storage</li>
<li>Key Managment Service</li>
<li>Monitoring</li>
<ul>
</ul>
</td>
</tr>
<tr>
<td>200 -  AWS OpenShift Gitops </td>
<td>This layer provisions OpenShift CI/CD tools into the cluster, a GitOps repository, and bootstraps the repository to the OpenShift Gitops instance.</td>
<td>
<h4>Software </h4>
<ul>
<li>OpenShift GitOps (ArgoCD)</li>
<li>OpenShift Pipelines (Tekton)</li>
<li>Sealed Secrets (Kubeseal)</li>
<li>GitOps repo</li>
</ul>
</td>
</tr>
<tr>
<td>210 - AWS Storage</td>
<td>The storage layer offers `portworx`. Portworx storage can be installed on ROSA cluster.
</td>
<td>
<ul>    
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
<td>220 - Dev Tools</td>
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

2. (Optional) Install and start Docker to run the terraform tools in a local bootstrapped container image. In the below example we have shown install method for Mac. Refer to Docker portal for ([Windows](https://docs.docker.com/desktop/install/windows-install/)) and ([Linux](https://docs.docker.com/desktop/install/linux-install/)) Install procedure.

    ```shell
    brew install docker 
    ```

### Setup

1. Clone this repository to your local SRE laptop or into a secure terminal. Open a shell into the cloned directory.
2. Copy **credentials.template** to **credentials.properties**.
    ```shell
    cp credentials.template credentials.properties
    ```
3. Provide values for the variables in **credentials.properties**  (**Note:** `*.properties` has been added to **.gitignore** to ensure that the file containing the apikey cannot be checked into Git. Do not use quotes around the values in properties file )
    - **TF_VAR_aws_access_key_id** - The API key for the AWS Cloud account where the infrastructure will be provisioned.
    - **TF_VAR_aws_secret_access_key** - The API key for the AWS Cloud account where the infrastructure will be provisioned.
    - **AWS_ACCESS_KEY_ID=** - The API key for the AWS Cloud account where the infrastructure will be provisioned.
    - **AWS_SECRET_ACCESS_KEY** - The API key for the AWS Cloud account where the infrastructure will be provisioned.
    - **TF_VAR_rosa_token** - The offline rosa token used to provision  ROSA cluster
    - **TF_VAR_gitops_repo_username** - The username on github.com that will be used to provision the gitops repository.
    - **TF_VAR_gitops_repo_token** - The personal access token that will be used to authenticate to github.com to provision the gitops repository. (The user should have necessary access in the org to create the repository and the token should have `delete_repo` permission.)
    - **TF_VAR_gitops_repo_org** - (Optional) The github.com org where the gitops repository will be provisioned. If not provided the org will default to the username. 
    - **TF_VAR_portworx_spec** - (Optional) ([Create Portworx Storage Spec](https://central.portworx.com/dashboard)).Kindly refer to following page for ([Portworx Storage Spec creation procedure](https://github.com/cloud-native-toolkit/terraform-aws-portworx/blob/main/PORTWORX_ESSENTIALS.md)).

4. Run **./launch.sh**. This will start a container image with the prompt opened in the `/terraform` directory, pointed to the repo directory.
5. Create a working copy of the terraform by running **./setup-workspace.sh**. . The script makes a copy of the terraform in /workspaces/current and set up "cluster.tfvars" and "gitops.tfvars" files populated with default values. The setup-workspace.sh script has a number of optional arguments.
    
    ```
    Usage: setup-workspace.sh [-f FLAVOR] [-s STORAGE] [-r REGION] [-n PREFIX_NAME] [-b BANNER_TEXT] [-g GIT_HOST] [-h HELP]
    
    options:
     -f   the type of deployment quickstart, standard or advanced. Make sure to use 'standard'
     -s   the storage option to use (portworx)
     -n   (optional) the name prefix that should be added to all the resources and length of prefix should not exceed 5 characters.  If not provided a prefix will not be added. 
     

     -r   (optional) the region where the infrastructure will be provisioned. 
            Note: the AWS Cloud region where the infrastructure will be provided [available regions](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html). Codes for each location can be obtained from the CLI from shell - "aws ec2 describe-regions --output table". If this value is not provided then the value defaults to ap-south-1  (Note : User should always chose a AWS Region with minimum 3 AZs)
              
     -b   (optional) customer message to display on OCP console as a banner
     -g   (optional) the git host that will be used for the gitops repo. If left blank gitea will be used by default. (Github, Github Enterprise ,  Gitlab, Bitbucket, Azure DevOps, and Gitea servers are supported)
     -h   Print this help    

    ```
6. Change the directory to the current workspace where the automation was configured (e.g. `/workspaces/current`).
7. Two different configuration files have been created: **cluster.tfvars** and **gitops.tfvars**. **cluster.tfvars** contains the variables specific to the infrastructure and cluster that will be provisioned. **gitops.tfvars** contains the variables that define the gitops configuration. Inspect both of these files to see if there are any variables that should be changed. (The **setup-workspace.sh** script has generated these two files with default values and can be used without updates, if desired.). E.g. cluster_ocp_version="4.9.15" can be changed to latest version cluster_ocp_version="4.10.01"

#### Run the entire automation stack automatically

From the **/workspace/current** directory, run the following:

```shell
./apply.sh
```

The script will run through each of the terraform layers in sequence to provision the entire infrastructure.

#### Run each of the Terraform layers manually

From the **/workspace/current** directory, change the directory into each of the layer subdirectories, in order, and run the following:

```shell
./apply.sh
```

### Obtain login information

Once the "110-aws-std-openshift-vpc"  has successfully run it is possible to obtain the login information by running from the **/workspace/current** directory:
```shell
./show-login.sh standard
```