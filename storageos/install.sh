kubectl create -f https://github.com/storageos/cluster-operator/releases/download/1.5.1/storageos-operator.yaml

kubectl create -f storageos-operator-secret.yaml

kubectl create -f storageos-oparator-cluster.yaml

kubectl create -f storageclass.yaml