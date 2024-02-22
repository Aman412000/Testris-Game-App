pipeline {
    agent any
    stages {
        stage('git checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/ycetindil/Jenkins-Tetris.git']])
            }
        }
        stage('build docker image') {
            steps {
                sh 'docker build -t ycetindil.azurecr.io/tetris .'
            }
        }
        stage('push image to ACR') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'ACR', passwordVariable: 'password', usernameVariable: 'username')]) {
                    sh 'docker login -u ${username} -p ${password} ycetindil.azurecr.io'
                    sh 'docker push ycetindil.azurecr.io/tetris'
                }
            }
        }
        stage('deploy to AKS') {
            steps {
                withCredentials([azureServicePrincipal('AZURE_SERVICE_PRINCIPAL')]) {
                    sh 'az login --service-principal -u ${AZURE_CLIENT_ID} -p ${AZURE_CLIENT_SECRET} --tenant ${AZURE_TENANT_ID}'
                }
                sh 'kubectl set image deployment/tetris-deployment tetris=ycetindil.azurecr.io/tetris:latest'
                // Replace 'tetris-deployment' with your actual deployment name in AKS
            }
        }
    }
}
