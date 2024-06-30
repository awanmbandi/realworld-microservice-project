# Microservice Web Application Project Architecture 
**Online Shopping Application:** This online shopping application was architected and built using cloud-first related principles and methodologies that promotes the adoption of application management strategies such as Microservices. The Online Shopping Application consists of about 11 microservices.

![ProjectArch](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/%5BK8S%20Project%5D%20Multi-Service%20Application%20Project%20Arch.png)
***

#### Jenkins Microservices MultiBranch CI/CD Pipeline Automation Arch | One
![PipelineArch1](https://github.com/awanmbandi/realworld-microservice-project/blob/main/docs/architectures/%5BCI-CD%20Arch%201%5D%20Microservices%20CI-CD-1.png)

***
#### Jenkins Microservices MultiBranch CI/CD Pipeline Automation Arch | Two
![PipelineArch2](https://github.com/awanmbandi/realworld-microservice-project/blob/main/docs/architectures/%5BCI-CD%20Arch%202%5D%20Microservices%20CI-CD-2.png)

![Continuous Integration](https://github.com/GoogleCloudPlatform/microservices-demo/workflows/Continuous%20Integration%20-%20Main/Release/badge.svg)

1) Create a GitHub Repository with the name `multi-microservices-application-project` and push the code in this branch *(main)* to your remote repository (your newly created repository). 
    - Go to GitHub: https://github.com
    - Login to `Your GitHub Account`
    - Create a Repository called `multi-microservices-application-project`
    - Clone the Repository in the `Repository` directory/folder on your `local machine`
    - Download the code in in this repository `"multi-microservices-application-project main branch"`: https://github.com/awanmbandi/realworld-microservice-project.git
    - `Unzip` the `code/zipped file`
    - `Copy` and `Paste` everything `from the zipped file` into the `repository you cloned` in your local
    - Open your `Terminal`
        - Add the code to git, commit and push it to your upstream branch "main or master"
        - Add the changes: `git add -A`
        - Commit changes: `git commit -m "adding project source code"`
        - Push to GitHub: `git push`
    - Confirm that the code is now available on GitHub 
2) Download the code from ALL the other BRANCHES as well
  - Create the following branches in the Repository, you just created above
    * `app-ad-serverice`
    * `app-cart-service`
    * `app-checkout-service`
    * `app-currency-service`
    * `app-database`
    * `app-email-service`
    * `app-frontend-service`
    * `app-loadgenerator-service`
    * `app-payment-service`
    * `app-product-catalog-service`
    * `app-recommendation-service`
    * `app-shipping-service`
  - Download the Source Code of each microservice, from their respective branches from this Repository https://github.com/awanmbandi/realworld-microservice-project.git
  - And Push the Code based on the Microservice to the specific Branch you Created for that Service.

3) Create An IAM Profile/Role For The `Jenkins-CI` Server
- Create an EC2 Service Role in IAM with AdministratorAccess Privilege 
- Navigate to IAM
![IAM!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.20.44%20PM.png)
    - Click on `Roles`
    - Click on `Create Role`
    - Select `Service Role`
    - Use Case: Select `EC2`
    - Click on `Next` 
    - Attach Policy: `AdministratorAccess`
    - Click `Next` 
    - Role Name: `AWS-EC2-Administrator-Role`
    - Click `Create`
4) Jenkins CI  
    - Region: `Ohio - us-east-2`
    - Create a Jenkins VM instance 
    - Name: `Jenkins-CI`
    - AMI: `Ubuntu 22.04`
    - Instance type: `t2.large`
    - Key pair: `Select` or `create a new keypair`
    - Security Group (Edit/Open): `All Traffic` to `0.0.0.0/0`
        - Name & Description: `Multi-Microservices-Jenkins-CI-SG`
        - What we actually need: `8080`, `9000` and `22` to `0.0.0.0/0`
    - Storage: Increase to `50 GB`
    - IAM instance profile: Select the `AWS-EC2-Administrator-Role`
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-microservice-project/blob/main/installtions/installations.sh
    - Launch Instance

