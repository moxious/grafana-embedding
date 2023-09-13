#!/bin/bash

. .env

gcloud container --project $PROJECT clusters delete $CLUSTER --region $REGION 
