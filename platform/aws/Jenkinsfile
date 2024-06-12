def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
    'UNSTABLE': 'danger'
]
pipeline {
    agent any
    stages {
        // Checkout To The Service Branch
        stage('Checkout To Mcroservice Branch'){
            steps{
                git branch: 'app-cart-service', url: 'https://github.com/awanmbandi/realworld-microservice-project.git'
            }
        }
        // // Deploy to The Staging/Test Environment
        // stage('Deploy Microservice To The Stage/Test Env'){
        //     steps{
        //         script{
        //             withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'Kubernetes-Credential', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
        //                sh 'kubectl apply -f deploy-envs/test-env/test-namespace.yaml'
        //                sh 'kubectl apply -f deploy-envs/test-env/deployment.yaml'
        //                sh 'kubectl apply -f deploy-envs/test-env/service.yaml'  //ClusterIP Service
        //            }
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
        //                sh 'kubectl apply -f deploy-envs/prod-env/prod-namespace.yaml'
        //                sh 'kubectl apply -f deploy-envs/prod-env/deployment.yaml'
        //                sh 'kubectl apply -f deploy-envs/prod-env/service.yaml'  //ClusterIP Service
        //             }
        //         }
        //     }
        // }
    }
    post {
    always {
        echo 'Slack Notifications.'
        slackSend channel: '#devops', //update and provide your channel name
        color: COLOR_MAP[currentBuild.currentResult],
        message: "*${currentBuild.currentResult}:* Job Name '${env.JOB_NAME}' build ${env.BUILD_NUMBER} \n Build Timestamp: ${env.BUILD_TIMESTAMP} \n Project Workspace: ${env.WORKSPACE} \n More info at: ${env.BUILD_URL}"
    }
  }
}