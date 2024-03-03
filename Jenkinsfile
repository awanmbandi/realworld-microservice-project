pipeline{
    agent any
    tools{
        jdk 'JDK17'
        nodejs 'NodeJS16'
    }
    environment {
        SCANNER_HOME=tool 'SonarScanner'
    }
    stages {
        stage('clean workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Checkout from Git'){
            steps{
                git branch: 'dev-sec-ops-cicd-pipeline-project-one', url: 'https://github.com/awanmbandi/realworld-microservice-project.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh "npm install"
            }
        }
        stage("Sonarqube Analysis "){
            steps{
                withSonarQubeEnv('SonarScanner') {
                    sh ''' $SCANNER_HOME/bin/SonarScanner -Dsonar.projectName=Redit-NodeJs-App \
                    -Dsonar.projectKey=Redit-NodeJs-App '''
                }
            }
        }
        stage("SonarQube GateKeeper"){
           steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'SonarQube-Credential'
                }
            }
        }
        stage('OWASP FS SCAN') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'OWASP-Dependency-Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage('TRIVY FS SCAN') {
            steps {
                sh "trivy fs . > trivyfs.txt"
            }
        }
        stage("Docker Build & Push"){
            steps{
                script{
                   withDockerRegistry(credentialsId: 'DockerHub-Credential', toolName: 'Docker'){
                       sh "docker build -t reddit ."
                       sh "docker tag reddit awanmbandi/reddit:latest "
                       sh "docker push awanmbandi/reddit:latest "
                    }
                }
            }
        }
        stage("TRIVY"){
            steps{
                sh "trivy image awanmbandi/reddit:latest > trivyimageanalysisreport.txt"
            }
        }
        stage('Deploy to container'){
            steps{
                sh 'docker run -d --name reddit -p 3000:3000 awanmbandi/reddit:latest'
            }
        }
    }
}