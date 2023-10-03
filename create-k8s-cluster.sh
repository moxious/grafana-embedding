#!/bin/bash

. .env

gcloud container --project $PROJECT clusters create \
    $CLUSTER --region $REGION --release-channel "regular" \
    --network "projects/$PROJECT/global/networks/default" \
    --subnetwork "projects/$PROJECT/regions/us-east1/subnetworks/default" \
    --cluster-ipv4-cidr "/17" 

gcloud container clusters get-credentials $CLUSTER --region $REGION
