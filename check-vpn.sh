#!/usr/bin/env bash

ROOT_DIRECTORY=$(cd $(dirname "$0"); pwd -P)
BOM_DIRECTORY="${PWD}"
echo "ROOT_DIRECTORY : ${ROOT_DIRECTORY}"
echo "BOM_DIRECTORY : ${BOM_DIRECTORY}"

VPN_REQUIRED=$(grep "vpn/required" "${BOM_DIRECTORY}/bom.yaml" | sed -E "s~[^:]+: [\"'](.*)[\"']~\1~g")
echo "VPN_REQUIRED: ${VPN_REQUIRED}"

if [[ "${VPN_REQUIRED}"=="true" ]]; then
   RUNNING_PROCESSES=$(ps -ef)
   VPN_RUNNING=$(echo "${RUNNING_PROCESSES}" | grep "openvpn --config")

    if [[ -n "${VPN_RUNNING}" ]]; then
      echo "VPN required but it is already running"
    elif command -v openvpn 1> /dev/null 2> /dev/null; then
      OVPN_FILE=$(find "${ROOT_DIRECTORY}" -name "*.ovpn" | head -1)
      NAMESERVER_FILE=$(find "${ROOT_DIRECTORY}" -name "nameserver" | head -1)
      echo "OVPN_FILE: ${OVPN_FILE}"

      if [[ -z "${OVPN_FILE}" ]]; then
        echo "VPN profile not found."
        exit 1
      fi

      echo "Connecting to vpn with profile: ${OVPN_FILE}"
      if [[ "${UID}" -eq 0 ]]; then
        echo "when UID is 0"
        exec 1<&-
        exec 2<&-
        sudo chmod 777 /etc/resolv.conf
        sudo cp /etc/resolv.conf /etc/resolv.conf_bkp
        sudo cat "${NAMESERVER_FILE}" > /etc/resolv.conf
        sudo cat /etc/resolv.conf          
        sudo chmod 644 /etc/resolv.conf      
        openvpn --config "${OVPN_FILE}" || true &
        
      else
        echo "when UID is NOT 0"
        exec 1<&-
        exec 2<&-
        sudo chmod 777 /etc/resolv.conf
        sudo cp /etc/resolv.conf /etc/resolv.conf_bkp
        sudo cat "${NAMESERVER_FILE}" > /etc/resolv.conf
        sudo cat /etc/resolv.conf            
        sudo chmod 644 /etc/resolv.conf      
        
        sudo openvpn --config "${OVPN_FILE}" || true &
      fi
    else
      echo "VPN connection required but unable to create the connection automatically. Please connect to your vpn instance using the .ovpn profile within the 110-ibm-fs-edge-vpc directory and re-run apply-all.sh."
      exit 1
    fi
else
  echo "VPN not required"
fi