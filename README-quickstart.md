# quickstart eth-netstat 
How to run your 1 server and many clients.

### server eth-netstats
On your 1 server, `node` and `npm` have the be installed, then:

```
git clone https://github.com/cubedro/eth-netstats
cd eth-netstats
npm install

sudo npm install -g grunt-cli
grunt
```

choose port and shared secret:
```
export PORT=3000; export WS_SECRET=electron; npm start
```

### client eth-net-intelligence-api
On each client `parity` (or `geth` or `eth`), and `node`, and `npm` must be installed. Then clone repo, npm install, install pm2, and create a user writable /log/ folder:

```
git clone https://github.com/BSDStudios/eth-net-intelligence-api
cd eth-net-intelligence-api/

npm install
sudo npm i -g pm2

mkdir /var/log/eth-netstats; U=$USER; sudo chown $U:$U /var/log/eth-netstats
```

Edit WS_SERVER and WS_SECRET and INSTANCE_NAME and WS_SERVER, then start client via pm2:

```
cp processes.json p.json
nano p.json 
pm2 start p.json 
```

Kill all pm2:
```
pm2 kill
```

Log files are in:

```
ls /var/log/eth-netstats
```


