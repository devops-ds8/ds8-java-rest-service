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
                    // Perform an HTTP GET request to the /ping endpoint and store the result in a variable
                    def pingResult = sh(script: 'curl -S http://localhost:8081/ping 2>&1', returnStdout: true).trim()
                    // Display the result
                    echo "Ping result: ${pingResult}"
                }
            }
        }
    }
}
