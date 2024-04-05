pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                sh './gradlew clean test'
            }
        }
        stage('Build') {
            steps {
                sh './gradlew clean build'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build('ds8jrest')
                }
            }
        }
/*
        stage('Run Docker Image') {
            steps {
                script {
                    // Run the Docker image
                    sh 'docker run -d -p 8081:8081 --name ds8jrest ds8jrest'
                }
            }
        }*/
    }
}
