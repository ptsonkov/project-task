#!/bin/bash

app_version=$1
if [[ $app_version == "" ]]; then
    echo -e "Missing image tag parameter"
    exit
fi

docker run -d --rm --name api-test -p 8080:8080 localhost:5000/web-api:${app_version}

echo -e "==================================================="
echo -e "=== Test application"
curl http://localhost:8080/hello
echo -e ""
echo -e "=== Stop and remove test container"
docker stop api-test