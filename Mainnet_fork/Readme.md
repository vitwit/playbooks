# Mainnet Fork setup

## Overview
This Ansible playbook automates the mainnet fork setup. Additionally, it sets up an explorer and a faucet. This playbook is primarily intended for testing purposes.

## Components
1. Validator Node
2. Full node
3. Explorer
4. Faucet

## Pre-requisites
1. Ansible
2. Server with public IP address and SSH access

## How it works

1. Installations
All necessary software installations are performed on the respective server, ensuring each node has the required dependencies and configurations.

2. Validator Setup
The blockchain network is set up consisting of a validator node and a fullnode

3. Cosmos Genesis Tinkerer
The Cosmos Genesis Tinkerer scripts simulate a test environment and create a network genesis file.

4. Node Config changes
Node configuration changes are done based on the user requirements.

5. Cosmovisor Setup
A cosmovisor setup is done to automate network upgrades for both the validator and the fullnode.

6. Explorer and Faucet Setup
After the nodes are operational, an explorer and a faucet are set up for the blockchain network. The faucet allows users to request test funds for the network, while the explorer (built using Node.js, Yarn, and Nginx) connects to the blockchain to provide real-time data about the network.

7. Proposal Setup
An upgrade proposal is submitted to the blockchain network to perform an automated upgrade

# Steps to deploy the playbook

1. Clone the github repository.

2. In the inventory file make the changes as per your requirement

3. In the faucet-config.j2 file present in the templates make changes as per your requirements.

4. Run the playbook using the command :

```bash
ansible-playbook main.yml  -i inventory.ini
```

5. To view the explorer, enter the server IP. For the faucet, enter server IP:83.