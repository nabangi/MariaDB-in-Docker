# MariaDB-in-Docker

mariadb container master-slave replication with health Monitoring

### Automatically deploy environment by;

Running the `deploy_config.sh` after clonning the Repo to you Server.

## Environment prep and manually deploy

`sudo apt update`

### Installing the Docker engine incase its not installed yet

`sudo apt-get remove docker docker-engine docker.io`

`sudo apt install docker.io`

`sudo systemctl start docker`

`sudo systemctl enable docker`

### logout then login again to enable user rights incase they don't apply immediately

`sudo groupadd docker`

`sudo gpasswd -a "${USER}" docker`

`usermod -aG docker "${USER}"`

### Create the database persistent volume to be mounted

`mkdir -p /opt/mariadb/master-data`

#### Grant Permissions 

`sudo chown -R 1001:1001 /opt/mariadb/master-data/`

`docker run -d or docker-compose up -d` is running containers in dettached mode but when you remove the "-d" it could help with debugging the running configs in the container!

#### To login to a container

`docker exec -it $container_id bash`

## mariadb

`$ mysql -u my_user -p`
> my_password

#### after login check databases
`show databases;`
`use my_databse;`

#### then create table form there
`exit;`

#### check or configure replication
login with root  `$ mysql -u root -p `
> master_root_password

then
`show master status;`

### To import:

`docker exec -i adprcc3ms_mariadb-master_1 mysql -uroot -pmaster_root_password my_database < mariadb-master-dump.sql`

### To export:

`docker exec -i adprcc3ms_mariadb-master_1 mysqldump -uroot -pmaster_root_password my_database > mariadb-master-dump.sql`

#### Stop and backup the currently running container, Uncomment the following lines

`docker stop $container_id`

`rsync -a /opt/mariadb/master-data /opt/mariadb/master-data.bkp.$(date +%Y%m%d-%H.%M.%S)`

#### incase you want to scale up number of slaves or scale down

`docker-compose up --detach --scale mariadb-master=1 --scale mariadb-slave=3`

## To clean up

`docker stop $container_id`

`docker rm $container_id`

### You can also remove all images and stopped contaners using

`docker prune -a`

## Run the following to see if the cronjob you've defined actually runs.

`sudo grep CRON /var/log/syslog`


# VOILAA...!!!
