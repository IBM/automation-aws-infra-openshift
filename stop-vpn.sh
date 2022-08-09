#!/usr/bin/env bash

ROOT_DIRECTORY=$(cd $(dirname "$0"); pwd -P)
BOM_DIRECTORY="${PWD}"
echo "ROOT_DIRECTORY : ${ROOT_DIRECTORY}"
echo "BOM_DIRECTORY : ${BOM_DIRECTORY}"

VPN_REQUIRED=$(grep "vpn/required" "${BOM_DIRECTORY}/bom.yaml" | sed -E "s~[^:]+: [\"'](.*)[\"']~\1~g")
echo "VPN_REQUIRED: ${VPN_REQUIRED}"

if [[ "${VPN_REQUIRED}"=="true" ]]; then
   RUNNING_PROCESSES=$(ps -ef)
   VPN_RUNNING=$(echo "${RUNNING_PROCESSES}" | grep "openvpn --config" | head -n 1 | awk NF=1)


    if [[ -n "${VPN_RUNNING}" ]]; then
      echo "stoping vpn service"
         sudo kill -9 "${VPN_RUNNING}"
    else
    echo "vpn service not running"
      fi

      echo "updating local DNS file"
      if [[ "${UID}" -eq 0 ]]; then
        echo "when UID is 0"
        exec 1<&-
        exec 2<&-   
        sudo chmod 777 /etc/resolv.conf
        sudo chmod 777 /etc/resolv.conf_bkp
        sudo cp /etc/resolv.conf /etc/resolv.conf_vpn
        sudo cat /etc/resolv.conf_bkp > /etc/resolv.conf
        sudo cat /etc/resolv.conf          
        sudo chmod 644 /etc/resolv.conf      
      else
        echo "when UID is NOT 0"
        exec 1<&-
        exec 2<&-
        sudo chmod 777 /etc/resolv.conf
        sudo chmod 777 /etc/resolv.conf_bkp
        sudo cp /etc/resolv.conf /etc/resolv.conf_vpn
        sudo cat /etc/resolv.conf_bkp > /etc/resolv.conf
        sudo cat /etc/resolv.conf          
        sudo chmod 644 /etc/resolv.conf  
      
      fi
else
  echo "VPN not required"
fi