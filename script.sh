#!/bin/bash

# This Script wil deploy the Application image and  assign a SSL certificate to the domain.
# Author: Vikash Kumar

#!/bin/bash

echo "Enter the GitHub repo link:"
read REPO_URL

echo "Enter the repo name:"
read REPO_NAME

echo "Enter the docker image name:"
read DOCKER_IMAGE

echo "Enter the port for Applicatin"
read PORT

DOMAIN_NAME=$1
WWW_DOMAIN=$2

#Cloning the repo
git clone $REPO_URL

# Install Docker and start the service
sudo apt-get update -y
sudo apt-get install docker.io -y
sudo service docker start

#Install Nginx and start the server
sudo apt install nginx -y
sudo service nginx start

# Build and run the container
cd $REPO_NAME
sudo docker build -t $DOCKER_IMAGE .
sudo docker run -d -p $PORT:$PORT $DOCKER_IMAGE

#update the system and install certbot if not installed
 sudo apt update -y
 sudo apt install certbot -y 
 # assign SSL certificate to the domain
 sudo apt install python3-certbot-nginx -y

#If you want certificate by letsencrypt own server
 sudo cerbot --nginx -d $DOMAIN_NAME -d $WWW_DOMAIN
