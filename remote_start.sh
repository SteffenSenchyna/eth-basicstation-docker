#!/bin/bash

# Variables
REMOTE_USER="steffen"               # Remote username
REMOTE_HOST="dev-pgw-0001.tail92bfc1.ts.net"            # Remote host (IP or hostname)
REMOTE_DIR="eth-basicstation-docker/runner" # Remote directory
LOCAL_SCRIPT="runner/start"         # Local script to copy

# Check if the local script exists
if [[ ! -f "${LOCAL_SCRIPT}" ]]; then
  echo "ERROR: Local script '${LOCAL_SCRIPT}' does not exist!"
  exit 1
fi

# Copy the script to the remote host
echo "Copying ${LOCAL_SCRIPT} to ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/"
scp "${LOCAL_SCRIPT}" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/start" || {
  echo "ERROR: Failed to copy script to remote host."
  exit 1
}

# Execute the script on the remote host
echo "Executing the script on the remote host..."
ssh "${REMOTE_USER}@${REMOTE_HOST}" "
  cd ${REMOTE_DIR} &&
  bash start
"

# Exit message
echo "Script execution completed."
