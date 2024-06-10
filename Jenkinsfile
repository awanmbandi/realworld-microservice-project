pipeline {
    agent any

    stages {
        // SonarQube SAST Code Analysis
        stage("SonarQube SAST Analysis"){
            steps{
                withSonarQubeEnv('Sonar-Server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=NodeJS-WebApp-Project \
                    -Dsonar.projectKey=NodeJS-WebApp-Project '''
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
        stage('Dockerfile Vulnerability Scan') {
            steps {
                sh "docker run --rm -v $(pwd):/project openpolicyagent/conftest test --policy docker-opa-security.rego Dockerfile || true"
            }
        }
        stage('Build & Tag Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                        sh "docker build -t adijaiswal/adservice:latest ."
                    }
                }
            }
        }
        stage('Snyk SCA Test') { 
            steps {
                sh "snyk test --docker adijaiswal/adservice:latest" 
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                        sh "docker push adijaiswal/adservice:latest "
                    }
                }
            }
        }
        // stage('ZAP Dynamic Testing | DAST') {
        //     steps {
        //         sshagent(['OWASP-Zap-Credential']) {
        //             sh 'ssh -o StrictHostKeyChecking=no ubuntu@3.15.151.251 "docker run -t zaproxy/zap-weekly zap-baseline.py -t http://34.68.212.20:8080/" || true'
        //                                                 //JENKINS_PUBLIC_IP                                                      //EKS_WORKER_NODE_IP_ADDRESS:3000
        //         }
        //     }
        // }
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
}
