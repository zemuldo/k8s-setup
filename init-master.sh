sudo kubeadm init --pod-network-cidr=192.168.122.0/24

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl create -f calico/v3.10/manifest.yml

kubectl create -f metal-lb/v0.8.3/manifest.yml

kubectl create -f metal-lb/configmap.yml
