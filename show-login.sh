#/bin/bash

# Add check that cluster has been built

if [[ "${1}" == "quickstart" ]]; then
  cd 105-aws-vpc-openshift
else
    if [[ "${1}" == "standard" ]]; then
    cd 110-aws-std-openshift-vpc
    fi
fi


SERVER_URL=$(terragrunt output -raw cluster_server_url )
USERNAME=$(terragrunt output -raw cluster_username )
PASSWORD=$(terragrunt output -raw cluster_password )
CONSOLE_URL=$(terragrunt output -raw cluster_console_url )

# Show console URL
echo ""
echo "To login to the console (may take a few minutes for certificate to be applied to cluster):"
echo "Console URL - ${CONSOLE_URL}"
echo "Username    - ${USERNAME}"
echo "Password    - ${PASSWORD}"

