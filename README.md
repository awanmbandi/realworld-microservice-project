# DevSecOps CI/CD Pipeline Project Automation Arch
![ProjectArch](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/DevSecOps%20Projects%20-%20DevSecOps-P1%20(2).png)

## Continuous Observability (Monitoring & Logging) Arch
![PromGrafEFKArch](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/prom-graf-efk.avif)

###### Project ToolBox 🧰
- [Git](https://git-scm.com/) Git will be used to manage our application source code.
- [Github](https://github.com/) Github is a free and open source distributed VCS designed to handle everything from small to very large projects with speed and efficiency
- [Jenkins](https://www.jenkins.io/) Jenkins is an open source automation CI tool which enables developers around the world to reliably build, test, and deploy their software
- [NPM](https://www.npmjs.com/) npm is the world's largest software registry. Open source developers from every continent use npm to share and borrow packages, and many organizations use npm to manage private development as well.
- [SonarQube|SAST](https://docs.sonarqube.org/) SonarQube Catches bugs and vulnerabilities in your app, with thousands of automated Static Code Analysis rules.
- [OWASP|SCA](https://owasp.org/www-project-dependency-check/) Dependency-Check is a Software Composition Analysis (SCA) tool that attempts to detect publicly disclosed vulnerabilities contained within a project’s dependencies.
- [Trivy|SAST|IAST](https://trivy.dev/) Trivy is the most popular open source security scanner, reliable, fast, and easy to use. Use Trivy to find vulnerabilities & IaC misconfigurations, SBOM discovery, Cloud scanning, Kubernetes security risks,and more.
- [GitGuardian|HoneyTokens](https://www.gitguardian.com/) GitGuardian helps developers and organizations secure their software development process by automatically detecting secrets like API keys, passwords, certificates, encryption keys and other sensitive data. It can as well remediate the risk for private or public source code repositories. 
- [Docker](https://www.docker.com/) Docker helps developers build, share, run, and verify applications anywhere — without tedious environment configuration or management.
- [Kubernetes](https://kubernetes.io/) Kubernetes, also known as K8s, is an open-source system for automating and orchestrating deployment, scaling, and management of containerized applications.
- [EC2](https://aws.amazon.com/ec2/) EC2 allows users to rent virtual computers (EC2) to run their own workloads and applications.
- [Fluentd|Logstash](https://www.elastic.co/logstash/) Fluentd and Logstash are a free and open server-side data processing pipeline that ingests data from a multitude of sources, transforms it, and then sends it to your favorite "stash."
- [Elasticsearch](https://www.elastic.co/elasticsearch/) Elasticsearch is a search engine based on the Lucene library. It provides a distributed, multitenant-capable full-text search engine with an HTTP web interface and schema-free JSON documents.
- [Kibana](https://www.elastic.co/kibana/) Kibana is a source-available data visualization dashboard software for Elasticsearch.
- [Prometheus](https://prometheus.io/) Prometheus is a free software application used for event/metric monitoring and alerting for both application and infrastructure.
- [Grafana](https://grafana.com/) Grafana is a multi-platform open source analytics and interactive visualization web application. It provides charts, graphs, and alerts for the web when connected to supported data sources.
- [Slack](https://slack.com/) Slack is a communication platform designed for collaboration which can be leveraged to build and develop a very robust DevOps culture. Will be used for Continuous feedback loop.

# Jenkins Complete CI/CD Pipeline Project Runbook
1) Create a GitHub Repository with the name `DevSecOps-Realworld-CICD-Project` and push the code in this branch(main) to 
    your remote repository (your newly created repository). 
    - Go to GitHub: https://github.com
    - Login to `Your GitHub Account`
    - Create a Repository called `DevSecOps-Realworld-CICD-Project`
    - Clone the Repository in the `Repository` directory/folder on your `local machine`
    - Download the code in in this repository `"Main branch"`: https://github.com/awanmbandi/realworld-microservice-project.git
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

3) Create An IAM Profile/Role For The Ansible Automation Engine (Dynamic Inventory)
- Create an EC2 Service Role in IAM with AmazonEC2FullAccess Privilege 
- Navigate to IAM
![IAM!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.20.44%20PM.png)
    - Click on `Roles`
    - Click on `Create Role`
    - Select `Service Role`
    - Use Case: Select `EC2`
    - Click on `Next` 
    - Attach Policy: `AmazonEC2FullAccess`
    - Click `Next` 
    - Role Name: `AWS-EC2FullAccess-Role`
    - Click `Create`

4) Jenkins CI
    - Create a Jenkins VM instance 
    - Name: `Jenkins-CI`
    - AMI: `Ubuntu 22.04`
    - Instance type: `t2.large`
    - Key pair: `Select` or `create a new keypair`
    - Security Group (Edit/Open): `All Traffic` to `0.0.0.0/0`
        - What we actually need: `80`, `8080`, `9100`, `3000`, `9090`, `9000` and `22` to `0.0.0.0/0`
    - Storage: Increase to `50 GB`
    - IAM instance profile: Select the `AWS-EC2FullAccess-Role`
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-microservice-project/blob/dev-sec-ops-cicd-pipeline-project-one/installations.sh
    - Launch Instance

4) SonarQube
    - Create a SonarQube VM instance 
    - Name: `SonarQube`
    - AMI: `Ubuntu 20.04`
    - Instance type: `t2.medium`
    - Key pair: `Select a keypair`
    - Security Group (Eit/Open): `9000, 9100` and `22 to 0.0.0.0/0`
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-nexus-sonarqube-jenkins-install/sonarqube-install.sh
    - Launch Instance

### 4A) Verify the Following Services are running in the Jenkins Instance
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

# Lastly confirm that the SonarQube container is running
docker ps | grep sonarqube:lts-community
```

### 4B) Deploy Your EKS Cluster Environment
- Confirm you're still logged into the `Jenkins-CI` Server
- Run the following commands to deploy the `EKS Cluster`
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
        - **Kubernetes Credentials**
        - **Kubernetes Client API**
        - **Kubernetes**
        - **Kubernetes Credentials Provider**
        - **Kubernetes :: Pipeline :: DevOps Steps**
        - **Slack Notification**
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

        ![JDKSetup!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdfbdasb.png)

        * Click on `Add installer`
        * Select `Install from adoptium.net` 
        * Version: **`jdk-17.0.8.1+1`**
    
    - **SonarQube Scanner** 
      - Click on `Add SonarQube Scanner` 
      - Enable: `Install automatically` 
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/dcsdsvsvd.png)
    
    - **NodeJS installations** 
      - Click on `Add NodeJS` 
      - Enable: `Install automatically` 
      - Version: Select `16.2.0`
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdvsvsd.png)

    - **Dependency-Check installations** 
      - Click on `Add Dependency-Check`
      - Click on `Add installer`
        - Select `Install from adoptium.net` 
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
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/sdvsvsd.png)
    
    - **Terraform Installation** 
      - Click on `Add Terraform` 
      - Disable/Uncheck: `Install automatically` 
        - NOTE: *Please Do Not Check The ``Install automatically`*
      - Install directory: provide `/usr/bin/`
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/ASFADAD.png)

4)  #### Credentials setup(SonarQube, Nexus, Ansible and Slack):  
    *BE AWARE THAT SINCE WE'RE USING CONTAINERS TO DEPLOY THE SONARQUBE CONTAINER, IF YOU STOP THE INSTANCE THE CONTAINER DIES*
    - Click on `Manage Jenkins` 
      - Click on `Credentials` 
      - Click on `Global` (unrestricted)
      - Click on `Add Credentials`
      1)  ##### SonarQube secret token (SonarQube-Token)
          - ###### Generating SonarQube secret token:
              - Login to your SonarQube Application (http://SonarServer-Sublic-IP:9000)
                - Default username: **`admin`** 
                - Default password: **`admin`**
             - Click on `Projects`
             - Click on `Create New Project`
                - Project display name: `NodeJS-WebApp-Project`
                - Display key: `NodeJS-WebApp-Project`
              - Click on `Set Up`
                - Click on `Locally` 
                - Token Name ``NodeJS-WebApp-SonarQube-Token``
                - **NOTE:** *Copy the TOKEN and SAVE somwhere on your NodePad*
              - Click on `Generate`
              - Click on `Continue`
              - Run analysis on your project: Select `Other (for JS, TS, Go, Python, PHP, ...)`
              - What is your OS?: Select `Linux`
              - `COPY` the Execute the Scanner and `SAVE` on your NodePad as well
          - ###### Store SonarQube Secret Token in Jenkins:
              - Navigate back to Jenkins http://JENKINS_PUBLIC_IP:8080
              - Click on `Manage Jenkins`
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
              - Kind: Secret text            
              - Secret: Place the Integration Token Credential ID (Note: Generate for slack setup)
              - ID: ``Slack-Credential``
              - Description: `slack-Credential`
              - Click on `Create`  

      3)  ##### DockerHub Credential (Username and Password)
          - ###### Login to Your DockerHub Account (You can create one if you don't have one)
              - Access DockerHub at: https://hub.docker.com/
              - Provide Username: `YOUR USERNAME`
              - Provide Username: `YOUR PASSWORD`
              - Click on `Sign In`

          - ###### DockerHub Credential (Username and Password)
	          - Click on ``Add Credentials``
	          - Kind: Username with password                  
	          - Username: ``YOUR USERNAME``
	          - Password: ``YOUR PASSWORD``
	          - ID: ``DockerHub-Credential``
	          - Description: `DockerHub-Credential`
	          - Click on `Create`   

      4)  ##### Kubernetes Cluster Credential (kubeconfig)
          - Click on ``Add Credentials``
          - Kind: Username with password          
          - Username: ``ansibleadmin``
          - Enable Treat username as secret
          - Password: ``ansibleadmin``
          - ID: ``Ansible-Credential``
          - Description: `Ansible-Credential`
          - Click on `Create`   
      ![SonarQubeServerSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-27%20at%202.10.40%20PM.png)