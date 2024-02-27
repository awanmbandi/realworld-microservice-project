# CI/CD Pipeline Projects | Microservice Applications

![NicroserviceCICDProjectArch!](https://lucid.app/publicSegments/view/adb92915-5e28-4871-acf3-0f3a585387f7/image.png) 

# Kubernetes CI/CD Pipeline Deployment Project Runbook
1) Create a GitHub Repository with the name `Jenkins-Realworld-CICD-Project` and push the code in this branch(main) to 
    your remote repository (your newly created repository). 
    - Go to GitHub: https://github.com
    - Login to `Your GitHub Account`
    - Create a Repository called `Jenkins-Realworld-CICD-Project`
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

3) Jenkins/Maven
    - Create a Jenkins VM instance 
    - Name: `Jenkins/Maven/Ansible`
    - AMI: `Amazon Linux 2`
    - Instance type: `t2.medium`
    - Key pair: `Select` or `create a new keypair`
    - Security Group (Edit/Open): `8080, 9100` and `22 to 0.0.0.0/0`
    - IAM instance profile: Select the `AWS-EC2FullAccess-Role`
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-nexus-sonarqube-jenkins-install/jenkins-install.sh
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

5) JFrog Artifactory
    - Create a Nexus VM instance 
    - Name: `JFrog-Artifactory`
    - AMI: `Amazon Linux 2`
    - Instance type: `t2.medium`
    - Key pair: `Select a keypair`
    - Security Group (Eit/Open): `8081, 8082` and `22 to 0.0.0.0/0`
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-nexus-sonarqube-jenkins-install/nexus-install.sh
    - Launch Instance



## CONFIGURE TOOLS
### JFrog Artifactory
  - Navigate to http://JFROG_PUBLIC_IP:8082
  - Default username: `admin`
  - Default password: `password`
  - New password: `Admin2024`  *Password must meet the specified criteria*
  - Select Base URL: http://YOUR_JFROG_PUBLIC_IP:8082
  - Configure Default Proxy: `Skip`
  - Create Repositories: Select `Maven` and click `Next`
  - Click `Finish`

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
        - **Artifactory**
        - **Maven Integration**
        - **Pipeline Maven Integration**
        - **Maven Release Plug-In**
        - **Build Timestamp (Needed for Artifact versioning)**
    - Click on `Install`
    - Once all plugins are installed
    - Select/Check the Box **Restart Jenkins when installation is complete and no jobs are running**

4)  #### Credentials setup(SonarQube, Nexus, Ansible and Slack):
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
                - Project key: `Webapp-Project`
                - Display name: `Webapp-Project`
              - Click on `Set Up`
              - Generate a Tokens: Provide Name ``Webapp-SonarQube-Token``
              - Click on `Generate`
              - Click on `Continue`
              - Run analysis on your project: Select `Java`
              - Build technology: Select `Maven`
              - COPY the `TOKEN`
          - ###### Store SonarQube Secret Token in Jenkins:
              - Navigate back to Jenkins
              - Click on ``Add Credentials``
              - Kind: Secret text!! 
              - Secret: `Paste the SonarQube token` value that we have created on the SonarQube server
              - ID: ``SonarQube-Token``
              - Description: `SonarQube-Token`
              - Click on Create

    3)  ##### JFrog Artifactory Credentials (Username and Password)
          - ###### JFrog credentials (username & password)
	          - Click on ``Add Credentials``
	          - Kind: Username with password                  
	          - Username: ``admin``
	          - Password: ``Admin2024``
	          - ID: ``JFrog-Credential``
	          - Description: `JFrog-Credential`
	          - Click on `Create`

3)  #### Global tools configuration:
    - Click on Manage Jenkins -->> Global Tool Configuration
    ![JDKSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/sdsdsdsdsd.png)

    - **Maven** 
      - Click on `Add Maven` 
      - Disable/Uncheck **`Install automatically`**  
      * Name: **`maven`**
      - Click on `SAVE`
      ![MavenSetup!](https://github.com/awanmbandi/realworld-microservice-project/blob/zdocs/images/agasdgbsfdb.png)

    
3)  #### Configure System:
    #### 3.1) Configure SonarQube
    - Click on ``Manage Jenkins`` 
      - Click on ``Configure System`` and navigate to the `SonarQube Servers` section
      - Click on `Add SonarQube`
      - Server URL: http://YOUR_SONARQUBE_PRIVATE_IP:9000
      - Server authentication token: Select `SonarQube-Token`
      ![SonarQubeServerSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2010.13.39%20AM.png)

3)  #### Configure System:
    #### 3.1) Configure JFrog Artifactory
    - Click on ``Manage Jenkins`` 
      - Click on ``Configure System`` and navigate to the `SonarQube Servers` section
      - Click on `Add JFrog Platform Instances`
      - Instance ID: `jfrog`
      - JFrog Platform URL: http://YOUR_SONARQUBE_PRIVATE_IP:8082/artifactory
      - Server authentication token: Select `SonarQube-Token`
      ![SonarQubeServerSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2010.13.39%20AM.png)





