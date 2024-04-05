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
                    // Stop the Docker container if it's running
                    sh '/usr/local/bin/docker stop ds8jrest || true'
                    // Remove the Docker container
                    sh '/usr/local/bin/docker rm ds8jrest || true'
                    // Build the Docker image
                    sh '/usr/local/bin/docker build -t ds8jrest .'
                }
            }
        }

        stage('Run Docker Image') {
            steps {
                script {
                    // Run the Docker image
                    sh '/usr/local/bin/docker run -d -p 8081:8081 --name ds8jrest ds8jrest'
                    sleep 30
                }
            }
        }

        stage('Mini Smoke Test') {
            steps {
                script {
                    // Perform an HTTP GET request to the application
                    sh 'curl -f http://localhost:8081/ping'
                }
            }
        }
    }
}
