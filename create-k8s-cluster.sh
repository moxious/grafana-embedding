#!/bin/bash

. .env

gcloud container --project $PROJECT clusters create \
    $CLUSTER --region $REGION --release-channel "regular" \
    --network "projects/$PROJECT/global/networks/default" \
    --num-nodes 1 \
    --subnetwork "projects/$PROJECT/regions/$REGION/subnetworks/default" \
    --cluster-ipv4-cidr "/17" 

gcloud container clusters get-credentials $CLUSTER --region $REGION

for line in `cat .env` ; do 
    envvarname=${line%%=*}
    name=`echo ${line%%=*} | tr '[:upper:]' '[:lower:]' | tr '_' '-'`
    value=${line#*=}
    echo "creating secret name: $name"
    kubectl create secret generic $name --from-literal="$envvarname=$value"
done