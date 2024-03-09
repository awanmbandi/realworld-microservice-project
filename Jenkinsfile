def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
    'UNSTABLE': 'danger'
]
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
                withSonarQubeEnv('Sonar-Server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=NodeJS-WebApp-Project \
                    -Dsonar.projectKey=NodeJS-WebApp-Project '''
                }
            }
        }
        stage('SonarQube GateKeeper') {
            steps {
                timeout(time : 1, unit : 'HOURS'){
                waitForQualityGate abortPipeline: true, credentialsId: 'SonarQube-Credential'
                }
            }
        }
        stage('OWASP Dependency Check') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'OWASP-Dependency-Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage('Trivy FS Scan') {
            steps {
                sh "trivy fs . > trivy_fs_test_report.txt"
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
        stage("Trivy App Image Scan"){
            steps{
                sh "trivy image awanmbandi/reddit:latest > trivy_image_analysis_report.txt"
            }
        }
        stage('Deploy to K8S Stage Environment'){
            steps{
                script{
                    withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'Kubernetes-Credential', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                       sh 'kubectl apply -f deploy-configs/test-env/test-namespace.yml'
                       sh 'kubectl apply -f deploy-configs/test-env/deployment.yml'
                       sh 'kubectl apply -f deploy-configs/test-env/service.yml'  //NodePort Service
                  }
                }
            }
        }
        stage('ZAP Dynamic Testing | DAST') {
            steps {
                sshagent(['OWASP-Zap-Credential']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@3.15.151.251 "docker run -t owasp/zap2docker-stable zap-baseline.py -t http://18.188.161.121:30000/" || true'
                                                        //JENKINS_PUBLIC_IP                                                      //EKS_WORKER_NODE_IP_ADDRESS:3000
                }
            }
        }
        stage('Approve Prod Deployment') {
        steps {
                input('Do you want to proceed?')
            }
        }
        stage('Deploy to K8S Prod Environment'){
            steps{
                script{
                    withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'Kubernetes-Credential', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                       sh 'kubectl apply -f deploy-configs/prod-env/deployment.yml'
                       sh 'kubectl apply -f deploy-configs/prod-env/service.yml'  //LoadBalancer Service
                       sh 'kubectl apply -f deploy-configs/prod-env/ingress.yml'
                    }
                }
            }
        }
    }
    post {
    always {
        echo 'Slack Notifications.'
        slackSend channel: '#general', //update and provide your channel name
        color: COLOR_MAP[currentBuild.currentResult],
        message: "*${currentBuild.currentResult}:* Job Name '${env.JOB_NAME}' build ${env.BUILD_NUMBER} \n Build Timestamp: ${env.BUILD_TIMESTAMP} \n Project Workspace: ${env.WORKSPACE} \n More info at: ${env.BUILD_URL}"
    }
  }
}
