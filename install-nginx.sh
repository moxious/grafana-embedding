#!/bin/bash

helm install portal oci://registry-1.docker.io/bitnamicharts/nginx --wait \
   --set service.type=ClusterIP,cloneStaticSiteFromGit.enabled=true,cloneStaticSiteFromGit.repository=https://github.com/moxious/beginner-html-site-styled.git,cloneStaticSiteFromGit.branch=gh-pages
export SERVICE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].port}" services portal-nginx)
export SERVICE_IP=$(kubectl get svc --namespace default portal-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo "http://${SERVICE_IP}:${SERVICE_PORT}"

kubectl apply -f nginx-ingress-static-ip.yaml