#### ⚠️ NOTE:ALERT ⚠️
- **ONLY VISIT THIS SECTION IF YOU STOPPED AND RESTARTED YOUR JENKINS SERVER**
- The above `Jenkins Userdata` includes a `SonarQube` container deployment task
  - As a result, we know containers are `Ephemeral` by natuure, so if you `Stop` your `Jenkins CI Server` at any point in time... You'll have to `Deploy the Container` again when you `Start` it back or bring the instance up again.
  - If you don't do this, you will not be able able to proceed with the project.
  - I have also Included a `Docker Volume` setup task as well for `SonarQube`, where the Container Data will be persisted to avoid Data lost.
```bash
# Volume inspection, confirm the docker volume exist
docker volume inspect volume sonarqube-volume

# Create a new conainter, provide your container name and deploy in the `Jenkins-CI` server
docker run -d --name PROVIDE_NAME_HERE -v sonarqube-volume:/opt/sonarqube/data -p 9000:9000 sonarqube:lts-community
```

5) Slack 
    - Go to the bellow Workspace and create a Private Slack Channel and name it "yourfirstname-jenkins-cicd-pipeline-alerts"
    - Link: https://join.slack.com/t/jjtechtowerba-zuj7343/shared_invite/zt-24mgawshy-EhixQsRyVuCo8UD~AbhQYQ  
      - You can either join through the browser or your local Slack App
      - Create a `Private Channel` using the naming convention `YOUR_INITIAL--multi-microservices-alerts`
        - **NOTE:** *`(The Channel Name Must Be Unique, meaning it must be available for use)`*
      - Visibility: Select `Private`
      - Click on the `Channel Drop Down` and select `Integrations` and Click on `Add an App`
      - Search for `Jenkins` and Click on `View`
      - Click on `Configuration/Install` and Click `Add to Slack` 
      - On Post to Channel: Click the Drop Down and select your channel above `YOUR_INITIAL-multi-microservices-alerts`
      - Click `Add Jenkins CI Integration`
      - Scrol Down and Click `SAVE SETTINGS/CONFIGURATIONS`
      - Leave this page open
      ![SlackConfig!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/slack-multi-microservices-project.png)

### 5A) Verify the Following Services are running in the Jenkins Instance
- SSH into the `Jenkins-CI` server
    - Run the following commands and confirm that the `services` are all `Running`
```bash
# Confirm Java version
sudo java --version

# Confirm that Jenkins is running
sudo systemctl status jenkins

# Confirm that docker is running
sudo systemctl status docker

# Confirm that Terraform is running
terraform version

# Confirm that the Kubectl utility is running 
kubectl version --client

# Confirm that AWS CLI is running
aws --version

# Confirm that the SonarQube container is running
docker ps | grep sonarqube:lts-community

# Lastly confirm that the `sonarqube-volume docker volume` was created
docker volume inspect volume sonarqube-volume
```

### 5C.2) Before Creating The Cluster, Delete Any EKS IAM Role In Your Account
- Navigate to the `IAM Servce`
  - Click on `Roles`
  - Use the `Search Bar` to file roles that starts with `eks`
  - Delete any Role with the name `eks`

### 5B) Deploy Your EKS Cluster Environment
- `UPDATE` Your Terraform Provider Region to `Your Choice REGION`*
    - **⚠️`NOTE:ALERT!`⚠️:** *Do Not Use North Virginia, that's US-EAST-1*
    - **⚠️`NOTE:ALERT!`⚠️:** *Also Confirm that The Selected Region Has A `Default VPC` You're Confident Has Internet Connection*
    - **⚠️`NOTE:ALERT!`⚠️:** *The Default Terraform Provider Region Defined In The Config Is **`Ohio(US-EAST-2)`***
