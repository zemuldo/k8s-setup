sudo apt-get install apache2-utils

htpasswd -c auth zemuldo

kubectl create secret generic monitoring-basic-auth --from-file=auth -n monitoring

kubectl get secret generic monitoring-basic-auth -o yaml -n monitoring

