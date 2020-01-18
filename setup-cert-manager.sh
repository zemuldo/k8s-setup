kubectl create namespace cert-manager

kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.12.0/cert-manager.yaml

kubectl create -f nginx-ingres+cert-manager/staging-issure.yaml

kubectl create -f nginx-ingres+cert-manager/prod-issuer.yaml