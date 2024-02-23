# Steps to deploy the playbook

PREREQUISITES:
    ```
    Install Golang 
    ```
1. Clone the github repository.

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

2. In the inventory file make the required changes to the following fields:
```
[hosting]
test ansible_host=139.59.87.171 ansible_user=root
subnode_1 ansible_host=143.110.189.166 ansible_user=root
subnode_2 ansible_host=143.110.242.138 ansible_user=root

[all:vars]

test=139.59.87.171
subnode_1=143.110.189.166
subnode_2=143.110.242.138

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
3. Run the playbook using the command :
```
ansible-playbook main.yml  -i inventory.ini
```
