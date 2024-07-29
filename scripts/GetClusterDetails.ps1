# Get the Azure resource group name

$rgName = $( terraform output -raw resource_group_name )

# Run az aks list to display the name of the new Kubernetes cluster

$clusterName = $( terraform output -raw kubernetes_cluster_name )
az aks list `
--resource-group $rgName `
--output table

# Get the Kubernetes configuration from the Terraform state and store it in a file that kubectl can read

echo "$(terraform output kube_config)" > ./azurek8s
cat ./azurek8s
kubectl get nodes --kubeconfig ./azurek8s

# Connect to cluster
$subId = az account show --query id --output tsv
az aks get-credentials --resource-group $rgName --name $clusterName --subscription $subId

# check nodes

kubectl get nodes -o wide