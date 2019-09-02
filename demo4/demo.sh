#!/bin/bash

cat func.js

minikube addons enable metrics-server
minikube addons enable heapster

kubectl create ns demo4

kubectl top pod -A

# Deploy function and autoscale

kubeless function deploy demo4 \
  -f func.js \
  --handler func.hello \
  -n demo4 \
  -r nodejs10 \
  --cpu 100m \
  --memory 50Mi 

kubeless autoscale create demo4 \
  -n demo4 \
  --metric cpu \
  --min 1 \
  --max 3 \
  --value 20

# Trigger the function

kubeless function call -n demo4 demo4

# Watch for the scale up

watch kubectl top pod -A

kubectl get pods -n demo4 -w   
