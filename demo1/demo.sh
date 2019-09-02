#!/bin/bash

kubectl create ns kubeless

kubectl apply -f https://github.com/kubeless/kubeless/releases/download/v1.0.4/kubeless-v1.0.4.yaml 

cat func.py

kubectl create ns demo1

kubeless function deploy demo1 \
  -f func.py \
  --handler func.hello \
  -n demo1 \
  -r python3.7

kubectl get all -n demo1

kubeless function call -n demo1 demo1
