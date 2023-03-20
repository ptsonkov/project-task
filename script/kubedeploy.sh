#!/bin/bash

# Deploy Kubernetes manifests
echo -e "==================================================="
echo -e "=== Create Namespace"
kubectl apply -f kubernetes/namespace.yml
echo ""

echo -e "==================================================="
echo -e "=== Create Deployment"
kubectl apply -f kubernetes/deployment.yml
echo ""

echo -e "==================================================="
echo -e "=== Create Service"
kubectl apply -f kubernetes/service.yml
echo ""