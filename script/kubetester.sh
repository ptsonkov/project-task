#!/bin/bash

# Map ports
echo -e "==================================================="
echo -e "=== Map host port to API service"
kubectl port-forward service/api 3000:3000 -n myns  &
sleep 5
echo -e ""

echo -e "==================================================="
echo -e "=== Test API"
curl http://localhost:3000/hello
echo -e ""
echo -e "=== Stop port-forward"
kill $(ps aux | grep "kubectl port-forward" | grep 3000 | awk '{print $2}')