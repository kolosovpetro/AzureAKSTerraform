kubectl create namespace elk
helm repo add elastic https://helm.elastic.co
helm repo update

helm install elasticsearch elastic/elasticsearch -n elk

#I1105 12:03:53.994929   21492 warnings.go:110] "Warning: spec.SessionAffinity is ignored for headless services"
#NAME: elasticsearch
#LAST DEPLOYED: Wed Nov  5 12:03:51 2025
#NAMESPACE: elk
#STATUS: deployed
#REVISION: 1
#NOTES:
#1. Watch all cluster members come up.
#$ kubectl get pods --namespace=elk -l app=elasticsearch-master -w
#2. Retrieve elastic user's password.
#  $ kubectl get secrets --namespace=elk elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
#3. Test cluster health using Helm test.
#$ helm --namespace=elk test elasticsearch

#$esPassword = kubectl get secret elasticsearch-master-credentials -n elk -o jsonpath='{.data.password}' | ForEach-Object { [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_)) }
#Write-Host "Elasticsearch password: $esPassword"
