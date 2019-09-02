#!/bin/bash

cat func.go

kubectl create ns demo5

# Create secret with credentials

kubectl create secret -n demo5 docker-registry kubeless-registry-credentials \
  --docker-server=https://index.docker.io/v1/ \
  --docker-username=user \
  --docker-password=password \
  --docker-email=user@example.com

kubectl edit configmap -n kubeless kubeless-configmap

# Add secret name: kubeless-registry-credentials
# Enable function builder

# Force reload

kubectl delete pod -n kubeless -l kubeless=controller

# Deploy function and watch deployments

kubeless function deploy demo5 \
  -f func.go \
  --handler func.Hello \
  -n demo5 \
  -r go1.10

# Watch deployments

kubectl get pod -n demo5 -w

# Redeploy

kubeless function delete demo5 -n demo5
kubeless function deploy demo5 \
  -f func.go \
  --handler func.Hello \
  -n demo5 \
  -r go1.10
