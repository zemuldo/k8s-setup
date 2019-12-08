sudo yum install -y yum-utils device-mapper-persistent-data lvm2

sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

dnf list docker-ce --showduplicates | sort -r

sudo dnf install -y docker-ce-3:18.09.1-3.el7

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF

sudo yum update

# Turn off the swap: Required for Kubernetes to work
sudo swapoff -a
 
# Install Kubernetes and Docker
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes docker-ce docker-ce-cli containerd.io
 
# Start Docker
sudo systemctl enable --now docker
 
# Start Kubernetes
sudo systemctl enable --now kubelet