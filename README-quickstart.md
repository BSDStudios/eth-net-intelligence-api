# quickstart eth-netstat 
How to run your own 1 server and many clients.

### server eth-netstats
On your 1 server, `node` and `npm` must be installed, then:

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

Open webpage http://localhost:3000

### client eth-net-intelligence-api
On each client `parity` (or `geth` or `eth`), and `node`, and `npm` must be installed. Then clone repo, npm install, install pm2:

```
git clone https://github.com/BSDStudios/eth-net-intelligence-api
cd eth-net-intelligence-api/

npm install
sudo npm i -g pm2

cp app.json a.json
```

or

    cp app-and-eth.json a.json


Edit WS_SERVER and WS_SECRET and INSTANCE_NAME, then start client via pm2

    nano a.json 
    pm2 start a.json 

Reload webpage http://localhost:3000  


If INSTANCE_NAME does not show up, check log files in `log/` folder.

Kill all pm2:
```
pm2 kill
```


