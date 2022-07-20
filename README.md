# UNIR 2022 - DevOps - Caso Práctico 2

## Purpose

Create infrastructure in **Azure** under the Infrastructure as Code (IaC) model using **Terraform**, automating the installations and configurations of the environment using **Ansible** as a configuration management tool and install a **Kubernetes** cluster for container orchestration to deploy a persistent application on Kubernetes with NFS-type storage.

## Architecture

- 1 virtual network
- 1 subnet
- 3 virtual machines
  - master node
  - worker node
  - nfs node
- 3 network cards
- 3 public IPs
- 3 groups of network security
- 4 discs

## Application
Is a sample Kubernetes application hosting an HTML5 Pac-Man game with Node.js as the web server and backend for reading and writing data to a MongoDB database.

## Deployment

1. Install the Azure CLI on the local machine:
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

2. Sign in to our Azure account:
  `a-z login`
3. Install Terraform:
https://learn.hashicorp.com/tutorials/terraform/install-cli

4. Create the infrastructure in Azure with Terraform by running the following script:
`sh create-infra.sh`

5. Update the hosts file that is inside the Ansible folder with the public and private IP's

6. Update the mongodb-pv.yml file with the private IP of the nfs node:

7. Configure the infrastructure and deploy the application with Ansible by running the following script:
`sh deploy.sh`

8. Once the application pods are running, we open the browser and try to access it through the url `http://<EXTERNAL_IP>:<PORT>/`

## Destroy

Run the following script to destroy Azure infraestructure.
`sh destroy-infra.sh`