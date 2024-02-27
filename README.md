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
    - Security Group (Eit/Open): `8081, 9100` and `22 to 0.0.0.0/0`
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-nexus-sonarqube-jenkins-install/nexus-install.sh
    - Launch Instance



## CONFIGURE TOOLS
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

3)  #### Global tools configuration:
    - Click on Manage Jenkins -->> Global Tool Configuration
    ![JDKSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/sdsdsdsdsd.png)

    - **Maven** 
      - Click on `Add Maven` 
      - Enable **`Install automatically`** is enabled 
      * Name: **`maven`**
      * Version: Keep the default version as it is to latest
      - Click on `SAVE`
      ![MavenSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%209.44.14%20AM.png)

    - **JDK** 
        - Click on `Add JDK` -->> Make sure **Install automatically** is enabled 
        
        **Note:** By default the **Install Oracle Java SE Development Kit from the website** make sure to close that option by clicking on the image as shown below.

        ![JDKSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/dsdsdsdsdsd.png)

        * Click on `Add installer`
        * Select `Extract *.zip/*.tar.gz` 
        * Name: **`localJdk`**
        * Download URL for binary archive: **https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz**
        * Subdirectory of extracted archive: **`jdk-11.0.1`**
    
    - **SonarQube Scanner** 
      - Click on `Add SonarQube Scanner` 
      - Enable: `Install automatically` (Optional)
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%209.35.20%20AM.png)
