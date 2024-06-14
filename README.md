# Multi-Microservice Application Project Architecture
![ProjectArch](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/%5BK8S%20Project%5D%20Multi-Service%20Application%20Project%20Arch.png)
***

###### Microservices Application CI/CD Pipeline Architecture One
![PipelineArch1](https://github.com/awanmbandi/realworld-microservice-project/blob/main/docs/architectures/%5BCI-CD%20Arch%201%5D%20Microservices%20CI-CD-1.png)

***
###### Microservices Application CI/CD Pipeline Architecture Two
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
- Navigate to `EKS` and confirm your Cluster was created successfully
- Also confirmthere's no issue regarding your Terraform execution
![JenkinsSetup1!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsdsdas.png)
![JenkinsSetup2!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sfgsfs.png)

### 5C) Once The Cluster Deployment Completes, Go Ahead and Enable The OIDC Connector/Provider
```bash
eksctl utils associate-iam-oidc-provider \
    --region us-east-2 \
    --cluster EKS_Cluster \
    --approve
```

#### Update/Get Cluster Credential: 
```bash
aws eks update-kubeconfig --name <clustername> --region <region>
```

#### Update Your EKS Cluster Security Group and OPEN The Following Ports
  * 30000-32767
  * 80 
  * 22

### Jenkins setup
1) #### Access Jenkins
    Copy your Jenkins Public IP Address and paste on the browser = ExternalIP:8080
    - Login to your Jenkins instance using your Shell (GitBash or your Mac Terminal)
    - Copy the Path from the Jenkins UI to get the Administrator Password
        - Run: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
        - Copy the password and login to Jenkins
    ![JenkinsSetup1!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/jenkins-signup.png) 
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
        - **NodeJS**
        - **Eclipse Temurin installer**
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
    - Select/Check the Box **Restart Jenkins when installation is complete and no jobs are running**
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
    
    - **SonarQube Scanner** 
      - Click on `Add SonarQube Scanner` 
      - Name: `SonarScanner`
      - Enable: `Install automatically` 
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/dcsdsvsvd.png)
    
    - **NodeJS installations** 
      - Click on `Add NodeJS` 
      - Name: `NodeJS16`
      - Enable: `Install automatically` 
      - Version: Select `16.2.0`
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdvsvsd.png)
    
    - **Docker installations** 
      - Click on `Add Docker` 
      - Name: `Docker`
      - Click on `Add installer`
        - Select `Download from docker.com`
        - Docker version: `latest`
      - Enable: `Install automatically` 
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/svfdsv.png)
    
    - **Gradle Installation**
      - Click on `Add Gradle`
      - Name: `Gradle`
      - Enable `Install automatically`
      - Version: *Go with the latest*
      ![GradleInstallation!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/gradle-setup.png)
    
    - **Snyk Installations** 
      - Click on ``Add Snyk`
      - Name: `Snyk`
      - Enable: `Install automatically` 
        - Version: `latest`
        - Update policy interval (hours): `24`
        - OS platform architecture: `Auto-detection`
      ![SnykInstallation!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/snyk-install.png)



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
                - Project display name: `app-shipping-service-analysis`
                - Display key: `app-shipping-service-analysis`
                - Main branch name: `app-shipping-service` 
              
              - Click on `Projects` *(Create the `app-recommendation-service` microservice test project)*
                - Project display name: `app-recommendation-service-analysis`
                - Display key: `app-recommendation-service-analysis`
                - Main branch name: `app-recommendation-service` 
              
              - Click on `Projects` *(Create the `app-product-catalog-service` microservice test project)*
                - Project display name: `app-product-catalog-service-analysis`
                - Display key: `app-product-catalog-service-analysis`
                - Main branch name: `app-product-catalog-service` 
              
              - Click on `Projects` *(Create the `app-payment-service` microservice test project)*
                - Project display name: `app-payment-service-analysis`
                - Display key: `app-payment-service-analysis`
                - Main branch name: `app-payment-service` 
              
              - Click on `Projects` *(Create the `app-loadgenerator-service` microservice test project)*
                - Project display name: `app-loadgenerator-service-analysis`
                - Display key: `app-loadgenerator-service-analysis`
                - Main branch name: `app-loadgenerator-service` 
              
              - Click on `Projects` *(Create the `app-frontend-service` microservice test project)*
                - Project display name: `app-frontend-service-analysis`
                - Display key: `app-frontend-service-analysis`
                - Main branch name: `app-frontend-service`
              
              - Click on `Projects` *(Create the `app-email-service` microservice test project)*
                - Project display name: `app-email-service-analysis`
                - Display key: `app-email-service-analysis`
                - Main branch name: `app-email-service` 
              
              - Click on `Projects` *(Create the `app-database` microservice test project)*
                - Project display name: `app-database-analysis`
                - Display key: `app-database-analysis`
                - Main branch name: `app-database` 
              
              - Click on `Projects` *(Create the `app-currency-service` microservice test project)*
                - Project display name: `app-currency-service-analysis`
                - Display key: `app-currency-service-analysis`
                - Main branch name: `app-currency-service` 
              
              - Click on `Projects` *(Create the `app-checkout-service` microservice test project)*
                - Project display name: `app-checkout-service-analysis`
                - Display key: `app-checkout-service-analysis`
                - Main branch name: `app-checkout-service` 
              
              - Click on `Projects` *(Create the `app-cart-service` microservice test project)*
                - Project display name: `app-cart-service-analysis`
                - Display key: `app-cart-service-analysis`
                - Main branch name: `app-cart-service` 
              
              - Click on `Projects` *(Create the `app-ad-serverice` microservice test project)*
                - Project display name: `app-ad-serverice-analysis`
                - Display key: `app-ad-serverice-analysis`
                - Main branch name: `app-ad-serverice` 

              - Click on `Set Up`
                - Click on `Locally` 
                - Token Name ``Multi-Microservice-SonarQube-Token``
                - **NOTE:** *Copy the TOKEN and SAVE somwhere on your NodePad*
              - Click on `Generate`
              - Click on `Continue`
              - Run analysis on your project: Select `Other (for JS, TS, Go, Python, PHP, ...)`
              - What is your OS?: Select `Linux`
              - `COPY` the Execute the Scanner and `SAVE` on your NodePad as well
            - Generate a `Global Analysis Token`    *This is the Token you need for Authorization*
              - Click on the `User Profile` icon at top right of SonarQube
              - Click on `My Account`
              - Generate Token:   *Generate this TOKEN and Use in the Next Step to Create The SonarQube Credential* 
              ![Sonar!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsdsddsd.png) 
              - Click `Generate` 

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

      4)  ##### Kubernetes Cluster Credential (kubeconfig)
        - ###### Start By Increasing The `EBS Volume Size` of Your Kubernetes Cluster Worker Nodes
            - Navigate to `EC2`
            - Click on `Volumes`
            - Select and `Modify` *Both Nodes Volumes*
            - Size: `130 GB`
            - Click `Modify`

        - ###### Get Cluster Credential From Kube Config
            - `SSH` back into your `Jenkins-CI` server
            - RUN the command: `aws eks update-kubeconfig --name <clustername> --region <region>`
            - COPY the Cluster KubeConfig: `cat ~/.kube/config`
            - `COPY` the KubeConfig file content
                - Create a File Locally
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
            - Run the Command `cat YOUR_SSH_KEY_FILE_NAME.pem`
            - COPY the KEY content and Navigate back to Jenkins to store it...
        
         - ###### Create The ZAP Server SSH Key Credential in Jenkins
            - Navigate to the `Jenkins Global Credential Dash`
            - Click on `Create Credentials`
            - Scope: Select `Global......`
            - ID and Description: `OWASP-Zap-Credential`
            - Username: `ubuntu`
            - Private key: Select
              - Key: Click on `Add`
              - Key: `Paste The Private Key Content You Copied`
            - Click on `Create`
        ![KubeCredential!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/afdafdsfgfg.png)

### SonarQube Configuration
1)  ### Setup SonarQube GateKeeper
    - Click on `Quality Gate` 
    - Click on `Create`
    - Name: `NodeJS-Webapp-QualityGate`
    ![SonarQubeSetup2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/dsdsdsdsdsdsds.png)
    - Click on `Save` to Create
    ![SonarQubeSetup2!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsds.png)
    - Click on `Unlock Editing`
        - **NOTE:** *IMPORTANT*
    - Click `Add Condition` to Add a Quality Gate Condition to Validate the Code Against (Code Smells or Bugs)
    ![SonarQubeSetup3!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsdsdsd.png)
    
    - Add Quality to SonarQube Project
    -  ``NOTE:`` Make sure to update the `SonarQube` stage in your `Jenkinsfile` and Test the Pipeline so your project will be visible on the SonarQube Project Dashboard.
    - Click on `Projects` 
    - Click on your project name `NodeJS-Webapp-Project` 
      - Click on `Project Settings`
      - Click on `Quality Gate`
      - Select your QG `NodeJS-Webapp-QualityGate`

    ![SonarQubeSetup3!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdvfsv.png)

Find **Protocol Buffers Descriptions** at the [`./protos` directory](/protos).

| Service                                              | Language      | Description                                                                                                                       |
| ---------------------------------------------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| [frontend](/src/frontend)                           | Go            | Exposes an HTTP server to serve the website. Does not require signup/login and generates session IDs for all users automatically. |
| [cartservice](/src/cartservice)                     | C#            | Stores the items in the user's shopping cart in Redis and retrieves it.                                                           |
| [productcatalogservice](/src/productcatalogservice) | Go            | Provides the list of products from a JSON file and ability to search products and get individual products.                        |
| [currencyservice](/src/currencyservice)             | Node.js       | Converts one money amount to another currency. Uses real values fetched from European Central Bank. It's the highest QPS service. |
| [paymentservice](/src/paymentservice)               | Node.js       | Charges the given credit card info (mock) with the given amount and returns a transaction ID.                                     |
| [shippingservice](/src/shippingservice)             | Go            | Gives shipping cost estimates based on the shopping cart. Ships items to the given address (mock)                                 |
| [emailservice](/src/emailservice)                   | Python        | Sends users an order confirmation email (mock).                                                                                   |
| [checkoutservice](/src/checkoutservice)             | Go            | Retrieves user cart, prepares order and orchestrates the payment, shipping and the email notification.                            |
| [recommendationservice](/src/recommendationservice) | Python        | Recommends other products based on what's given in the cart.                                                                      |
| [adservice](/src/adservice)                         | Java          | Provides text ads based on given context words.                                                                                   |
| [loadgenerator](/src/loadgenerator)                 | Python/Locust | Continuously sends requests imitating realistic user shopping flows to the frontend.                                              |

**Online Boutique** is a cloud-first microservices demo application.
Online Boutique consists of an 11-tier microservices application. The application is a
web-based e-commerce app where users can browse items,
add them to the cart, and purchase them.

Google uses this application to demonstrate the use of technologies like
Kubernetes, GKE, Istio, Stackdriver, and gRPC. This application
works on any Kubernetes cluster, like Google
Kubernetes Engine (GKE). It’s **easy to deploy with little to no configuration**.

If you’re using this demo, please **★Star** this repository to show your interest!

**Note to Googlers (Google employees):** Please fill out the form at [go/microservices-demo](http://go/microservices-demo).

## Screenshots

| Home Page                                                                                                         | Checkout Page                                                                                                    |
| ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| [![Screenshot of store homepage](/docs/img/online-boutique-frontend-1.png)](/docs/img/online-boutique-frontend-1.png) | [![Screenshot of checkout screen](/docs/img/online-boutique-frontend-2.png)](/docs/img/online-boutique-frontend-2.png) |


