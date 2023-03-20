# My Project Task

## Create local Kubernetes instance with Minikube

Hosted on Fedora 36

x. Install and run Docker
https://docs.docker.com/engine/install/fedora/

x. Install and start Minikube
```
# curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
# chmod +x minikube-linux-amd64 && mv minikube-linux-amd64 /usr/local/bin
```

x. Install kubectl
```
# curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
# chmod +x kubectl && mv kubectl /usr/local/bin
```

x. Start Minikube
```
# minikube start --driver=docker
# kubectl cluster-info
# kubectl get nodes
# kubectl get pods -n kube-system
# minikube dashboard
```

## Deploy registry
- deploy registry to Minikube and map host port 5000 to Minikube port 5000
```
# kubectl apply -f kubernetes/kube-registry.yaml
# kubectl port-forward --namespace kube-system \
    $(kubectl get po -n kube-system | grep kube-registry-v0 | awk '{print $1;}') 5000:5000 &
```
### Optional for testing
- push image to registry
```
# docker pull alpine
# docker tag alpine localhost:5000/my-alpine
# docker push localhost:5000/my-alpine
```
- test registry
```
# docker image remove alpine
# docker image remove localhost:5000/my-alpine
# docker pull localhost:5000/my-alpine
```
- list registry images
```
# curl -X GET http://localhost:5000/v2/_catalog
# curl -X GET http://localhost:5000/v2/my-alpine/tags/list
```

## Build and test application image

```
# cd script
# ./scripts/imagebilder.sh [versionTag]
# ./scripts/imagetester.sh [versionTag]
```

## Deploy API to Kubernetes and test
- deploy and wait all posd to become available
```
# ./scripts/kubedeploy.sh
# kubectl get all -n myns
```
- test web API
```
# ./scripts/kubetester.sh
```














## Further improvements
- may prepare Ansible scripts to automate entire deployment
- may improve deployment using git webhooks














