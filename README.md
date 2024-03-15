# DevSecOps CI/CD Pipeline Project Automation Arch
![ProjectArch](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/DevSecOps-Project-Archas.png)

## Continuous Observability (Monitoring & Logging) Arch
![PromGrafEFKArch](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/prom-graf-efk.avif)

###### Project ToolBox 🧰
- [Git](https://git-scm.com/) Git is a distributed version control system that helps you track changes in any set of computer files, usually used for coordinating work among developers who collaboratively develops software.
- [Github](https://github.com/) Github is a free and open source distributed VCS designed to handle everything from small to very large projects with speed and efficiency
- [Jenkins](https://www.jenkins.io/) Jenkins is an open source automation CI tool which enables developers around the world to reliably build, test, and deploy their software
- [NPM](https://www.npmjs.com/) npm is the world's largest software registry. Open source developers from every continent use npm to share and borrow packages, and many organizations use npm to manage private development as well.
- [SonarQube|SAST](https://docs.sonarqube.org/) SonarQube Catches bugs and vulnerabilities in your app, with thousands of automated Static Code Analysis rules.
- [OWASP|SCA](https://owasp.org/www-project-dependency-check/) Dependency-Check is a Software Composition Analysis (SCA) tool that attempts to detect publicly disclosed vulnerabilities contained within a project’s dependencies.
- [Trivy|SAST|IAST](https://trivy.dev/) Trivy is the most popular open source security scanner, reliable, fast, and easy to use. Use Trivy to find vulnerabilities & IaC misconfigurations, SBOM discovery, Cloud scanning, Kubernetes security risks,and more.
- [ZAP](https://www.zaproxy.org/) OWASP ZAP is a penetration testing and DAST tool that helps developers and security professionals detect and find vulnerabilities in web applications at runtime.
- [GitGuardian|HoneyTokens](https://www.gitguardian.com/) GitGuardian helps developers and organizations secure their software development process by automatically detecting secrets like API keys, passwords, certificates, encryption keys and other sensitive data. It can as well remediate the risk for private or public source code repositories. 
- [Docker](https://www.docker.com/) Docker helps developers build, share, run, and verify applications anywhere — without tedious environment configuration or management.
- [Docker Hub](https://hub.docker.com/) Docker Hub is a container registry built for developers and open source contributors to find, use, and share their container images.
- [Kubernetes](https://kubernetes.io/) Kubernetes, also known as K8s, is an open-source system for automating and orchestrating deployment, scaling, and management of containerized applications.
- [AWS EKS](https://aws.amazon.com/eks/) In the cloud, Amazon EKS automatically manages the availability and scalability of the Kubernetes control plane nodes responsible for scheduling containers, managing application availability, storing cluster data, and other key tasks.
- [EC2](https://aws.amazon.com/ec2/) EC2 allows users to rent virtual computers (EC2) to run their own workloads and applications.
- [Fluentd|Logstash](https://www.elastic.co/logstash/) Fluentd and Logstash are a free and open server-side data processing pipeline that ingests data from a multitude of sources, transforms it, and then sends it to your favorite "stash."
- [Elasticsearch](https://www.elastic.co/elasticsearch/) Elasticsearch is a search engine based on the Lucene library. It provides a distributed, multitenant-capable full-text search engine with an HTTP web interface and schema-free JSON documents.
- [Kibana](https://www.elastic.co/kibana/) Kibana is a source-available data visualization dashboard software for Elasticsearch.
- [Prometheus](https://prometheus.io/) Prometheus is a free software application used for event/metric monitoring and alerting for both application and infrastructure.
- [Grafana](https://grafana.com/) Grafana is a multi-platform open source analytics and interactive visualization web application. It provides charts, graphs, and alerts for the web when connected to supported data sources.
- [Slack](https://slack.com/) Slack is a communication platform designed for collaboration which can be leveraged to build and develop a very robust DevOps culture. Will be used for Continuous feedback loop.

# Jenkins Complete CI/CD Pipeline Project Runbook
1) Create a GitHub Repository with the name `DevSecOps-Realworld-CICD-Project` and push the code in this branch *(dev-sec-ops-cicd-pipeline-project-one)* to your remote repository (your newly created repository). 
    - Go to GitHub: https://github.com
    - Login to `Your GitHub Account`
    - Create a Repository called `DevSecOps-Realworld-CICD-Project`
    - Clone the Repository in the `Repository` directory/folder on your `local machine`
    - Download the code in in this repository `"dev-sec-ops-cicd-pipeline-project-one branch"`: https://github.com/awanmbandi/realworld-microservice-project.git
    - `Unzip` the `code/zipped file`
    - `Copy` and `Paste` everything `from the zipped file` into the `repository you cloned` in your local
    - Open your `Terminal`
        - Add the code to git, commit and push it to your upstream branch "main or master"
        - Add the changes: `git add -A`
        - Commit changes: `git commit -m "adding project source code"`
        - Push to GitHub: `git push`
    - Confirm that the code is now available on GitHub 

2) Sign Up For GitGuardian for continuous Secrete scanning
- Click on the following link to access GitGuardian: https://www.gitguardian.com/
    - Click on `Start For Free`
    - Select `Sign up with GitHub`
    - Once you sign up, you should have a page that looks like this...
    ![GitGuardian!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/ererere.png)

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
        - Name & Description: `DevSecOps-Jenkins-CI-SG`
        - What we actually need: `8080`, `9000` and `22` to `0.0.0.0/0`
    - Storage: Increase to `50 GB`
    - IAM instance profile: Select the `AWS-EC2FullAccess-Role`
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-microservice-project/blob/dev-sec-ops-cicd-pipeline-project-one/installations.sh
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
      - Create a `Private Channel` using the naming convention `YOUR_INITIAL-devsecops-cicd-alerts`
        - **NOTE:** *`(The Channel Name Must Be Unique, meaning it must be available for use)`*
      - Visibility: Select `Private`
      - Click on the `Channel Drop Down` and select `Integrations` and Click on `Add an App`
      - Search for `Jenkins` and Click on `View`
      - Click on `Configuration/Install` and Click `Add to Slack` 
      - On Post to Channel: Click the Drop Down and select your channel above `YOUR_INITIAL-devsecops-cicd-alerts`
      - Click `Add Jenkins CI Integration`
      - Scrol Down and Click `SAVE SETTINGS/CONFIGURATIONS`
      - Leave this page open
      ![SlackConfig!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/efafdf.png)

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

# Confirm that Trivy is running
trivy --version

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
```bash
# Clone your project reporisoty
git clone https://github.com/awanmbandi/realworld-microservice-project.git

# cd and checkout into the DevSecOps project branch
cd realworld-microservice-project && git checkout dev-sec-ops-cicd-pipeline-project-one
cd eks-terraform

# Deploy EKS Environment
terraform init
terraform plan
terraform apply --auto-approve
```
- Navigate to `EKS` and confirm your Cluster was created successfully
- Also confirmthere's no issue regarding your Terraform execution
![JenkinsSetup1!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsdsdas.png)
![JenkinsSetup2!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sfgsfs.png)

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
        - **NodeJS**
        - **Eclipse Temurin installer**
        - **Docker**
        - **Docker Commons**
        - **Docker Pipeline**
        - **docker-build-step**
        - **Docker API**
        - **OWASP Dependency-Check**
        - **Terraform**
        - **Kubernetes**
        - **Kubernetes CLI**
        - **Kubernetes Credentials**
        - **Kubernetes Client API**
        - **Kubernetes Credentials Provider**
        - **Kubernetes :: Pipeline :: DevOps Steps**
        - **Slack Notification**
        - **ssh-agent**
        - **BlueOcean**
        - **Build Timestamp (Needed for Artifact versioning)**
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

    - **Dependency-Check installations** 
      - Click on `Add Dependency-Check`
      - Name: `OWASP-Dependency-Check`
      - Click on `Add installer`
        - Select `Install from github.com` 
      - Enable: `Install automatically`
      - Version: Select `6.5.1`
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/SDSVFSD.png)
    
    - **Docker installations** 
      - Click on `Add Docker` 
      - Name: `Docker`
      - Click on `Add installer`
        - Select `Download from docker.com`
        - Docker version: `latest`
      - Enable: `Install automatically` 
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/svfdsv.png)
    
    - **Terraform Installation** 
      - Click on `Add Terraform` 
      - Name: `Terraform`
      - Disable/Uncheck: `Install automatically` 
        - NOTE: *Please Do Not Check The ``Install automatically`*
      - Install directory: provide `/usr/bin/`
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/ASFADAD.png)

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
              - Click on `Manually`
                - Project display name: `NodeJS-WebApp-Project`
                - Display key: `NodeJS-WebApp-Project`
                - Main branch name: `dev-sec-ops-cicd-pipeline-project-one` 
              - Click on `Set Up`
                - Click on `Locally` 
                - Token Name ``NodeJS-WebApp-SonarQube-Token``
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

2)  ### Setup SonarQube Webhook to Integrate Jenkins (To pass the results to Jenkins)
    - Click on `Administration` 
    - Click on `Configuration` and Select `Webhook`
    - Click on `Create Webhook` 
      - Name: `jenkinswebhook`
      - URL: `http://Jenkins-Server-Private-IP:8080/sonarqube-webhook/`
    ![SonarQubeSetup4!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2011.08.26%20AM.png)

    - Go ahead and Confirm in the Jenkinsfile you have the “Quality Gate Stage”. The stage code should look like the below;
    ```bash
    stage('SonarQube GateKeeper') {
        steps {
          timeout(time : 1, unit : 'HOURS'){
          waitForQualityGate abortPipeline: true, credentialsId: 'SonarQube-Credential'
          }
       }
    }
    ```
     - Run Your Pipeline To Test Your Quality Gate (It should PASS QG)
     - **(OPTIONAL)** FAIL Your Quality Gate: Go back to SonarQube -->> Open your Project -->> Click on Quality Gates at the top -->> Select your Project Quality Gate -->> Click EDIT -->> Change the Value to “0” -->> Update Condition
     - **(OPTIONAL)** Run/Test Your Pipeline Again and This Time Your Quality Gate Should Fail 
     - **(OPTIONAL)** Go back and Update the Quality Gate value to 10. The Exercise was just to see how Quality Gate Works

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

### Update the EKS Cluster Security Group (Add A NodePort)
- Navigate to `EC2`
  - Select any of the `Cluster Worker Nodes`
  - Click on `Security`
  - Click on the `EKS Cluster Security Group ID`
  - Click on `Edit Inbound Rules`
  - Click on `Add Rule`
  - Port Number: `30000`, Source: `0.0.0.0/0`
  - Click on `SAVE`

### Deploy Monitoring and Logging Solution Using EFK Stack, Prometheus & Grafana 
1) ### Deploy and Configure EFK Stack
- SSH Back into your `Jenkins-CI` instance
    - Run the Following Commands to Deploy the `EFK Stack including Prometheus and Grafana k8s manifest`
```bash
# Get cluster nodes
kubectl get nodes

# Get cluster pods
kubectl get pods

# Get all kubernets Objects
kubectl get all

# Deploy EFK Stack and give it about 10 Minutes before deploying the Prom & Graf..
cd ../efk-stack
ls -al
kubectl apply -f .

# Confirm EFK Resources
kubectl get ns
kubectl get all -n efklog
```
![EFKStack!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsfbsfb.png)
  - Access the `Kibana Dashboard`: *KIBANA_LOADBALANCER_URL:5601*
  - Click on `Explore on my own`
  - Click on `Discovery` and create an `Index Pattern`
  - Index Pattern: `logstash*`
  ![Kibana1](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/asfsbsfb.png) 

  - Time Filter field name: Select `@timestamp` 
  - Click `Create Index Pattern`
  ![Kibana1](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdgsvd.png) 

  - Confirm that you atleast have some `Logs` displayed on the `Kibana Discovery Page`
  ![Kibana1](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sgfsgs.png) 

2) ### Deploy and Configure Prometheus and Grafana
- Navigate back to your `Jenkins-CI SSH Shell` where you're logged in
- Run the following commands
```bash
# Navigate to the monitoring directory
cd ../monitoring/

# Start by Deploying the Kubernetes CRDs Configuration/Manifest
kubectl apply -f crds.yaml

# The Deploy the `eks-monitoring.yaml` config
kubectl apply -f eks-monitoring.yaml

# Resources created Pods, Deployments, ReplicaSets and Services deployed in the `Monitoring` Namespace
kubectl get ns
kubectl get pods -n monitoring
kubectl get svc -n monitoring
```
![Prom&Graf1](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsdsdsdsdsdsdsdsd.png)
![Prom&Graf1](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/Prom-Grafana.png)

#### Access the PROMETHEUS Dashboard
- RUN: `kubectl get svc -n monitoring`
- COPY the DNS of the LoadBalancer of the Service: `monitoring-kube-prometheus-prometheus`
    - **NOTE:** *You can as well get this from the EC2 --> LoadBalancer service*
- Open a new tab: http://YOUR_PROMETHEUS_LOADBALANCER_DNS:9090
![Prom&Graf1](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/PROMETHEUS.png)

#### Access the GRAFANA Dashboard
- RUN: `kubectl get svc -n monitoring`
- COPY the DNS of the LoadBalancer of the Service: `monitoring-grafana`
    - **NOTE:** *You can as well get this from the EC2 --> LoadBalancer service*
- Open a new tab: http://YOUR_GRAFANA_LOADBALANCER_DNS:9090
    - Username: `admin`
    - Password: `prom-operator`
![Prom&Graf1](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sddsds.png)

#### Access Your Project Pre-Build Dashboards
- Click on `HOME`
- These are the three most `Important Dashboards` which you can click and open any
    - `Node Exporter / USE Method / Node` 
    - `Node Exporter / USE Method / Cluster`
    - `Kubernetes / Networking / Pod`

- Click on the `Node Exporter / USE Method / Node` 
![Prom&Graf1](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdvsdv.png)

### Pipeline creation (Make Sure To Make The Following Updates First)
- UPDATE YOUR ``Jenkinsfile``
- Update your `OWASP Zap Server IP (Which is Jenkins IP)` in the `Jenkinsfile` on `Line 87`
- Update the `EKS Worker Node IP` with yours in the `Jenkinsfile` on `Line 87`
- Update your `Slack Channel Name` in the `Jenkinsfile` on `Line 104`
- Update `SonarQube projectName` in your `Jenkinsfile` On `Line 34`
- Update the `SonarQube projectKey` in your `Jenkinsfile` On `Line 35`
- Update the `DockerHub username` in the `Jenkinsfile` on `Line 62`, `Line 63` and `Line 70` provide Yours
    
    - Log into Jenkins: http://Jenkins-Public-IP:8080/
    - Click on `New Item`
    - Enter an item name: `DevSecOps-CICD-Pipeline-Automation` 
    - Select the category as **`Pipeline`**
    - Click `OK`
    - GitHub hook trigger for GITScm polling: `Check the box` 
      - **NOTE:** Make sure to also configure it on *GitHub's side*
    - Pipeline Definition: Select `Pipeline script from SCM`
      - SCM: `Git`
      - Repositories
        - Repository URL: `Provide Your Project Repo Git URL` (the one you created in the initial phase)
        - Credentials: `none` *since the repository is public*
        - Branch Specifier (blank for 'any'): ``*/dev-sec-ops-cicd-pipeline-project-one``
        - Script Path: ``Jenkinsfile``
    - Click on `SAVE`
    - Click on `Build Now` to *TEST Pipeline* 

    ### A. Test Application Access From the `Test-Environment` Using `NodePort` of one of your Workers
    - SSH Back into your `Jenkins-CI` Server
        - RUN: `kubectl get svc -n test-env`
        - **NOTE:** COPY the Exposed `NodePort Pod Number`
        ![NodeportTestEnv](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/dssdsdsds.png)
    
    - Access The Application Running in the `Test Environment` within the Cluster
    - `Update` the EKS Cluster Security Group ***(If you've not already)***
      - To do this, navigate to `EC2`
      - Select one of the `Worker Nodes` --> Click on `Security` --> Click on `The Security Group ID`
      - Click on `Edit Inbound Rules`: Port = `30000` and Source `0.0.0.0/0`
    - Open your Browser
    - Go to: http://YOUR_KUBERNETES_WORKER_NODE_IP
    ![TestEnv](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/test.png)

    - Stage Deployment Succeeded
    ![TestEnv](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsdsdsdsds.png)

    - Production Deployment Succeeded
    ![ProdEnv](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/dffdffdd.png) 
        - To access the application running in the `Prod-Env`
        - Navigate back to the `Jenkins-CI` shell 
        - RUN: `kubectl get svc`
        - Copy the LoadBalancer DNS and Open on a TAB on your choice Browser http://PROD_LOADBALANCER_DNS
        ![TestEnv](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/test.png)
    
    - You can as well get this from the LoadBalancer Service in EC2:
    ![TestEnv](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/SDSDDS.png)

    - SonarQube Code Inspection Result
    ![SonarQubeResult!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsdsdsdsdsdsdsds.png)

    - OWASP Dependency Inspection Result
    ![SonarQubeResult!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/OWASP.png)

    - Slack Continuous Feedback Alert
    ![SlackResult!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsddsdsdsdsds.png)

    - SonarQube GateKeeper Webhook Payload
    ![SonarQubeGateKeeper!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsdsdsdsdsdsdsd.png)

    - Trivy CIS, NSA and PSS Cluster and Application Reports
    ![SonarQubeResult!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsdsdsdsdsdsdssdsdsds.png)

    - EFK - Kibana Dashbaord
    ![Kibana!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/kibana.png)

    - EFK - Grafana Dashbaord (Pods)
    ![Kibana!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdsdsdsdsdsdsdds.png)

    - GET the Following Compliance Reports (`CIS`, `NSA` and `PSS`)
    ![ComplianceReports!]()

    ### B. Troubleshooting (Possible Issues You May Encounter and Suggested Solutions)
    1) **1st ISSUE:** If you experience a long wait time at the level of `GateKeeper`, please check if your `Sonar Webhook` is associated with your `SonarQube Project` with `SonarQube Results`
    - If you check your jenkins Pipeline you'll most likely find the below message at the `SonarQube GateKeper` stage
    ```bash
    JENKINS CONSOLE OUTPUT

    Checking status of SonarQube task 'AYfEB4IQ3rP3Y6VQ_yIa' on server 'SonarQube'
    SonarQube task 'AYfEB4IQ3rP3Y6VQ_yIa' status is 'PENDING'
    ```

    2) #### Only Meant For Those That Are Facing Issues With SonarQube Analysis Because They Stopped and Restarted Jenkins
    - The above `Jenkins Userdata` includes a `SonarQube` container deployment task
      - As a result, we know containers are `Ephemeral` by natuure, so if you `Stop` your `Jenkins CI Server` at any point in time... You'll have to `Deploy the Container` again when you `Start` it back or bring the instance up again.
      - If you don't do this, you will not be able able to proceed with the project.
      - I have also Included a `Docker Volume` setup task as well for `SonarQube`, where the Container Data will be persisted to avoid Data lost.
```bash
# Volume inspection, confirm the docker volume exist
docker volume inspect volume sonarqube-volume

# Create a new conainter, provide your container name and deploy in the `Jenkins-CI` server
docker run -d --name PROVIDE_NEW_NAME_HERE -v sonarqube-volume:/opt/sonarqube/data -p 9000:9000 sonarqube:lts-community
```



