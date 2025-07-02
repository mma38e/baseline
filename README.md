# Ansible Baseline Playbooks

This repository contains Ansible playbooks for setting up baseline configurations and installing common packages on systems.

## Playbooks

### `install_common_packages.yml`

This playbook installs a set of common packages and development tools on Rocky Linux-based systems. It was converted from the original `install_common_packages.sh` script.

## Inventory

The `inventory.ini` file defines the hosts that Ansible will manage. A sample `inventory.ini` is provided with a `[local]` group for `localhost` and a `[webservers]` group as an example.

To run the `install_common_packages.yml` playbook on your local machine, use the following command:

```bash
ansible-playbook -i inventory.ini install_common_packages.yml --limit local
```

## Docker Environment

A `Dockerfile` is provided to create a Docker image with Ansible and specified Galaxy collections installed. This allows you to run your playbooks in a consistent environment.

### Building the Docker Image

To build the Docker image, navigate to the root of this repository and run:

```bash
docker build -t ansible-runner .
```

### Running Playbooks with Docker

To run a playbook using the Docker image, you can mount the current directory into the container:

```bash
docker run -it --rm -v $(pwd):/app ansible-runner ansible-playbook -i inventory.ini install_common_packages.yml --limit local
```

## Ansible Galaxy Collections

The `requirements.yml` file specifies the Ansible Galaxy collections to be installed. You can add more collections to this file as needed.

To install new collections, update `requirements.yml` and rebuild your Docker image.

```yaml
# Example requirements.yml
---
collections:
  - community.general
  # - ansible.posix
```
