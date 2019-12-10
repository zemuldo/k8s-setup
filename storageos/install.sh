helm repo add storageos https://charts.storageos.com

helm repo update

helm install storageos/storageos --namespace storageos --generate-name --set cluster.join="z-server-2\,z-server-3\,z-server-4"

ClusterIP=$(kubectl get svc/storageos --namespace storageos -o custom-columns=IP:spec.clusterIP --no-headers=true)\nApiAddress=$(echo -n "tcp://$ClusterIP:5705" | base64)\nkubectl patch secret/storageos-api --namespace storageos --patch "{\"data\": {\"apiAddress\": \"$ApiAddress\"}}"

kubectl create -f storageos/storageclass.yml

kubectl patch storageclass fast -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'