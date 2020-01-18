kubectl create -f dashboard/manifest.yml

kubectl --namespace kube-system create serviceaccount k8s-admin

kubectl create clusterrolebinding k8s-admin --serviceaccount=kube-system:k8s-admin --clusterrole=cluster-admin

kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep k8s-admin | awk '{print $1}')