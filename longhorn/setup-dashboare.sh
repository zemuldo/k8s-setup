sudo apt-get install apache2-utils

htpasswd -c auth longhorn-dashboard

kubectl create secret generic basic-auth --from-file=auth -n longhorn-system

kubectl get secret basic-auth -o yaml -n longhorn-system

