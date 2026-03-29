pipeline {
    agent any

    environment {
        // You should configure a credential in Jenkins with ID 'docker-credentials'
        DOCKER_REGISTRY_USER = 'kalyaneswarm'
        IMAGE_TAG = 'v1.0'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Login') {
            steps {
                // Ensure you have a Username with password credential created in Jenkins named 'docker-credentials'
                withCredentials([usernamePassword(credentialsId: 'docker-credentials', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                }
            }
        }

        stage('Build & Push MySQL Image') {
            steps {
                dir('mysql') {
                    sh "docker build -t ${DOCKER_REGISTRY_USER}/mysql:${IMAGE_TAG} ."
                    sh "docker push ${DOCKER_REGISTRY_USER}/mysql:${IMAGE_TAG}"
                }
            }
        }

        stage('Build & Push Backend Image') {
            steps {
                dir('backend') {
                    sh "docker build -t ${DOCKER_REGISTRY_USER}/backend:${IMAGE_TAG} ."
                    sh "docker push ${DOCKER_REGISTRY_USER}/backend:${IMAGE_TAG}"
                }
            }
        }

        stage('Build & Push Frontend Image') {
            steps {
                dir('frontend') {
                    sh "docker build -t ${DOCKER_REGISTRY_USER}/frontend:${IMAGE_TAG} ."
                    sh "docker push ${DOCKER_REGISTRY_USER}/frontend:${IMAGE_TAG}"
                }
            }
        }

        stage('Logout') {
            steps {
                sh "docker logout"
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
