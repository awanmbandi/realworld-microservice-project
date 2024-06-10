pipeline {
    agent any

    stages {
        // Providing Snyk Access
        stage('Authenticate Snyk') {
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
        stage('Snyk Test') {
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
    }
}
