
export TF_STATE_BUCKET=solo-io-terraform-931713665590
export TF_STATE_KEY=argocd-demo
export TF_STATE_REGION=us-east-2

kubectl create ns argocd --context mgmt-1
kubectl apply -f ./hack/argocd-install.yaml -n argocd --context mgmt-1

# argo cli doesn't observe flags correctly :(
kubectx mgmt-1
kubens argocd


argocd admin initial-password 
argocd login --username admin --password **** localhost:8080
argocd account update-password --username admin


kubectl apply --context mgmt-1 -f -<<EOT
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: cluster
  namespace: argocd
spec:
  destination:
    namespace: argocd
    server: https://kubernetes.default.svc
  project: default
  source:
    directory:
      jsonnet: {}
      recurse: true
    path: argocd/argocd-demo/mgmt-1
    repoURL: https://github.com/bensolo-io/argocd-multi-cluster-demo.git
  syncPolicy:
    automated:
      prune: true
      selfHeal: true 
EOT