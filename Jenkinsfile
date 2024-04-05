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
                    // Initialize a variable to keep track of the test status
                    def testStatus = 1
                    // Initialize a counter for the number of attempts
                    def attempts = 0
                    // Run the test in a loop until it succeeds or the maximum number of attempts is reached
                    while (testStatus != 0 && attempts < 10) {
                        // Perform an HTTP GET request to the application
                        testStatus = sh(script: 'curl -f http://localhost:8081/ping || echo $?', returnStatus: true)
                        if (testStatus != 0) {
                            // If the test failed, wait for 30 seconds before trying again
                            sleep 30
                        }
                        // Increment the number of attempts
                        attempts++
                    }
                    // If the test didn't succeed after the maximum number of attempts, fail the job
                    if (testStatus != 0) {
                        error('Smoke test failed after 10 attempts')
                    }
                }
            }
        }
    }
}
