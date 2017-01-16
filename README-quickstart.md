# quickstart eth-netstat 

### server
...

### clientcmds_eth-intelligence-api

```
git clone https://github.com/BSDStudios/eth-net-intelligence-api
cd eth-net-intelligence-api/

npm install
sudo npm i -g pm2

mkdir /var/log/eth-netstats; U=$USER; sudo chown $U:$U /var/log/eth-netstats
```

edit WS_SERVER and WS_SECRET, then start via pm2

```
cp processes.json p.json
nano p.json 
pm2 start p.json 
```

kill all pm2:
```
pm2 kill
```

log files:

```
ls /var/log/eth-netstats
```
