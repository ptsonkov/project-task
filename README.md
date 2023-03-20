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

x. Add Minikube autocompletion
```
# echo '#source <(minikube completion bash)' >> ~/.bashrc
# source ~/.bashrc
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

## Deploy local registry
```
# docker run -d -p 5000:5000 --restart=always --name registry registry:2
```
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
# ./scripts/imagebilder.sh [versionTag]
# ./scripts/imagetester.sh [versionTag]
```

















