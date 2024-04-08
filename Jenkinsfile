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
            when {
        anyOf {
            branch 'main'
            branch 'develop'
        }
    }
            steps {
                script {
                def containerName = 'ds8jrest'
                def hostPort = '8081'    
                if (env.BRANCH_NAME == 'develop') {
                    containerName = "${containerName}-staging"
                    hostPort = '8082'
                }
                // Run the Docker image
                sh "/usr/local/bin/docker run -d -p 8081:8081 --name ds8jrest ds8jrest"    
                //sh "/usr/local/bin/docker run -d -p ${port}:8081 --name ${containerName} ds8jrest"
                sleep 30
                }
            }
        }

        stage('Mini Smoke Test') {
            when {
              branch 'main'
            }
            steps {
                script {
                    // Initialize a counter for the number of attempts
                    def attempts = 0
                    // Run the test in a loop until it succeeds or the maximum number of attempts is reached
                    while (attempts < 20) {
                        echo "Attemps: ${attempts}"
                        // Perform an HTTP GET request to the application and get the status code
                        def pingResult = sh(script: 'curl -f http://localhost:8081/ping || true', returnStdout: true).trim()
                        echo "Ping result: ${pingResult}"
                        if (!pingResult.contains('{}')) {
                            // If the test failed, wait for 10 seconds before trying again
                            sleep 15
                        } else {
                            // If the test succeeded, break the loop
                            break
                        }
                        // Increment the number of attempts
                        attempts++
                            
                    }
                    // If the test didn't succeed after the maximum number of attempts, fail the job
                    if (attempts >= 20) {
                        error('Smoke test failed after 20 attempts')
                    }
                }
                
            }
        }
    }
}
