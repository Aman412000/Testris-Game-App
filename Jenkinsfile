pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'DockerHub' // Replace with your Jenkins credentials ID for Docker
        DOCKER_IMAGE = 'amanjadhao71/tetris-game' // Replace with your Docker image name
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Aman412000/Tetris-Game.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(env.DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.example.com', env.DOCKER_CREDENTIALS_ID) {
                        docker.image(env.DOCKER_IMAGE).push()
                    }
                }
            }
        }
    }
}
