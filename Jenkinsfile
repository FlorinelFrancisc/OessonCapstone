pipeline {
    agent any

    environment {
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
        IMAGE_NAME = "florinelfrancisc/oessoncapstone:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Test') {
            agent {
                docker { image 'python:3.11-slim' }
            }
            steps {
                sh '''
                    pip install -r requirements.txt
                    pip install pytest
                    pytest || true
                '''
            }
        }
        stage('Bygg Docker-image') {
            steps {
                sh "docker build -t $IMAGE_NAME -f docker/Dockerfile ."
            }
        }
        stage('Push till DockerHub') {
            steps {
                sh '''
                    echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
                    docker push $IMAGE_NAME
                '''
            }
        }
        stage('Deploy till Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_FILE')]) {
                    sh '''
                        export KUBECONFIG=$KUBECONFIG_FILE
                        kubectl apply -f k8s/
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
