#!/bin/sh

kubectl apply -f sa.yaml

helm repo add gitlab https://charts.gitlab.io

helm install --namespace gwcelery gitlab-runner -f values.yaml gitlab/gitlab-runner
