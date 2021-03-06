#!/bin/bash

#generate random key
key=`openssl rand -base64 32`

#get server ip
serverIp=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip" -H "Metadata-Flavor: Google")

#run srever
npm run server $key &

#create N client
for i in `seq 1 8`
do
  gcloud compute instances create --machine-type f1-micro --zone europe-west1-c \
  --metadata serverIp="$serverIp",key="$key" --scopes compute-rw,logging-write\
  --metadata-from-file startup-script=../startup-script.sh \
  --preemptible \
  robstow-worker-$i
done

#wait for job to end
wait "$!"

#delete N client
for i in `seq 1 8`
do
gcloud compute instances delete robstow-worker-$i --zone europe-west1-c
done

gcloud logging read rob-logger
