#!/bin/bash
sudo apt update -y
sudo touch /etc/apt/keyrings/adoptium.asc
sudo wget -O /etc/apt/keyrings/adoptium.asc https://packages.adoptium.net/artifactory/api/gpg/key/public
echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update -y
sudo apt install temurin-17-jdk -y
/usr/bin/java --version
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
                  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
                  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
                              /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

#Install docker
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
newgrp docker
sudo chmod 777 /var/run/docker.sock
docker version
sudo usermod -aG docker jenkins

# Install Terraform
sudo apt install wget -y
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Install kubectl
sudo apt update
sudo apt install curl -y
curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

# Install aws eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# Install AWS CLI 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt-get install unzip -y
unzip awscliv2.zip
sudo ./aws/install

# Deploy a SonarQube Container
docker volume create sonarqube-volume
docker volume inspect volume sonarqube-volume
docker run -d --name sonarqube -v sonarqube-volume:/opt/sonarqube/data -p 9000:9000 sonarqube:lts-community

# # Install Snyk and NPM (We'll Be Using A Jenkins Plugin, For The Setup)
# curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
# . ~/.nvm/nvm.sh
# nvm install 15.0.0
# node -e "console.log('Running Node.js ' + process.version)"
# npm --version
# # Installing Snyk (We'll Be Using A Jenkins Plugin, For The Setup)
# npm install -g snyk

# Installing Git
sudo apt install git -y

## Provision ZAP User Access For DAST Automation Testing
sudo su
useradd zapuser -m
echo "zapuser:zapuser" | chpasswd  ## Ubuntu

## Enable Password Authentication and Authorization
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i '/^#PermitEmptyPasswords no/a ChallengeResponseAuthentication yes' /etc/ssh/sshd_config
systemctl restart ssh
systemctl restart sshd
echo "zapuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

