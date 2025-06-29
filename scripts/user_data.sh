#!/bin/bash


exec > /home/ubuntu/script.log 2>&1

set -x

sudo apt update && sudo apt upgrade -y


sudo apt install openjdk-21-jdk maven git -y

cd /home/ubuntu

git clone https://github.com/techeazy-consulting/techeazy-devops.git

cd techeazy-devops/src/main/resources

sudo sed -i 's/server.port=80/server.port=8080/' application.properties

cd /home/ubuntu/techeazy-devops
mvn clean package

cd target

nohup java -jar techeazy-devops-0.0.1-SNAPSHOT.jar  > /home/ubuntu/app.log 2>&1 &

nohup shutdown -h +60 &
