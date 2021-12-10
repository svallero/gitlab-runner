#!/bin/sh

NAMESPACE="wavefier-stable"

# Create serviceaccount for namespace
cat << EOF > .service-account-gitlab-runner-${NAMESPACE}.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: runner
  namespace: ${NAMESPACE} 
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: runner
  namespace: ${NAMESPACE}
rules:
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: runner
  namespace: ${NAMESPACE}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: runner
subjects:
- namespace: ${NAMESPACE}
  kind: ServiceAccount
  name: runner
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: default
  namespace: ${NAMESPACE}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: runner
subjects:
- namespace: ${NAMESPACE}
  kind: ServiceAccount
  name: default
EOF

kubectl apply -f .service-account-gitlab-runner-${NAMESPACE}.yaml

#helm repo add gitlab https://charts.gitlab.io
helm upgrade --install --namespace ${NAMESPACE} -f values-${NAMESPACE}.yaml kube-deploy gitlab/gitlab-runner

