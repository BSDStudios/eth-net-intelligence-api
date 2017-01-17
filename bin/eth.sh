#!/usr/bin/env bash

trap "exit" INT

if [[ -f $(which ec2metadata 2>/dev/null) ]]
then
	# If ec2 instance then get ips from ec2metadata
	LOCALIP=$(ec2metadata --local-ipv4)
	IP=$(ec2metadata --public-ipv4)
else
	# Else get IPs from ifconfig and dig
	LOCALIP=$(ip addr | grep 'inet ' | grep -v '127.0.0.1' | head -n1 | awk '{print $2}' | cut -d':' -f2)
	IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
fi

echo "Local IP: $LOCALIP"
echo "Public IP: $IP"


# is Ethereum already running, with open RPC port?
QUERY='{"jsonrpc":"2.0","method":"web3_clientVersion","id":1}'
CHECKHOST=127.0.0.1
CHECKPORT=8545

if [[ -f $(which curl 2>/dev/null) ]]
then
	JSONRPC=$(curl -s -f -X POST -H "Content-Type: application/json" --data $QUERY http://$CHECKHOST:$CHECKPORT)
	ETHEREUMNODE=$(echo $JSONRPC | jq -r '.result') || ETHEREUMNODE=$JSONRPC
else
	ETHEREUMNODE=
fi

if [ -n "$ETHEREUMNODE" ] 
then
	echo Running node:  $ETHEREUMNODE
else
	echo No running node, or curl not installed.

if [[ -f $(which parity 2>/dev/null) ]]
then
	echo "Starting parity"
	CMD="parity --bootnodes $BOOTNODE --nat \"extip:$IP\" $PARITYARGS"
	echo $CMD
	$CMD

elif [[ -f $(which geth 2>/dev/null) ]]
then
	echo "Starting geth"
	echo geth --rpc --bootnodes $BOOTNODE --nat "extip:$IP" 
	geth --rpc --bootnodes $BOOTNODE --nat "extip:$IP"

elif [[ -f $(which eth 2>/dev/null) ]]
then
	echo "Starting eth"
	echo eth --bootstrap --peers 50 --remote 52.16.188.185:30303 --mining off --json-rpc -v 3 --public-ip $IP --listen-ip $LOCALIP --master $1
	eth --bootstrap --peers 50 --remote 52.16.188.185:30303 --mining off --json-rpc -v 3 --public-ip $IP --listen-ip $LOCALIP --master $1

else
	echo "Ethereum was not found!"
	exit 1;
fi

fi # [ -n "$ETHEREUMNODE" ] 