- Confirm you're still logged into the `Jenkins-CI` Server via `SSH`
- Run the following commands to deploy the `EKS Cluster` in the `Jenkins-CI`
- **NOTE:** *You Can As Well Deploy The Cluster Using Terraform From Your Local System*
```bash
# Clone your project reporisoty
git clone https://github.com/awanmbandi/realworld-microservice-project.git

# cd and checkout into the DevSecOps project branch
cd realworld-microservice-project 
cd terraform/AWS/eks-cluster

# Deploy EKS Environment
terraform init
terraform plan
terraform apply --auto-approve
```
- Give it about `10 MINUTES` for the cluster creation to complete
- Then `Duplicate or Open` a New Console `Tab` and `Switch` to the `Ohio(us-east-2) Region`
- Navigate to `EKS` and confirm that your Cluster was created successfully with the name `EKS_Cluster`
- Also confirm there's no issue regarding your Terraform execution
![JenkinsSetup1!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsdsdas.png)
![JenkinsSetup2!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sfgsfs.png)

#### **⚠️`NOTE:ALERT!`⚠️:** FOLLOW THESE STEPS ONLY IF YOUR CLUSTER CREATION FAILED
- If the Error Message says anything about `EKS IAM Roles` then...
- Destroy everything by running: `terraform destroy --auto-approve`
- Wait for everything to get destroy/terminated successfully.

- Then Navigate to `IAM`
  - In the `Search section`
  - Search for the word `EKS` and select ALL the EKS Role that shows up
  - Delete every one of them

- Go back to where you're executing Terraform(that's the Jenkins Instance)
  - Re-run: `terraform apply --auto-approve`
  - Wait for another `10 Minute` 

#### 5C) Once The Cluster Deployment Completes, Go Ahead and Enable The OIDC Connector/Provider
- Run this command from the `Jenkins-CI` instance
```bash
eksctl utils associate-iam-oidc-provider \
    --region us-east-2 \
    --cluster EKS_Cluster \
    --approve
```

#### 5D) Update/Get Cluster Credential: 
- Run this command from the `Jenkins-CI` instance
```bash
aws eks update-kubeconfig --name <clustername> --region <region>
```

#### 5E) Create Your Test and Prod Environment Namespaces
- Run this command from the `Jenkins-CI` instance
```bash
kubectl create ns test-env
kubectl create ns prod-env
kubectl get ns
```

#### 5F) Update the EKS Cluster Security Group (Add A NodePort and Frontend Port)
- Navigate to `EC2`
  - Select any of the `Cluster Worker Nodes`
  - Click on `Security`
  - Click on the `EKS Cluster Security Group ID`
  - Click on `Edit Inbound Rules`
  - Click on `Add Rule`
  - Port Number: `30000-32767`, `80`, `22` Source: `0.0.0.0/0`
  - Click on `SAVE`
![EKS-Sec-Group-Ports](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sec_group.png)

### Jenkins setup
1) #### Access Jenkins
    Copy your Jenkins Public IP Address and paste on the browser = ExternalIP:8080
    - Copy the Path from the Jenkins UI to get the Administrator Password
        - Make sure you're still logged into your Jenkins Instance
        - Run the command: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
        - Copy the password and login to Jenkins
    ![JenkinsSetup1!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/jenkins-signup.png) 
      - **`NOTE:`** Copy the Outputed Password and Paste in the `Administrator password` in Jenkins
    - Plugins: Choose `Install Suggested Plugings` 
    - Provide 
        - Username: **`admin`**
        - Password: **`admin`**
        - `Name` and `Email` can also be admin. You can use `admin` all, as its a poc.
    - Click `Continue`
    - Click on `Start using Jenkins`
    ![JenkinsSetup2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%208.49.43%20AM.png) 

2)  #### Plugin installations:
    - Click on `Manage Jenkins`
    - Click on `Plugins`
    - Click `Available`
    - Search and Install the following Plugings and `"Install"`
        - **SonarQube Scanner**
        - **Snyk**
        - **Multibranch Scan Webhook Trigger**
        - **Eclipse Temurin installer**
        - **Pipeline: Stage View**
        - **Docker**
        - **Docker Commons**
        - **Docker Pipeline**
        - **docker-build-step**
        - **Docker API**
        - **Kubernetes**
        - **Kubernetes CLI**
        - **Kubernetes Credentials**
        - **Kubernetes Client API**
        - **Kubernetes Credentials Provider**
        - **Kubernetes :: Pipeline :: DevOps Steps**
        - **Slack Notification**
        - **ssh-agent**
        - **BlueOcean**
        - **Build Timestamp**
    - Click on `Install`
    - Once all plugins are installed
    - Select/Check the Box **`Restart Jenkins when installation is complete and no jobs are running`**
    ![PluginInstallation!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/afda.png)
    - Refresh your Browser and Log back into Jenkins
    - Once you log back into Jenkins

