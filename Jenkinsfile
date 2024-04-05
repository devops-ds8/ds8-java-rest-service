pipeline {
    agent any

    stages {        
         stage('Ping Test') {
            steps {
                /*script {
                    // Perform an HTTP GET request to the /ping endpoint and store the result in a variable
                    def pingResult = sh(script: 'curl -f http://localhost:8081/ping || true', returnStdout: true).trim()
                    // Display the result
                    echo "Ping result: ${pingResult}"
                     (!pingResult.contains('{}')) {
                        error("Ping result does not contain '{}': ${pingResult}")
                    }
                }*/

                script {
                    // Initialize a counter for the number of attempts
                    def attempts = 0
                    // Run the test in a loop until it succeeds or the maximum number of attempts is reached
                    while (attempts < 5) {
                        echo "Attemps: ${attempts}"
                        // Perform an HTTP GET request to the application and get the status code
                        //def pingResult = sh(script: 'curl -f http://localhost:8081/ping || true', returnStdout: true).trim()
                        //echo "Ping result: ${pingResult}"
                        // Log a message with the status code
                        //echo "Smoke test status code: ${testStatus}"
                        //if (!pingResult.contains('{}')) {
                            // If the test failed, wait for 10 seconds before trying again
                          //  sleep 10
                        //} else {
                            // If the test succeeded, break the loop
                          //  break
                        //}
                        // Increment the number of attempts
                        attempts++
                            
                    }
                    // If the test didn't succeed after the maximum number of attempts, fail the job
                    if (attempts >= 5) {
                        error('Smoke test failed after 5 attempts')
                    }
                }
                
            }
        }
        
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

        /*stage('Run Docker Image') {
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
        }*/
    }
}
