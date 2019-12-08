
# Turn off the swap: Required for Kubernetes to work
sudo swapoff -a

sudo yum install -y yum-utils device-mapper-persistent-data lvm2

sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

dnf list docker-ce --showduplicates | sort -r

sudo dnf install -y docker-ce-3:18.09.1-3.el7
 
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes docker-ce docker-ce-cli containerd.io
 
sudo systemctl enable --now docker
 
sudo systemctl enable --now kubelet