3)  #### Global tools configuration:
    - Click on Manage Jenkins -->> Global Tool Configuration
    ![JDKSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/sdsdsdsdsd.png)

    - **JDK** 
        - Click on `Add JDK` -->> Make sure **Install automatically** is enabled 
        
        **Note:** By default the **Install Oracle Java SE Development Kit from the website** make sure to close that option by clicking on the image as shown below.
        * Name: `JDK17`
        * Click on `Add installer`
        * Select `Install from adoptium.net` 
        * Version: **`jdk-17.0.8.1+1`**

        ![JDKSetup!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdfbdasb.png)
    
    - **Gradle Installation**
      - Click on `Add Gradle`
      - Name: `Gradle`
      - Enable `Install automatically`
      - Version: `8.8`
      ![GradleInstallation!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/gradle-setup.png)

    - **SonarQube Scanner** 
      - Click on `Add SonarQube Scanner` 
      - Name: `SonarScanner`
      - Enable: `Install automatically` 
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/dcsdsvsvd.png)

    - **Snyk Installations** 
      - Click on ``Add Snyk`
      - Name: `Snyk`
      - Enable: `Install automatically` 
        - Version: `latest`
        - Update policy interval (hours): `24`
        - OS platform architecture: `Auto-detection`
      ![SnykInstallation!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/snyk-install.png)
    
    - **Docker installations** 
      - Click on `Add Docker` 
      - Name: `Docker`
      - Click on `Add installer`
        - Select `Download from docker.com`
        - Docker version: `latest`
      - Enable: `Install automatically` 
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/svfdsv.png)

4)  #### Credentials setup(SonarQube, Slack, DockerHub, Kubernetes and ZAP):
    - Click on `Manage Jenkins`
      - Click on `Credentials`
      - Click on `Jenkins - System`
      - Click on `Global Credentials (Unrestricted)`
      - Click on `Add Credentials`
      1)  ##### SonarQube secret token (SonarQube-Token)
          - ###### Generating SonarQube secret token:
              - Login to your SonarQube Application (http://SonarServer-Sublic-IP:9000)
                - Default username: **`admin`** 
                - Default password: **`admin`**
            - Click on `Login`
                - Old Password: **`admin`**
                - New Password: **`adminadmin`**
                - Confirm Password: **`adminadmin`**

              - Click on `Manually` *(Create the `app-shipping-service` microservice test project)*
                - Project display name: `app-shipping-service`
                - Display key: `app-shipping-service`
                - Main branch name: `app-shipping-service` 
              
              - Click on `Projects` *(Create the `app-recommendation-service` microservice test project)*
                - Project display name: `app-recommendation-service`
                - Display key: `app-recommendation-service`
                - Main branch name: `app-recommendation-service` 
              
              - Click on `Projects` *(Create the `app-product-catalog-service` microservice test project)*
                - Project display name: `app-product-catalog-service`
                - Display key: `app-product-catalog-service`
                - Main branch name: `app-product-catalog-service` 
              
              - Click on `Projects` *(Create the `app-payment-service` microservice test project)*
                - Project display name: `app-payment-service`
                - Display key: `app-payment-service`
                - Main branch name: `app-payment-service` 
              
              - Click on `Projects` *(Create the `app-loadgenerator-service` microservice test project)*
                - Project display name: `app-loadgenerator-service`
                - Display key: `app-loadgenerator-service`
                - Main branch name: `app-loadgenerator-service` 
              
              - Click on `Projects` *(Create the `app-frontend-service` microservice test project)*
                - Project display name: `app-frontend-service`
                - Display key: `app-frontend-service`
                - Main branch name: `app-frontend-service`
              
              - Click on `Projects` *(Create the `app-email-service` microservice test project)*
                - Project display name: `app-email-service`
                - Display key: `app-email-service`
                - Main branch name: `app-email-service` 
              
              - Click on `Projects` *(Create the `app-database` microservice test project)*
                - Project display name: `app-database`
                - Display key: `app-database`
                - Main branch name: `app-database` 
              
              - Click on `Projects` *(Create the `app-currency-service` microservice test project)*
                - Project display name: `app-currency-service`
                - Display key: `app-currency-service`
                - Main branch name: `app-currency-service` 
              
              - Click on `Projects` *(Create the `app-checkout-service` microservice test project)*
                - Project display name: `app-checkout-service`
                - Display key: `app-checkout-service`
                - Main branch name: `app-checkout-service` 
              
              - Click on `Projects` *(Create the `app-cart-service` microservice test project)*
                - Project display name: `app-cart-service`
                - Display key: `app-cart-service`
                - Main branch name: `app-cart-service` 
              
              - Click on `Projects` *(Create the `app-ad-serverice` microservice test project)*
                - Project display name: `app-ad-serverice`
                - Display key: `app-ad-serverice`
                - Main branch name: `app-ad-serverice` 
              - Click on `Set Up`

            - Generate a `Global Analysis Token`    *This is the Token you need for Authorization*
              - Click on the `User Profile` icon at top right of SonarQube
              - Click on `My Account`
              - Click `Security`
              - `Generate Token:`   *Generate this TOKEN and Use in the Next Step to Create The SonarQube Credential* 
                - Name: `microservices-web-app-token`
                - Type: `Global Analysis Token`
                - Expires in: `30 days`
              ![Sonar!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsdsddsd.png) 
              - Click on `GENERATE`
              - NOTE: *`Save The Token Somewhere...`*

          - ###### Store SonarQube Secret Token in Jenkins:
              - Navigate back to Jenkins http://JENKINS_PUBLIC_IP:8080
              - Click on `Manage Jenkins` 
                - Click on `Jenkins System`
                - Click `Global credentials (unrestricted)`
              - Click on ``Add Credentials``
              - Kind: `Secret text`
              - Secret: `Paste the SonarQube TOKEN` value that we have created on the SonarQube server
              - ID: ``SonarQube-Credential``
              - Description: `SonarQube-Credential`
              - Click on `Create`

      2)  ##### Slack secret token (slack-token)
          - ###### Get The Slack Token: 
              - Slack: https://join.slack.com/t/jjtechtowerba-zuj7343/shared_invite/zt-24mgawshy-EhixQsRyVuCo8UD~AbhQYQ
              - Navigate to the Slack "Channel you created": `YOUR_INITIAL-devsecops-cicd-alerts`
              - Click on your `Channel Drop Down`
              - Click on `Integrations` and Click on `Add an App`
              - Click on `Jenkins CI VIEW` and Click on `Configuration`
              - Click on `Add to Slack`, Click on the Drop Down and `Select your Channel`
              - Click on `Add Jenkins CI Integration`
              - **`NOTE:`** *The TOKEN is on Step 3*

          - ###### Create The Slack Credential For Jenkins:
              - Click on ``Add Credentials``
                - Click on `Jenkins System`
                - Click `Global credentials (unrestricted)`
              - Kind: Secret text            
              - Secret: Place the Integration Token Credential ID (Note: Generate for slack setup)
              - ID: ``Slack-Credential``
              - Description: `Slack-Credential`
              - Click on `Create`  

      3)  ##### DockerHub Credential (Username and Password)
          - ###### Login to Your DockerHub Account (You can CREATE one if you Don't have an Account)
              - Access DockerHub at: https://hub.docker.com/
              - Provide Username: `YOUR USERNAME`
              - Provide Username: `YOUR PASSWORD`
              - Click on `Sign In` or `Sign Up`    
                - **NOTE:** *If you have an account `Sign in` If not `Sign up`*

          - ###### DockerHub Credential (Username and Password)
	          - Click on ``Add Credentials``
                - Click on `Jenkins System`
                - Click `Global credentials (unrestricted)`
	          - Kind: Username with password                  
	          - Username: ``YOUR USERNAME``
	          - Password: ``YOUR PASSWORD``
	          - ID: ``DockerHub-Credential``
	          - Description: `DockerHub-Credential`
	          - Click on `Create`   

        - ###### Get Cluster Credential From Kube Config
            - `SSH` back into your `Jenkins-CI` server
            - RUN the command: `aws eks update-kubeconfig --name <clustername> --region <region>`
            - COPY the Cluster KubeConfig: `cat ~/.kube/config`
            - `COPY` the KubeConfig file content
                - You can use your `Notepad` or any other `Text Editor` as well
                - Open your Local `GitBash` or `Terminal`
                - Create a File Locally
                - RUN: `rm ~/Downloads/kubeconfig-secret.txt`
                - RUN: `touch ~/Downloads/kubeconfig-secret.txt`
                - RUN: `vi ~/Downloads/kubeconfig-secret.txt`
                - `PASTE` and `SAVE` the KubeConfig content in the file

         - ###### Create The Kubernetes Credential In Jenkins
            - Navigate back to Jenkins
            - Click on ``Add Credentials``
                - Click on `Jenkins System`
                - Click `Global credentials (unrestricted)`
            - Kind: `Secret File`          
            - File: Click ``Choose File``
                - **NOTE:** *Seletct the KubeConfig file you saved locally*
            - ID: ``Kubernetes-Credential``
            - Description: `Kubernetes-Credential`
            - Click on `Create`   
      
      5) ##### Create the ZAP Dynamic Application Security Testing Server Credential
         - ###### Start by Copy the `EC2 SSH Private Key File Content` of your `Jenkins-CI` Server
            - Open your `GitBash Terminal` or `MacOS Terminal` 
            - Navigate to the Location where your `Jenkins-CI` Server SSH Key is Stored *(Usually in **Downloads**)*
            - Run the Command `cat /Your_Key_PATH/YOUR_SSH_KEY_FILE_NAME.pem`
              - `Note:` Your `.pem` private key will most like be in `Downloads`
            - COPY the KEY content and Navigate back to Jenkins to store it...
        
         - ###### Create The ZAP Server SSH Key Credential in Jenkins
            - Navigate to the `Jenkins Global Credential Dash`
            - Click on `Create Credentials`
            - Scope: Select `Global......`
            - Type: Select `SSH Username with Private Key`
            - ID and Description: `OWASP-Zap-Credential`
            - Username: `ubuntu`
            - Private key: Select
              - Key: Click on `Add`
              - Key: `Paste The Private Key Content You Copied`
            - Click on `Create`
      
      6) ##### Create Your Snyk Test (SCA) Credential
         - ###### Navigate to: https://snyk.com/
            - Click on `Sign Up`
            - Select `GitHub`
                - *Once you're login to your **Snyk** account*
            - Click on `Your Name` below `Help` on the Botton left hand side of your Snyk Account
            - Click on `Account Settings`
            - Auth Token (KEY): Click on `Click To Show`
            - **COPY** the TOKEN and SAVE somewhere
        
        - ###### Create SNYK Credential in Jenkins
            - Click on ``Add Credentials``
            - Kind: `Secret text`
            - Secret: `Paste the SNYK TOKEN` 
            - ID: ``Snyk-API-Token``
            - Description: `Snyk-API-Token`
            - Click on `Create`
        ![KubeCredential!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/credentials-jenkins.png)

3)  #### Configure system:    
    1)  - Click on ``Manage Jenkins`` 
        - Click on ``System`` and navigate to the `SonarQube Servers` section
        - Click on Add `SonarQube`
        - Name: `Sonar-Server`
        - Server URL: http://YOUR_JENKINS_PRIVATE_IP:9000
        - Server authentication token: Select `SonarQube-Credential`
        ![SonarQubeServerSetup!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/vfsvfs.png)

    2)  - Still on `Manage Jenkins` and `Configure System`
        - Scroll down to the `Slack` Section (at the very bottom)
        - Go to section `Slack`
            - `NOTE:` *Make sure you still have the Slack Page that has the `team subdomain` & `integration token` open*
            - Workspace: **Provide the `Team Subdomain` value** (created above)
            - Credentials: select the `Slack-Credential` credentials (created above) 
            - Default channel / member id: `#PROVIDE_YOUR_CHANNEL_NAME_HERE`
            - Click on `Test Connection`
            - Click on `Apply` and `Save`
        ![SlackSetup!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdgsdfg.png)

