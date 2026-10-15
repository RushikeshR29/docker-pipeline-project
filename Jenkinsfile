pipeline {
    agent any

    environment {
        IMAGE_NAME     = 'jenkins-docker-demo'
        CONTAINER_NAME = 'jenkins-docker-demo-container'
        HOST_PORT      = '8081'
    }

    stages {
        stage('Checkout') {
            steps {
                // Pulls the code from the repo configured in the Jenkins job
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} -t ${IMAGE_NAME}:latest .'
            }
        }

        stage('Stop Old Container') {
            steps {
                // "|| true" so the build doesn't fail on the first run
                sh 'docker stop ${CONTAINER_NAME} || true'
                sh 'docker rm ${CONTAINER_NAME} || true'
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run -d --name ${CONTAINER_NAME} -p ${HOST_PORT}:80 ${IMAGE_NAME}:latest'
            }
        }

        stage('Verify') {
            steps {
                sh 'sleep 3'
                sh 'curl -f http://localhost:${HOST_PORT} || exit 1'
            }
        }
    }

    post {
        success {
            echo "Deployed! Open http://<jenkins-host>:${HOST_PORT}"
        }
        failure {
            echo 'Pipeline failed. Check the console output.'
        }
    }
}
