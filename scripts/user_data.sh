#!/bin/bash


exec > /home/ubuntu/script.log 2>&1

set -x

sudo apt update && sudo apt upgrade -y


sudo apt install openjdk-21-jdk maven git -y

cd /home/ubuntu

git clone https://github.com/techeazy-consulting/techeazy-devops.git

cd techeazy-devops

sudo mvn clean package

cd target

sudo java -jar techeazy-devops-0.0.1-SNAPSHOT.jar 

nohup shutdown -h +60 &
