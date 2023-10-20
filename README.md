# Grafana Embedding

This repo sets up a simple test case based on Google Kubernetes Engine of running:

- Grafana 10
- Nginx hosting a simple website ([source in this repo](https://github.com/moxious/beginner-html-site-styled.git))

Where the objective is to embed a Grafana dashboard inside of a notional company portal.

Most of the scripts and resources here are associated with provisioning the GKE 
resources and configuring the instances. 

Out of scope of the automation in this repo:

- Setting 2 static IP addresses in Google Cloud
- Associating those addresses with the names `portal.o11y.party` and `grafana.o11y.party`, so that those services can resolve under those names.

## Configuration

You will need to create a local .env file with secrets that looks like this:

PROJECT=dev-advocacy-380120
REGION=us-east1
CLUSTER=embedding
PROM_USERNAME=
PROM_ENDPOINT=
PROM_PASSWORD=
LOGS_USERNAME=
LOGS_ENDPOINT=
LOGS_PASSWORD=
GRAFANA_CLOUD_TOKEN=