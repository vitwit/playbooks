# Overview
This Ansible playbook automates the setup of a private InterPlanetary File System (IPFS) network. It creates multiple IPFS nodes and configures them as a cluster. Additionally, it sets up a load balancer for the IPFS Gateway endpoints, ensuring high availability and improved performance for file access.

## Pre-requisites
1. Ansible (version 2.9 or higher)
2. DigitalOcean account and DigitalOcean API token

## NOTE: This Ansible playbook is designed specifically for use with the DigitalOcean provider

## How It Works
1. Droplet Creation

Ansible automatically creates the droplets used to run the IPFS clusters.

2. Installations

All necessary software installations are performed on their respective servers, ensuring each node has the required dependencies and configurations.

3. IPFS Setup

Ansible creates a private IPFS network comprising 1 main node and 2 sub nodes

4. IPFS Cluster

Ansible creates an IPFS cluster among the main node and the sub nodes.

5. Load Balancer Setup

Once the IPFS nodes are up and running, a load balancer is created to expose the Gateway endpoints. The load balancer IP address can be found in the networking section of your DigitalOcean dashboard.

## Deployment Instructions
1. Clone the github repository.
```
git clone https://github.com/vitwit/playbooks.git
cd ipfs
```
2. In the inventory file, make all the required changes to the following fields
```ini
ansible_ssh_private_key_file="Specify path to the private_key  ex:~/.ssh/id_rsa"
ssh_file_path="Specify the path to the pub key ex: /home/user/.ssh/id_rsa.pub"
digital_ocean_api_token="Specify the digital ocean token"
ssh_key_name="Specify the name assigned to your ssh key on digital ocean"
```
Optionally, you can modify the following fields:
```ini
user=root
region=blr1
```
3. Run the playbook using the command :
```ini
ansible-playbook main.yml  -i inventory.ini
```
4. To access the gateway endpoint on the web, enter the loadbalancer IP followed by /ipfs/CID (where CID is the Content Identifier of the file)

## Rerunning the Playbook

**Note:** To rerun the playbook, remove the fields generated under the `[nodes]` section in the `inventory.ini` file.