#!/bin/bash
echo
echo "Environment prep for Installing and configuring mariadb-Master - maradb-Anchorag32020%
Slave container..."
echo

sudo apt update

echo
echo "Installing the Docker engine incase its not installed yet..."
echo

sudo apt-get remove docker docker-engine docker.io -y

sudo apt install docker.io -y

sudo systemctl start docker

sudo systemctl enable docker

echo
echo "logout then login again to enable user rights incsed they don't apply immediately..."
echo

sudo groupadd docker

sudo gpasswd -a "${USER}" docker

usermod -aG docker "${USER}"

echo
echo "Create the database persistent volume to be mounted..."
echo

mkdir -p /opt/mariadb/master-data
echo
echo "Permissions Granted...!!" 
echo
sudo chown -R 1001:1001 /opt/mariadb/master-data/

echo
echo "Buckle Up now as we deploy the Master and Slave containers with replication configurations!..."
echo

docker-compose up -d 

echo
echo "Confirming both containers are up and running"
echo

docker ps 

echo
echo
echo "monitoring script for replication health"
echo

chmod +x monitoring_script.sh

echo
echo "cron job"
echo

sudo echo "* * * * * $HOME/adprcc3ms/monitroing_script.sh" >> /etc/cron.d/replication_status

echo
echo "INCASE OF ANY ERRORS PLEASE REVIEW THE README FILE ATTACHED :)"
echo
echo "VOILA...!!!"
echo
