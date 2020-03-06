kubectl create -f https://github.com/storageos/cluster-operator/releases/download/1.5.3/storageos-operator.yaml

kubectl create -f storageos/storageos-operator-secret.yaml

kubectl create -f storageos/storageos-oparator-cluster.yaml

kubectl create -f storageos/storageclass.yaml

kubectl patch storageclass fast -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
