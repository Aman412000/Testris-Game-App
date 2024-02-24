pipeline {
    agent any
     
    environment {
        registryName = "amanlabacr"
        registryCredential = 'acrcred'
        dockerImage = 'tetris-game-app:latest' // Define your Docker image name
        registryUrl = 'amanlabacr.azurecr.io'
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
    }
}
