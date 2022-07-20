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

<center><img src="https://github.com/javierbragazzi/infrastructure-as-code/blob/6a67e009c96e337ab90b4799994b682c85543b38/images/Architecture.png" width="200%" height="200%"/></center>

## Application
Is a sample Kubernetes application hosting an HTML5 Pac-Man game with Node.js as the web server and backend for reading and writing data to a MongoDB database.

## Deployment

1. Install the Azure CLI on the local machine:

-  https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

2. Sign in to our Azure account:

```console
user@machine:~$ a-z login
```
3. Install Terraform:

  - https://learn.hashicorp.com/tutorials/terraform/install-cli

4. Create the infrastructure in Azure with Terraform by running the following [script](https://github.com/javierbragazzi/infrastructure-as-code/blob/6a67e009c96e337ab90b4799994b682c85543b38/terrafrom/create-infra.sh):

```console
user@machine:~$ sh create-infra.sh
```

5. Update the [hosts](https://github.com/javierbragazzi/infrastructure-as-code/blob/6a67e009c96e337ab90b4799994b682c85543b38/ansible/hosts) file that is inside the Ansible folder with the public and private IP's

6. Update the [mongodb-pv.yml](https://github.com/javierbragazzi/infrastructure-as-code/blob/6a67e009c96e337ab90b4799994b682c85543b38/ansible/roles/app/files/mongodb-pv.yaml) file with the private IP of the nfs node

7. Configure the infrastructure and deploy the application with Ansible by running the following [script](https://github.com/javierbragazzi/infrastructure-as-code/blob/6a67e009c96e337ab90b4799994b682c85543b38/ansible/deploy.sh):

```console
user@machine:~$ sh deploy.sh
```

8. Once the application pods are running, we open the browser and try to access it through the url 

  `http://<EXTERNAL_IP>:<PORT>/`

## Destroy

Run the following [script](https://github.com/javierbragazzi/infrastructure-as-code/blob/6a67e009c96e337ab90b4799994b682c85543b38/terrafrom/destroy-infra.sh) to destroy Azure infraestructure:

```console
user@machine:~$ sh destroy-infra.sh
```
