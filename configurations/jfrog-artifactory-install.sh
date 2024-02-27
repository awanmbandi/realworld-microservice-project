## Install JFrog Artifactory Manager
sudo su
yum update –y
amazon-linux-extras install epel -y
amazon-linux-extras install java-openjdk11 -y
java -version

### Amazon Linux 2, CentOs 7 or RHEL Image
sudo yum install wget -y
wget https://releases.jfrog.io/artifactory/artifactory-rpms/artifactory-rpms.repo -O jfrog-artifactory-rpms.repo;
sudo mv jfrog-artifactory-rpms.repo /etc/yum.repos.d/;
sudo yum update -y
sudo yum install jfrog-artifactory-oss -y --skip-broken
sudo systemctl enable artifactory.service
sudo systemctl start artifactory.service
sudo systemctl status artifactory.service

### Access JFrog Repository Manager
1. Copy the External/Public IP and past on the browser with column 8081 or 8082

2. Default Username and Password
- Username: `admin`
- Password: `password`

3. Change the your password to for example
- Make sure you're compliant based on the JFrog RM Default Password Policy
- New Password: `Admin@12345`




### Install on Debian
# To determine your distribution, run lsb_release -c or cat /etc/os-release
# Example:echo "deb https://releases.jfrog.io/artifactory/artifactory-pro-debs xenial main" | sudo tee -a /etc/apt/sources.list;
wget -qO - https://releases.jfrog.io/artifactory/api/gpg/key/public | sudo apt-key add -;
echo "deb https://releases.jfrog.io/artifactory/artifactory-debs {distribution} main" | sudo tee -a /etc/apt/sources.list;
sudo apt-get update && sudo apt-get install jfrog-artifactory-oss


## Downloading Artifacts from JFrog Using REAT API:GET
## THIS ONE <<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>
curl -u admin:Admin@12345 -XGET "http://34.68.141.102:8082/artifactory/gradle-javawebapp-local-repo/gradle-war/1.1/gradle-war-1.1.war" --output gradle-war-1.1.war -T ~/Downloads/jfrog

## Downloading Artifacts from JFrog Using REAT API:GET With Encrypted Password
curl -u admin:"sacavcdavasdvsdfvfsvs" -XGET "http://34.68.141.102:8082/artifactory/gradle-javawebapp-local-repo/gradle-war/1.1/gradle-war-1.1.war" --output gradle-war-1.1.war -T ~/Downloads/jfrog
