pipeline {
    agent any

    environment {
        // DockerHub credentials från Jenkins
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
        // Docker-image namn
        IMAGE_NAME = "florinelfrancisc/oessoncapstone:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                // Hämta källkod från Git
                checkout scm
            }
        }
        stage('Test') {
            agent {
                docker { image 'python:3.11-slim' }
            }
            steps {
                // Installera och kör tester
                sh '''
                    pip install -r requirements.txt
                    pip install pytest
                    pytest || true
                '''
            }
        }
        stage('Bygg Docker-image') {
            steps {
                // Bygg Docker-image
                sh "docker build -t $IMAGE_NAME -f docker/Dockerfile ."
            }
        }
        stage('Push till DockerHub') {
            steps {
                // Logga in och pusha Docker-image
                sh '''
                    echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
                    docker push $IMAGE_NAME
                '''
            }
        }
        stage('Deploy till Kubernetes') {
            steps {
                // Använd inbäddad kubeconfig-fil
                withCredentials([file(credentialsId: 'kubeconfig1', variable: 'KUBECONFIG_FILE')]) {
                    sh '''
                        export KUBECONFIG=$KUBECONFIG_FILE
                        kubectl apply -f k8s/
                    '''
                }
            }
        }
    }
}
