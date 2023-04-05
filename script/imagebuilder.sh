#!/bin/bash

app_version=$1
if [[ $app_version == "" ]]; then
    echo -e "Missing image tag parameter"
    exit
fi

temporary_image="tmpbuild"

mkdir bin

# Optionally can delete existing application binary before new build (need more logic to be added)

# Create temporary docker image
echo -e "==================================================="
echo -e "=== Create temporary docker image"
docker build --tag ${temporary_image} .
if [[ $? == 0 ]]; then
    echo -e "=== Create OK"
    echo -e ""
else 
    echo -e "=== Create FAIL"
    exit
fi

# Minify image and make it distroless
echo -e "==================================================="
echo -e "=== Create distroless docker image"
docker-slim build ${temporary_image} --quiet .
if [[ $? == 0 ]]; then
    echo -e "=== Create distroless OK"
    echo -e ""
else 
    echo -e "=== Create distroless FAIL"
    exit
fi

# Tag distroless image
echo -e "==================================================="
echo -e "=== Tag docker image"
for tag in ${app_version} latest
do
    docker tag ${temporary_image}.slim:latest localhost:5000/web-api:${tag}
done
if [[ $? == 0 ]]; then
    echo -e "=== Tag OK"
    echo -e ""
else 
    echo -e "=== Tag FAIL"
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

# Clean temporary cntent
echo -e "==================================================="
echo -e "=== Clean temporary builds"
docker image rm ${temporary_image}:latest ${temporary_image}.slim:latest
if [[ $? == 0 ]]; then
    echo -e "=== Clean OK"
    echo -e ""
else 
    echo -e "=== Clean FAIL"
    exit
fi

# Get image tags
echo -e "==================================================="
echo -e "=== List image tags"
curl -X GET http://localhost:5000/v2/web-api/tags/list

