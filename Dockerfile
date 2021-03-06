FROM golang:latest

MAINTAINER Michael Dance <michael.dance@gmail.com>

# Grab and install the latest version of btcd and it's dependencies.
RUN go get github.com/roasbeef/btcd/...

# wallet, p2p, and rpc
EXPOSE 8332 8333 8334

# testnet wallet, p2p, and rpc
EXPOSE 18332 18333 18334

RUN mkdir /root/.btcd && mkdir /root/.btcctl

# Generate an automatic RPC conf.
ADD initrpc.go /root/
WORKDIR /root
RUN go build -o gen-config && ./gen-config

ENTRYPOINT ["btcd"]
