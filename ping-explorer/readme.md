# Steps to deploy the playbook

PREREQUISITES:
    ```
    Install Golang 
    ```



1. Clone the github repository.
2. Open the node.yml present in the ```nodes``` directory of the playbook and make required changes to the following fields.
```
network: cosmos
folder: '.simapp'
daemon: simd
chain_id: demo-222
node_version: v0.50.3
repo: https://github.com/cosmos/cosmos-sdk.git
node_name: cosmos-test
key_name: test

```
3. Go to the inventory.ini file and make appropriate changes to the following columns:
```
ansible_host
ansible_user
```

4. Run the playbook using the following command:
```
 ansible-playbook main.yml -e "target=test" -i inventory.ini 
```