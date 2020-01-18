# k8s-setup

Code for my post on [Bare-Metal Kubernetes Setup](https://zemuldo.com/blog/kubernetes-on-a-bare-metal-setup.-5e0473b928ad7a001974455b), a setup of Bare Metal Kubernetes using Kubeadm and Metallb on Ubuntu 18.04 master and 3 Ubuntu 18.04 minions.

## Setup Master

```shell
./setup-master.sh Network/Mask LB-Address-Range
```

This part does setup setup of:

- Initialize master.
- Setup pod network.
- Setup LoadBalancer.
- Setup LoadBalancer config.

Example

```shell
./setup-master.sh 192.168.122.0/24 192.168.122.150-192.168.122.250
```

## Dashboard

```shell
./setup-dashboard.sh
```

This will setup the Kubernetes UI Dashboard and a service account `k8s-admin`.

To start the dashboard in the master.

```shell
kubectl proxy --accept-hosts='^*$'
```

The dashboard is accessible on the `Master IP` port `8001`. You can bind your local environment to the master via SSH.

```shell
ssh -fNTL localhost:8000:127.0.0.1:8001 user@master-ip-address
```

Now you can access the dashboard on: http://localhost:8000/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/overview?namespace=default

## Storage

### Longhorn - Option 1

To setup [Longhorn](https://github.com/longhorn/longhorn)

```shell
./setup-longhorn.sh
```
Longhorn setups up with a LB type service for accessing the dashboard. You should see it using

```shell
╭─user@z-server-1 ~/k8s-setup  ‹master*›
╰─➤  k get services -n longhorn-system
NAME                      TYPE           CLUSTER-IP     EXTERNAL-IP       PORT(S)        AGE
compatible-csi-attacher   ClusterIP      10.96.66.245   <none>            12345/TCP      3d15h
csi-attacher              ClusterIP      10.96.23.111   <none>            12345/TCP      3d15h
csi-provisioner           ClusterIP      10.96.6.171    <none>            12345/TCP      3d15h
longhorn-backend          ClusterIP      10.96.24.184   <none>            9500/TCP       3d15h
longhorn-frontend         LoadBalancer   10.96.191.83   192.168.122.150   80:31082/TCP   3d15h
╭─user@z-server-1 ~/k8s-setup  ‹master*›
╰─➤
```

### StorageOS - Option 2

To setup [StorageOS](https://storageos.com/).

Install StorageOS operator

```shell
./setup-storage-os.sh
```

To access the Storage OS dashboard:

```shell
kubectl --namespace storageos port-forward svc/storageos 5705
```

To access the dashboard, bind your local machine to the master ip port 5705

```shell
ssh -fNTL localhost:5700:127.0.0.1:5705 user@MASTER-IP-ADDRESS
```

The access http://localhost:5700/

## Nginx Ingress Controller

To setup Nginx Ingress Controller.

```shell
./setup-nginx-ingress-ctl.sh
```

## Cert-Manager

To setup cert manager.

```shell
./setup-cert-manager.sh
```

## Kube-Prometheus

If you need cluster monitoring out of the box try [Kube-Promatheus](https://github.com/coreos/kube-prometheus#quickstart)