### Pipeline creation (Make Sure To Make The Following Updates First)
- UPDATE YOUR ``Jenkinsfiles...``
- Update your `Frontend Service` - `OWASP Zap Server IP` and `EKS Worker Node IP` in the `Jenkinsfile` on `Line 80`
  - `NOTE` to update the `Frontend Service`, you must `Switch` to the `Frontend Branch`
- Update the `EKS Worker Node IP` with yours in the `Jenkinsfile` on `Line 80`
- Update your `Slack Channel Name` in the `Jenkinsfiles...` - `All Microservices`
- Update `SonarQube projectName` of your Microservices in the `Jenkinsfiles...` - `All Microservices`
- Update the `SonarQube projectKey` of your Microservices in the `Jenkinsfiles...` - `All Microservices`
- Update the `DockerHub username` of your Microservices in the `Jenkinsfiles...` - `All Microservices`, provide Yours
- Update the `DockerHub username/Image name` in all the `deployment.yaml` files for the different environments `test-env` and `prod-env` folders across `Every Single Microservice Branch`
    
    - Log into Jenkins: http://Jenkins-Public-IP:8080/
    - Click on `New Item`
    - Enter an item name: `Online-Shop-Microservices-CICD-Automation` 
    - Select the category as **`Multibranch Pipeline`**
    - Click `OK`
    - BRANCH SOURCES:
      - Git:
        - Project Repository
          - Repository URL: `Provide Your Project Repo Git URL` (the one you created at the beginning)
    - BEHAVIORS
      - Set it to: `Discover Branches` and
      - Click `Add`
        - Select: `Filter by name (with wildcards)`
        - Include: `app-*`
    - Property strategy: `All branches get the same properties`
    - BUILD CONFIGURATION
      - Mode: Select `by Jenkinsfile`
      - Script Path: `Jenkinsfile`
    - SCAN MULTIBRANCH PIPELINE TRIGGER
      - Select `Scan by webhook`
      - Trigger token: `automation`
    - Click on `Apply` and `Save`
    
    - CONFIGURE MULTIBRANCH PIPELINE WEBHOOK
      - Copy this URL and Update the Jenkins IP (to yours): `http://PROVIDE_YOUR_JENKINS_IP:8080/multibranch-webhook-trigger/invoke?token=automation` 
      - Navigate to your `Project Repository`
        - Click on `Settings` in the Repository
        - Click on `Webhooks`
        - Click on `Add Webhook`
        - Payload URL: `http://PROVIDE_YOUR_JENKINS_IP:8080/multibranch-webhook-trigger/invoke?token=automation`
        - Content type: `application/json`
        - Which events would you like to trigger this webhook: Select `Just the push event`
        - Enable `Active`
        - Click `ADD WEBHOOK`

