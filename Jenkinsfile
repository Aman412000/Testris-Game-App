pipeline {
    agent any
     
    environment {
        registryName = "amanlabacr"
        registryCredential = 'acrcred'
        dockerImage = 'tetris-game-app:latest' // Define your Docker image name
        registryUrl = 'amanlabacr.azurecr.io'
        azureCredentialsId = 'aks-sp'
        aksClusterName = 'tetris-deployment'
        aksResourceGroup = 'aman'
        deploymentName = 'tetris-game-deployment'
    }
   
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Aman412000/Testris-Game-App.git'
            }
        }
        
        stage ('Build Docker image') {
            steps {
                script {
                    // Build Docker image with specified name
                    dockerImage = docker.build "${env.registryUrl}/${env.dockerImage}"
                }
            }
        }
       
        stage('Upload Image to ACR') {
            steps {
                script {
                    docker.withRegistry("https://${registryUrl}", registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                script {
                    azureAKSUpdate(credentialsId: azureCredentialsId, resourceGroup: aksResourceGroup, kubernetesCluster: aksClusterName, namespace: 'default', deploymentName: deploymentName, dockerImage: "${env.registryUrl}/${env.dockerImage}")
                }
            }
        }
    }
}
