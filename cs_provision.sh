#!/bin/bash

COLOR_INFO="\033[32m" # green
COLOR_WARNING="\033[33m" # yellow
COLOR_ERROR="\033[31m" # red
COLOR_END="\033[0m"

function cs_autoprovision() {
  local RAW
  local CODE
  local MESSAGE

  RAW=$(curl -s --location \
      --header 'Accept: application/json' \
      --header 'Authorization: Bearer '"${CS_KEY}"'' \
      --header 'Content-Type: application/json' \
      --request GET \
      "http://${API_URI}/api/gateways/${GATEWAY_EUI}" 2>/dev/null)

  CODE=$(echo "${RAW}" | jq --raw-output '.code' 2>/dev/null)
  MESSAGE=$(echo "${RAW}" | jq --raw-output '.message' 2>/dev/null)

  if [[ "$CODE" == "null" ]]; then
      echo -e "${COLOR_INFO}Gateway exists, getting certificates.${COLOR_END}"
      RAW=$(curl -s --location \
          --header 'Accept: application/json' \
          --header 'Authorization: Bearer '"${CS_KEY}"'' \
          --header 'Content-Type: application/json' \
          --request POST \
          "http://${API_URI}/api/gateways/${GATEWAY_EUI}/generate-certificate" 2>/dev/null)

      CODE=$(echo "${RAW}" | jq --raw-output '.code' 2>/dev/null)
      MESSAGE=$(echo "${RAW}" | jq --raw-output '.message' 2>/dev/null)

      if [[ "$CODE" == "null" ]]; then
          TLS_CERT=$(echo "$RAW" | jq -r '.tlsCert' 2>/dev/null)
          TLS_KEY=$(echo "$RAW" | jq -r '.tlsKey' 2>/dev/null)
          CA_CERT=$(echo "$RAW" | jq -r '.caCert' 2>/dev/null)

          if [[ "$TLS_CERT" != "null" && "$TLS_KEY" != "null" && "$CA_CERT" != "null" ]]; then
              echo "${TLS_CERT}" > tc.crt
              echo "${TLS_KEY}" > tc.key
              echo "${CA_CERT}" > tc.trust
              echo -e "${COLOR_INFO}Certificates successfully generated.${COLOR_END}"
          else
              echo -e "${COLOR_ERROR}ERROR | Provisioning: Invalid certificate response.${COLOR_END}\n"
              return
          fi
      else
          echo -e "${COLOR_ERROR}ERROR | Provisioning: $MESSAGE ($CODE).${COLOR_END}\n"
          return
      fi
  else
      echo -e "${COLOR_ERROR}ERROR | Provisioning: $MESSAGE ($CODE).${COLOR_END}\n"
      return
  fi
    echo
}

cs_autoprovision
