#!/bin/bash

# IBM Ecosystem Labs

# SCRIPT_DIR="$(cd $(dirname $0); pwd -P)"
# SRC_DIR="${SCRIPT_DIR}"

SCRIPT_DIR="$(cd $(dirname "$0"); pwd -P)"
SRC_DIR="${SCRIPT_DIR}/automation"

AUTOMATION_BASE=$(basename "${SCRIPT_DIR}")

if [[ ! -d "${SRC_DIR}" ]]; then
  SRC_DIR="${SCRIPT_DIR}"
fi

 echo $SCRIPT_DIR
 echo $AUTOMATION_BASE


#DOCKER_IMAGE="quay.io/cloudnativetoolkit/terraform:v1.0.0-v1.1"
#DOCKER_IMAGE="quay.io/cloudnativetoolkit/cli-tools:v1.1"
DOCKER_IMAGE="quay.io/cloudnativetoolkit/cli-tools:v1.2-v2.1.2"


SUFFIX=$(echo $(basename ${SCRIPT_DIR}) | base64 | sed -E "s/[^a-zA-Z0-9_.-]//g" | sed -E "s/.*(.{5})/\1/g")
CONTAINER_NAME="cli-tools-${SUFFIX}"

echo "Cleaning up old container: ${CONTAINER_NAME}"

DOCKER_CMD="docker"
${DOCKER_CMD} kill ${CONTAINER_NAME} 1> /dev/null 2> /dev/null
${DOCKER_CMD} rm ${CONTAINER_NAME} 1> /dev/null 2> /dev/null

if [[ -n "$1" ]]; then
    echo "Pulling container image: ${DOCKER_IMAGE}"
    ${DOCKER_CMD} pull "${DOCKER_IMAGE}"
fi

ENV_FILE=""
if [[ -f "credentials.properties" ]]; then
  ENV_FILE="--env-file credentials.properties"
fi

# echo "Initializing container ${CONTAINER_NAME} from ${DOCKER_IMAGE}"
# ${DOCKER_CMD} run -itd --name ${CONTAINER_NAME} \
#    -v ${SRC_DIR}:/terraform \
#    -v workspace:/workspaces \
#    ${ENV_FILE} \
#    -w /terraform \
#    ${DOCKER_IMAGE}

# echo "Attaching to running container..."
# ${DOCKER_CMD} attach ${CONTAINER_NAME}

# echo "Initializing container ${CONTAINER_NAME} from ${DOCKER_IMAGE}"
# ${DOCKER_CMD} run -itd --privileged --name ${CONTAINER_NAME} \
#    -v "${SRC_DIR}:/terraform" \
#    -v "workspace-${AUTOMATION_BASE}:/workspaces" \
#    ${ENV_FILE} \
#    -w /terraform \
#    ${DOCKER_IMAGE}

echo "Initializing container ${CONTAINER_NAME} from ${DOCKER_IMAGE}"
${DOCKER_CMD} run -itd --name ${CONTAINER_NAME} \
   --device /dev/net/tun --cap-add=NET_ADMIN \
   -v "${SRC_DIR}:/terraform" \
   -v "workspace-${AUTOMATION_BASE}:/workspaces" \
   ${ENV_FILE} \
   -w /terraform \
   ${DOCKER_IMAGE}

echo "Attaching to running container..."
${DOCKER_CMD} attach ${CONTAINER_NAME}