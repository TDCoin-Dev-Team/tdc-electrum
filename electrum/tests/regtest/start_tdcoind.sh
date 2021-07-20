#!/usr/bin/env bash
export HOME=~
set -eux pipefail
mkdir -p ~/.tdcoin
cat > ~/.tdcoin/tdcoin.conf <<EOF
regtest=1
txindex=1
printtoconsole=1
rpcuser=doggman
rpcpassword=donkey
rpcallowip=127.0.0.1
zmqpubrawblock=tcp://127.0.0.1:28332
zmqpubrawtx=tcp://127.0.0.1:28333
fallbackfee=0.0002
[regtest]
rpcbind=0.0.0.0
rpcport=18554
EOF
rm -rf ~/.tdcoin/regtest
screen -S tdcoind -X quit || true
screen -S tdcoind -m -d tdcoind -regtest
sleep 6
tdcoin-cli createwallet test_wallet
addr=$(tdcoin-cli getnewaddress)
tdcoin-cli generatetoaddress 150 $addr > /dev/null
