# Steps to deploy the playbook

PREREQUISITES:
    ```
    Install Golang 
    ```
1. Clone the github repository.


2. In the inventory file make the required changes to the following fields:
```
[hosting]
test ansible_host=x.x.x.x ansible_user=root
subnode_1 ansible_host=x.x.x.x ansible_user=root
subnode_2 ansible_host=x.x.x.x ansible_user=root

[all:vars]

test=x.x.x.x
subnode_1=x.x.x.x
subnode_2=x.x.x.x

**NOTE: Make sure that the ip matches in both the sections wrt their names.**

```
```
network=cosmos
folder='.simapp'
daemon=simd
chain_id=demo
node_version=v0.50.3
repo=https://github.com/cosmos/cosmos-sdk.git
node_name1=cosmos1
node_name2=cosmos2
node_name3=cosmos3
key_name1=test1
key_name2=test2
key_name3=test3
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
