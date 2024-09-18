# Steps to deploy the playbook


1. Clone the github repository.

2. In the inventory file make all the required changes to the following fields
```
ansible_ssh_private_key_file="Specify path to the private_key  ex:~/.ssh/id_rsa"
ssh_file_path="Specify the path to the pub key ex: /home/user/.ssh/id_rsa.pub"
digital_ocean_api_token="Specify the digital ocean token"
ssh_key_name="Specify the name assigned to your ssh key on digital ocean"
```
Additionally, you can modify the fields shown below:"
```
denom=atom
minimum_gas_price=0atom
user=root
validator_key=test1
fullnode_key=test2
fullnode_count=2
validators_count=3
region=blr1
validator_name=val
fullnode_name=ful
```
3. In the faucet-config.j2 file present in the templates, change the denom to the one specified in the inventory.
```
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
```
ansible-playbook main.yml  -i inventory.ini
```

5. To view the explorer, enter the explorer-load balancer IP. For the faucet, enter explorer-load balancer IP:83.
## NOTE: In order to run the playbook more than once, make sure to remove the fields in the inventory generated under: 
### [validators] ,[fullnodes], [loadbalancer]
