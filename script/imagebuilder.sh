#!/bin/bash

app_version=$1
if [[ $app_version == "" ]]; then
    echo -e "Missing image tag parameter"
    exit
fi

mkdir bin

# Optionally can delete existing application binary before new build (need more logic to be added)

# Create docker image
echo -e "==================================================="
echo -e "=== Create docker image"
docker build --tag localhost:5000/web-api:${app_version} --tag localhost:5000/web-api:latest .
if [[ $? == 0 ]]; then
    echo -e "=== Create OK"
    echo -e ""
else 
    echo -e "=== Create FAIL"
    exit
fi

# Push image to registry
echo -e "==================================================="
echo -e "=== Push to registry"
docker push localhost:5000/web-api:${app_version} && docker push localhost:5000/web-api:latest
if [[ $? == 0 ]]; then
    echo -e "=== Push OK"
    echo -e ""
else 
    echo -e "=== Push FAIL"
    exit
fi

# Get image tags
echo -e "==================================================="
echo -e "=== List image tags"
curl -X GET http://localhost:5000/v2/web-api/tags/list

