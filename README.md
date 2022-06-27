# ft_services
Kubernetes multi-service cluster

### Features
Each service run in a dedicated container (build using Alpine Linux).

- Kubernetes web dashboard
- Load Balancer (MetalLB): only entry point of the cluster 
- WordPress, listening on port 5050, which work with a MySQL database and its own nginx server
- phpMyAdmin, listening on port 5000 and linked with the MySQL database
- nginx server listening on ports 80 and 443. Port 80 is systematically redirected (type 301) to 443. 
   Allow access to a /wordpress route that makes a redirect 307 to Wordpress service
   Allow access to /phpmyadmin with a reverse proxy to phpMyAdmin service
- FTPS server listening on port 21
- Grafana platform, listening on port 3000, linked with an InfluxDB database.

Data persist in case of a crash or stop of one of the two database containers.
Containers restart in case of a crash or stop of one of their component parts.

![image](https://user-images.githubusercontent.com/64405672/175894210-ad0f918c-67c4-414f-8a8e-4b65d2a76e37.png)
