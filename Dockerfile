# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory in the container
WORKDIR /app

# Install Ansible
RUN pip install ansible-core

# Copy requirements.yml and install collections
COPY requirements.yml /app/
RUN ansible-galaxy collection install -r requirements.yml

# Copy the current directory contents into the container at /app
COPY . /app

# Command to run when the container starts
# This example will just make ansible-playbook available
CMD ["ansible-playbook", "--version"]
