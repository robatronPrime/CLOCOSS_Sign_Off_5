#!/bin/bash

key=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/key" -H "Metadata-Flavor: Google")

serverIp=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/serverIp" -H "Metadata-Flavor: Google")

name=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/name" -H "Metadata-Flavor: Google")

zone=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/zone" -H "Metadata-Flavor: Google")

sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y install git

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

sudo apt-get install nodejs npm

sudo git clone https://github.com/portsoc/clocoss-master-worker
cd clocoss-master-worker
sudo npm install

npm run client $key $serverIp:8080
gcloud logging write vm-logger "Contributing"

gcloud compute instances stop $name --zone $zone
