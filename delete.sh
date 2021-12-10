#!/bin/sh

NAMESPACE="wavefier-stable"
helm delete --namespace $NAMESPACE kube-deploy