### Navigate Back To Jenkins and Confirm That All 12 Pipeline Jobs Are Running (11 Microservices Jobs and 1 DB Job)
  - Click on the `Jenkins Pipeline Job Name`
  - Click on `Scan Multibranch Pipeline Now`
  ![MicroservicesPipelineJobs](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/scan_all_branch_pipelines.png)

### Confirm That All Microservices Branch Pipelines Succeeded (If Not, Troubleshoot)
![MicroservicesPipelineJobs](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/piepline1.png)
![MicroservicesPipelineJobs](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/piepline2.png)

### SonarQube Code Inspection Result For All Microservices Source Code
  ![SonarQubeResult!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sonarqube-test.png)

### Also Confirm You Have All Service Deployment/Docker Artifacts In DockerHub
![DockerHubImages](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/microservices-artifacts.png)

### PERFORM THE DEPLOYMENT IN THE STAGING ENVIRONMENT/NAMESPACE (EKS CLUSTER)
- To perform the DEPLOYMENT in the staging Envrionment 
- You Just Have To `UNCOMMENT` the `DEPLOY STAGE` in the `Jenkinsfiles.....` and `PUSH` to GitHub
- DEPLOY the Microservices in the STAGING Environment in the following ORDER (To Resolve DEPENDENCIES around the SERVICES)

