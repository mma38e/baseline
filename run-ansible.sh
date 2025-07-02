#!/bin/bash
# This script runs ansible-playbook inside the 'ansible-runner' Docker container,
# mounting the current working directory into the container.
#
# Usage: ./run-ansible.sh <playbook.yml> [ansible-playbook arguments]

set -euo pipefail

# Run ansible-playbook inside the container
# We use sudo because the current user may not have permissions to access the docker socket.
# --rm: Automatically remove the container when it exits
# -it: Run in interactive mode and allocate a tty
# --network=host: Use the host's network stack to avoid DNS issues.
# -v "$PWD":/app: Mount the current directory on the host to /app in the container
# -w /app: Set the working directory inside the container to /app
# -u root: Run as root to be able to install packages.
# quay.io/ansible/ansible-runner:latest: The name of the Docker image to use.
# The command installs openssh-clients and then executes the playbook.
sudo docker run --rm -it \
  --network=host \
  -v "$PWD":/app \
  -w /app \
  -u root \
  quay.io/ansible/ansible-runner:latest \
  sh -c "yum install -y openssh-clients && yum clean all && ansible-playbook $@"
