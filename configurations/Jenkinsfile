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
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Redit-NodeJs-App \
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
                       sh 'kubectl apply -f k8s-manifests/test-env/test-namespace.yml'
                       sh 'kubectl apply -f k8s-manifests/test-env/deployment.yml'
                       sh 'kubectl apply -f k8s-manifests/test-env/service.yml'  //NodePort Service
                  }
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
                       sh 'kubectl apply -f k8s-manifests/prod-env/deployment.yml'
                       sh 'kubectl apply -f k8s-manifests/prod-env/service.yml'  //LoadBalancer Service
                       sh 'kubectl apply -f k8s-manifests/prod-env/ingress.yml'
                    }
                }
            }
        }
        stage("CIS Cluster Compliance Report"){ 
            steps{
                sh "trivy k8s cluster --compliance=k8s-cis --report summary > trivy_cis_compliace_report.txt" 
            }
            post {
                success {
                    echo 'CIS compliance benchmark test completed successfully.' 
                }
                failure {
                    echo 'CIS compliance benchmark test failed.'
                }
            }
        }
        stage("NSA Cluster Compliance Report"){ 
            steps{
                sh "trivy k8s cluster --compliance=k8s-nsa --report all > trivy_nsa_compliace_report.txt"
            }
            post {
                success {
                    echo 'NSA compliance benchmark test completed successfully.'
                }
                failure {
                    echo 'NSA compliance benchmark test failed.'
                }
            }
        }
    }
}