1. *`Redis DB`*
2. *`Product Catalog Service`*
3. *`Email Service`*
4. *`Currency Service`*
5. *`Payment Service`*
6. *`Shipping Service`*
7. *`Cart Service`*
8. *`Ad Service`*
9. *`Recommendation Service`*
10. *`Checkout Service`*
11. *`Frontend`*
12. *`Load Generator`*

  ### A. Test Application Access From the `Test/Stagging-Environment` Using `NodePort` of one of your Workers
  - SSH Back into your `Jenkins-CI` Server
      - RUN: `kubectl get svc -n test-env`
      - **NOTE:** COPY the Exposed `NodePort Pod Number`
      ![NodeportTestEnv](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/dssdsdsdsasasfdghjkjnbf.png)
  
  - Access The Application Running in the `Test Environment` within the Cluster
  - `Update` the EKS Cluster Security Group ***(If you've not already)***
    - To do this, navigate to `EC2`
    - Select one of the `Worker Nodes` --> Click on `Security` --> Click on `The Security Group ID`
    - Click on `Edit Inbound Rules`: Port = `30000` and Source `0.0.0.0/0`
  - Open your Browser
  - Go to: http://YOUR_KUBERNETES_WORKER_NODE_IP:30000
  ![TestEnv]()

  - Stage Deployment Succeeded
  ![TestEnv](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/piepline2.png)

### PERFORM THE DEPLOYMENT NOW TO THE PRODUCTION ENVIRONMENT/NAMESPACE (EKS CLUSTER)
- To perform the DEPLOYMENT to the Prod Envrionment 
- You Just Have To `UNCOMMENT` the `DEPLOY STAGE` in the `Jenkinsfiles.....` and `PUSH` to GitHub
- DEPLOY the Microservices to the Prod Environment in the following ORDER (To Resolve DEPENDENCIES around the SERVICES)

1. *`Redis DB`*
2. *`Product Catalog Service`*
3. *`Email Service`*
4. *`Currency Service`*
5. *`Payment Service`*
6. *`Shipping Service`*
7. *`Cart Service`*
8. *`Ad Service`*
9. *`Recommendation Service`*
10. *`Checkout Service`*
11. *`Frontend`*
12. *`Load Generator`*

  - Confirm That Your Production Deployment Succeeded
  ![ProdEnv]() 
      - To access the application running in the `Prod-Env`
      - Navigate back to the `Jenkins-CI` shell 
      - RUN: `kubectl get svc`
      - Copy the LoadBalancer DNS and Open on a TAB on your choice Browser http://PROD_LOADBALANCER_DNS
      ![TestEnv]()

  - SonarQube Code Inspection Result For All Microservices Source Code
  ![SonarQubeResult!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sonarqube-test.png)

  - Snyk SCA Test Result
  ![SnykResult!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/snyk-sdcsvbfgddx.png)

  - Test/Scan Dockerfiles with Open Policy Agent (OPA)
  ![OPATest!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/OPA-Analysis.png)

  - Slack Continuous Feedback Alert
  ![SlackResult!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/asasasdsffghgjkjhjtyreew.png)

### Congratulations Your Deployment Was Successful

| Home Page                                                                                                         | Checkout Page                                                                                                    |
| ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| [![Screenshot of store homepage](/docs/img/online-boutique-frontend-1.png)](/docs/img/online-boutique-frontend-1.png) | [![Screenshot of checkout screen](/docs/img/online-boutique-frontend-2.png)](/docs/img/online-boutique-frontend-2.png) |


