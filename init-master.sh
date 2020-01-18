RED='\033[0;31m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

CLUSTER_NETWORK_CIDR=$1
LB_ADDRESS_RANGE=$2

if [ -n "$CLUSTER_NETWORK_CIDR" ]
 then
  echo "${BLUE}Initializing master using kubeadm with network $CLUSTER_NETWORK_CIDR${NC}"
else
  echo "${RED}Cluster network not set${NC}, Exiting..."
  exit 1
fi

if [ -n "$LB_ADDRESS_RANGE" ]
 then
  echo "${BLUE}LoadBalancer Address range is set to $LB_ADDRESS_RANGE${NC}"
else
  echo "${ORANGE}LoadBalancer Address range not set, Setup will skip LB Installation ${NC}"
  exit 1
fi

if ! [ -x "$(command -v kubeadm)" ]; then
  echo "${RED} kubeadm is not installed this machine is not ready ${NC}, Exiting..."
  exit 1
fi

sudo kubeadm init --pod-network-cidr=$CLUSTER_NETWORK_CIDR

echo "${BLUE}Setting up K8s config for access to API${NC}"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "${BLUE}Installing the Cluster storage etcd > ${GREEN}https://github.com/etcd-io/etcd${NC}"
kubectl create -f etcd/manifest.yml

echo "${BLUE}Installing the Pod network Calico > ${GREEN}https://www.projectcalico.org/${NC}"
kubectl create -f calico/v3.10/manifest.yml

if [ -n "$LB_ADDRESS_RANGE" ]
 then
  echo "${BLUE}Installing the Network LoadBalancer MetalLB > ${GREEN}https://metallb.universe.tf/${NC}"

  kubectl create -f metal-lb/v0.8.3/manifest.yml

  echo "${BLUE}Setting up MetalLB address Range ${NC}"
  
  kubectl create -f - <<END
  apiVersion: v1
  kind: ConfigMap
  metadata:
    namespace: metallb-system
    name: config
  data:
    config: |
      address-pools:
      - name: default
        protocol: layer2
        addresses:
        - $LB_ADDRESS_RANGE
END
else
  echo "${ORANGE}Skipped LB Installation ${NC}"
  exit 1
fi


