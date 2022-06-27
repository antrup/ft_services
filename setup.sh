#!/bin/sh

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

if ! id -nG $USER | grep -qw docker; then
	echo "$USER need to be added to docker group"
	sudo usermod -a -G docker $USER
	echo "Please log out, log in and try again"
	exit
fi

minikube start --vm-driver=docker
minikube docker-env
eval $(minikube -p minikube docker-env)
IP=$(minikube ip)
IP_RANGE_START=$(echo $IP | awk -F"." '{print $1"."$2"."$3".250"}')
IP_RANGE_STOP=$(echo $IP | awk -F"." '{print $1"."$2"."$3".250"}')
cp srcs/metallb-conf_template.yaml srcs/metallb-conf.yaml
sed -i s/'RANGE_START'/"$IP_RANGE_START"/ srcs/metallb-conf.yaml
sed -i s/'RANGE_STOP'/"$IP_RANGE_STOP"/ srcs/metallb-conf.yaml
cp srcs/ftps/srcs/vsftpd_template.conf srcs/ftps/srcs/vsftpd.conf
sed -i s/'IP_PASV'/"$IP_RANGE_START"/ srcs/ftps/srcs/vsftpd.conf
kubectl create namespace metallb-system
minikube addons enable metallb
kubectl apply -f srcs/metallb-conf.yaml
sleep 25
docker build srcs/mysql -t mysql-image
docker build srcs/phpMyadmin -t pma-image
docker build srcs/nginx -t nginx-image
docker build srcs/ftps -t ftps-image
docker build srcs/influxdb -t influxdb-image
docker build srcs/wordpress -t wordpress-image
docker build srcs/telegraf -t telegraf-image
docker build srcs/grafana -t grafana-image
cp srcs/phpMyadmin/pma_template.yaml srcs/phpMyadmin/pma.yaml
sed -i s/'localhost'/"$IP_RANGE_START"/ srcs/phpMyadmin/pma.yaml
kubectl apply -f srcs/password.yaml
kubectl apply -f srcs/config.yaml
kubectl apply -f srcs/storage.yaml
sleep 10
kubectl apply -f srcs/mysql/mysql.yaml
kubectl apply -f srcs/phpMyadmin/pma.yaml
kubectl apply -f srcs/wordpress/wordpress.yaml
kubectl apply -f srcs/nginx/nginx.yaml
kubectl apply -f srcs/ftps/ftps.yaml
kubectl apply -f srcs/influxdb/influxdb.yaml
kubectl apply -f srcs/dashboard.yaml
kubectl apply -f srcs/dashboard_user.yaml
nohup kubectl proxy &
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}" > token
echo "WP configuration in progress ..."
sleep 40
kubectl exec $(kubectl get pod -o=name | grep wordpress) -- sh -c "wp --path='www' core install --url=https://$IP_RANGE_START:5050 --title=Example --admin_user=admin --admin_email=info@example.com --admin_password=secret"
kubectl exec $(kubectl get pod -o=name | grep wordpress) -- sh -c 'wp --path='www' user create bob bob@example.com --user_pass=secret'
kubectl exec $(kubectl get pod -o=name | grep wordpress) -- sh -c 'wp --path='www' user create ben ben@example.com --user_pass=secret'
kubectl exec $(kubectl get pod -o=name | grep wordpress) -- sh -c 'wp --path='www' user create nuts nuts@example.com --user_pass=secret'
kubectl exec $(kubectl get pod -o=name | grep wordpress) -- sh -c "wp --path='www' option update siteurl https://$IP_RANGE_START:5050"
kubectl exec $(kubectl get pod -o=name | grep wordpress) -- sh -c "wp --path='www' option update home https://$IP_RANGE_START:5050"
echo "Monitoring configuration in progress ..."
INF_TOKEN=$(kubectl exec $(kubectl get pod -o=name | grep influxdb) -- sh -c 'cat /etc/influxdb2/token')
cp srcs/telegraf/telegraf_template.yaml srcs/telegraf/telegraf.yaml
sed -i s,'INF_TOKEN_VALUE',"$INF_TOKEN", srcs/telegraf/telegraf.yaml
cp srcs/grafana/grafana_template.yaml srcs/grafana/grafana.yaml
sed -i s,'INF_TOKEN_VALUE',"$INF_TOKEN", srcs/grafana/grafana.yaml
kubectl apply -f srcs/telegraf/telegraf.yaml
kubectl apply -f srcs/grafana/grafana.yaml
