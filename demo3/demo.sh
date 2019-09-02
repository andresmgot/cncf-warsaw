#!/bin/bash

cat func.js

kubectl create ns demo3

# Deploy Kafka

kubectl apply -f https://github.com/kubeless/kafka-trigger/releases/download/v1.0.2/kafka-zookeeper-v1.0.2.yaml 

# Create Kafka topic and publish a message

kubeless topic create demo3

kubeless topic publish --topic demo3-topic --data "Hello World!"

# Deploy function and trigger

kubeless function deploy demo3 \
  -f func.js \
  --handler func.hello \
  -n demo3 \
  -r nodejs10

kubeless trigger kafka create demo3 \
  -n demo3 \
  --function-selector function=demo3 \
  --trigger-topic demo3-topic

# Check message

kubectl logs -n demo3 -l function=demo3
