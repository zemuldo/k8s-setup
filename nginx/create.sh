kubectl create service loadbalancer nginx --tcp=80:80
kubectl create deployment nginx --image=nginx