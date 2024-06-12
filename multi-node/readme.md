# Steps to deploy the playbook


1. Clone the github repository.


2. In the inventory file make all the required changes to the following fields
```
ansible_ssh_private_key_file="~/.ssh/id_rsa"
ssh_file_path="Specify the path to the pub key"
digital_token="Specify the digital ocean token"
ssh_key_name="Specify the name assigned to your ssh key on digital ocean"



```
You can also make changes to the user and denom field shown below
```
denom=atom
minimum_gas_price=0atom
user=root
```
3. In the faucet-config.j2 file present in the templates change the denom to the one specified in the inventory
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
