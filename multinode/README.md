# Multi-Node Network Setup

## Overview
This ansible playbook automates the setup of a multinode network, consisting of both fullnodes and validator nodes. Additionally, it also  sets up an explorer and a faucet for the blockchain network. It also configures load balancers to expose RPC and API endpoints of fullnodes. It also configures a load balancer for explorer and faucet of the network. This playbook is primarily intended for testing purpose.

## Components
1. Full nodes
2. Validator nodes
3. Explorer
4. Faucet
5. Grafana monitoring

## Pre-requisites
1. Ansible
2. DigitalOcean account and DigitalOcean API token

## How It Works
## NOTE: This Ansible playbook is designed specifically for use with the DigitalOcean provider

1. Droplet Creation

Ansible automatically creates the droplets used to run both full nodes and validator nodes, based on the validators_count and fullnode_count provided in the Ansible inventory file.

2. Installations

All necessary software installations are performed on their respective servers, ensuring each node has the required dependencies and configurations.

3. Validator Setup

The multi-node blockchain network is set up, which includes both full nodes and validator nodes. The number of nodes is determined by the inventory configuration. You can modify the voting period and expedited voting period by updating the respective values in the inventory file. Initially, the blockchain setup is done on one droplet, after which the binary is distributed to the appropriate servers.

4. Load Balancer Setup

Once the nodes are up and running, a load balancer is created for the full nodes to expose their API and RPC endpoints. The load balancer IP addresses can be found in the networking section of your DigitalOcean dashboard.

5. Explorer and Faucet Setup

After the nodes are operational, an explorer and a faucet are set up for the multi-node network. The faucet allows users to request test funds for the network, while the explorer (built using Node.js, Yarn, and Nginx) connects to the blockchain to provide real-time data about the network. A single load balancer is set up to provide access to both the explorer and the faucet. The load balancer IP for these services can also be found in the networking section of your DigitalOcean dashboard.

6. Grafana Monitoring

The monitoring setup includes:
  * Prometheus for collecting metrics from nodes
  * Loki for aggregating logs
  * Node Exporter for system metrics
  * Grafana dashboards for:
    - Tendermint metrics (blockchain performance, consensus, etc.)
    - System metrics (CPU, memory, disk usage)
  - For setup instructions, see the [Steps to setup monitoring](#steps-to-setup-monitoring) section.

# Steps to deploy the playbook


1. Clone the github repository.

2. In the inventory file, make all the required changes to the following fields
```ini
ansible_ssh_private_key_file="Specify path to the private_key  ex:~/.ssh/id_rsa"
ssh_file_path="Specify the path to the pub key ex: /home/user/.ssh/id_rsa.pub"
digital_ocean_api_token="Specify the digital ocean token"
ssh_key_name="Specify the name assigned to your ssh key on digital ocean"
```
Additionally, you can modify the fields shown below:"
```ini
denom=atom
minimum_gas_price=0atom
user=ubuntu
validator_key=test1
fullnode_key=test2
fullnode_count=2
validators_count=3
region=blr1
validator_name=val
fullnode_name=ful
```
3. In the faucet-config.j2 file present in the templates, change the denom to the one specified in the inventory.
```json
{
                amount: [
                    {
                        denom: "atom",
                        amount: "10000000"
                    },
                ],
                fee: {
                    amount: [
                        {
                            amount: "1000",
                            denom: "atom"
                        }

```


4. Run the playbook using the command :
```bash
ansible-playbook main.yml  -i inventory.ini
```

5. To view the explorer, enter the explorer-load balancer IP. For the faucet, enter explorer-load balancer IP:83.
Initially, refresh the faucet page (Ctrl + Shift + R) until the Faucet Address and balance fields are visible.
## NOTE: To rerun the playbook, remove the fields in the inventory generated under: 
* [validators]
* [fullnodes]
* [loadbalancer]
* [monitoring]


## Steps to Setup Monitoring

### Prerequisites
- Ensure port 3000 is accessible on the monitoring server
- Note down the Prometheus server URL (default: `http://localhost:9090`)
- Note down the Loki server URL (default: `http://localhost:3100`)

### Grafana Setup
1. Access Grafana by navigating to `http://<monitoring-server-ip>:3000`
2. Log in with the default credentials:
   - Username: admin
   - Password: admin
   - You will be prompted to change the password on first login

### Configure Data Sources
1. Navigate to Configuration > Data Sources
2. Add Prometheus:
   - Click "Add data source" and select "Prometheus"
   - Set URL to your Prometheus server
   - Click "Save & Test" to verify the connection
3. Add Loki:
   - Click "Add data source" and select "Loki"
   - Set URL to your Loki server
   - Click "Save & Test" to verify the connection

### Import Dashboards
1. Navigate to Dashboards > Import
2. Import each dashboard from the `Dashboard` directory:
   - Copy the contents of the dashboard JSON file
   - Click "Import" and select the appropriate data source
   - Repeat for all dashboard files
   
### Verification
1. Verify that dashboards are showing data

### Troubleshooting
- If metrics are missing, verify Prometheus targets are up
- If logs are missing, check Promtail configuration
- For connection issues, verify network connectivity and firewall rules



