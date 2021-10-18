#!/bin/sh

helm upgrade --namespace gwcelery gitlab-runner -f values.yaml gitlab/gitlab-runner
