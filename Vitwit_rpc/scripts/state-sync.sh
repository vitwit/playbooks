#!/bin/bash

RPCS=(
"https://rpc.cosmoshub-main.ccvalidators.com:443"
# "https://cosmoshub.tendermintrpc.lava.build:443"
"https://rpc-cosmoshub.whispernode.com:443"
"https://cosmos-rpc.polkachu.com"
"https://rpc-cosmoshub-ia.cosmosia.notional.ventures/"
"https://rpc-cosmoshub.architectnodes.com"
"https://rpc.cosmos.dragonstake.io"
"https://cosmoshub.rpc.stakin-nodes.com"
"https://rpc.cosmos.bh.rocks"
"https://cosmos-rpc.easy2stake.com/"
"https://rpc-cosmos-hub-01.stakeflow.io"
)

WORKING_RPCS=()

for RPC in "${RPCS[@]}"; do
  echo "Checking $RPC..."

  HEIGHT=$(curl -s --max-time 5 "$RPC/block" | jq -r '.result.block.header.height' 2>/dev/null)

  if [[ "$HEIGHT" =~ ^[0-9]+$ ]]; then
    WORKING_RPCS+=("$RPC")
    echo "Working RPC: $RPC"
  fi

  if [ ${#WORKING_RPCS[@]} -eq 2 ]; then
    break
  fi
done

if [ ${#WORKING_RPCS[@]} -lt 2 ]; then
  echo "Not enough working RPCs found!"
  exit 1
fi

RPC1=${WORKING_RPCS[0]}
RPC2=${WORKING_RPCS[1]}

echo "Using RPCs:"
echo "$RPC1"
echo "$RPC2"

LATEST_HEIGHT=$(curl -s $RPC1/block | jq -r .result.block.header.height)

BLOCK_HEIGHT=$((LATEST_HEIGHT - 2000))

TRUST_HASH=$(curl -s "$RPC1/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$RPC1,$RPC2\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"|" $HOME/.gaia/config/config.toml