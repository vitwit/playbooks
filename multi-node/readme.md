# Steps to deploy the playbook


1. Clone the github repository.


2. In the inventory file make all the required changes
```
[hosting]
validator_1 ansible_host=xx.xx.xx.xx ansible_user=root
validator_2 ansible_host=xx.xx.xx.xx ansible_user=root
validator_3 ansible_host=xx.xx.xx.xx ansible_user=root

[all:vars]

validator_1=xx.xx.xx.xx
validator_2=xx.xx.xx.xx
validator_3=xx.xx.xx.xx

**NOTE: Make sure that the ip matches in both the sections wrt their names.**

```
```

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
