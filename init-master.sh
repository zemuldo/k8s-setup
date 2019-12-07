sudo kubeadm init --pod-network-cidr=192.168.122.0/24

kubectl create -f etcd/manifest.yml

kubectl create -f calico/v3.10/manifest.yml

kubectl create -f metal-lb/v0.8.3/manifest.yml