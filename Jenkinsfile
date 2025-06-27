pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("my-php-nginx-app")
                }
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker stop php-nginx-container || true'
                sh 'docker rm php-nginx-container || true'
                sh 'docker run -d -p 8081:80 --name php-nginx-container my-php-nginx-app'
            }
        }
    }
}