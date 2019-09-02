#!/bin/bash

cat func.js

kubectl create ns demo2

kubeless function deploy demo2 \
  -f func.js \
  --handler func.hello \
  -n demo2 \
  -r nodejs10

# Enable ingress controller

minikube addons enable ingress

# Create Password Secret

htpasswd -cb auth andres pass123

kubectl create secret -n demo2 generic basic-auth --from-file=auth

# Create cert

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=demo2.com"

kubectl create secret -n demo2 tls tls-secret --key tls.key --cert tls.crt

# Add hostname to /etc/hosts

echo "$(minikube ip) demo2.com" | sudo tee -a /etc/hosts     

# Create HTTP Trigger

kubeless trigger http create demo2 \
  -n demo2 \
  --gateway nginx \
  --hostname demo2.com \
  --function-name demo2 \
  --basic-auth-secret basic-auth \
  --tls-secret tls-secret

# Check

kubectl get all -n demo2

kubectl get ingress -n demo2
