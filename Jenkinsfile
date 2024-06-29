def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
    'UNSTABLE': 'danger'
]
pipeline {
    agent any
    environment {
        SCANNER_HOME=tool 'SonarScanner'
        SNYK_HOME   = tool name: 'Snyk'
    }
    tools {
        snyk 'Snyk'
    }
    stages {
        // SonarQube SAST Code Analysis
        stage("SonarQube SAST Analysis"){
            steps{
                withSonarQubeEnv('Sonar-Server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=app-frontend-service \
                    -Dsonar.projectKey=app-frontend-service '''
                }
            }
        }
        // Providing Snyk Access
        stage('Authenticate & Authorize Snyk') {
            steps {
                withCredentials([string(credentialsId: 'Snyk-API-Token', variable: 'SNYK_TOKEN')]) {
                    sh "${SNYK_HOME}/snyk-linux auth $SNYK_TOKEN"
                }
            }
        }
        // Scan Service Dockerfile With Open Policy Agent (OPA)
        stage('OPA Dockerfile Vulnerability Scan') {
            steps {
                sh "docker run --rm -v ${WORKSPACE}:/project openpolicyagent/conftest test --policy docker-opa-security.rego Dockerfile || true"
            }
        }
        // Build and Tag Service Docker Image
        stage('Build & Tag Microservice Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'DockerHub-Credential', toolName: 'docker') {
                        sh "docker build -t awanmbandi/frontendservice:latest ."
                    }
                }
            }
        }
        // Execute SCA/Dependency Test on Service Docker Image
        stage('Snyk SCA Test | Dependencies') {
            steps {
                sh "${SNYK_HOME}/snyk-linux test --docker awanmbandi/frontendservice:latest || true" 
            }
        }
        // Push Service Image to DockerHub
        stage('Push Microservice Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'DockerHub-Credential', toolName: 'docker') {
                        sh "docker push awanmbandi/frontendservice:latest "
                    }
                }
            }
        }
        // Deploy to The Staging/Test Environment
        stage('Deploy Microservice To The Stage/Test Env'){
            steps{
                script{
                    withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'Kubernetes-Credential', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                       sh 'kubectl apply -f deploy-envs/test-env/deployment.yaml'
                       sh 'kubectl apply -f deploy-envs/test-env/nodeport-service.yaml'  //NodePort Service
                   }
                }
            }
        }
        // // Perform DAST Test on Application
        // stage('ZAP Dynamic Testing | DAST') {
        //     steps {
        //         sshagent(['OWASP-Zap-Credential']) {
        //             sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.59.158.38 "docker run -t zaproxy/zap-weekly zap-baseline.py -t http://18.216.48.123:30000/" || true'
        //                                                 //JENKINS_PUBLIC_IP                                                  //EKS_WORKER_NODE_IP_ADDRESS:30000
        //         }
        //     }
        // }
        // // Production Deployment Approval
        // stage('Approve Prod Deployment') {
        //     steps {
        //             input('Do you want to proceed?')
        //     }
        // }
        // // // Deploy to The Production Environment
        // stage('Deploy Microservice To The Prod Env'){
        //     steps{
        //         script{
        //             withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'Kubernetes-Credential', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
        //                sh 'kubectl apply -f deploy-envs/prod-env/deployment.yaml'
        //                sh 'kubectl apply -f deploy-envs/prod-env/loadbalancer-service.yaml'  //LoadBalancer Service
        //             }
        //         }
        //     }
        // }
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
