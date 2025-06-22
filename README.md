# OessonCapstone

A Secure Dockerized Python Flask Microservice, Deployed on Kubernetes

## Project Overview

OessonCapstone is a simple Python Flask microservice, containerized using Docker with security best practices and deployed to a Kubernetes cluster using declarative manifests.

This project demonstrates:

- Secure Docker build (non-root user, minimal base image)
- Declarative Kubernetes configuration with resource limits, probes, and security context
- Use of ConfigMap and Secret for environment variables

## Features

- Flask web service (`/` route returns "Hello, World!")
- Runs on port 8080
- Dockerfile uses non-root user (`UID 1001`)
- Kubernetes deployment in a custom namespace with strict security context
- Liveness and readiness probes for health checking
- Resource quotas and limits
- All Kubernetes YAMLs are organized in `k8s/` directory

## Directory Structure

OessonCapstone/
│
├── app/
│ └── app.py
├── docker/
│ └── Dockerfile
├── k8s/
│ ├── configmap.yaml
│ ├── deployment.yaml
│ ├── namespace.yaml
│ ├── resourcequota.yaml
│ ├── secret.yaml
│ └── service.yaml
└── requirements.txt

## Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop)
- [Git](https://git-scm.com/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Access to a Kubernetes cluster (minikube, Docker Desktop, etc.)

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/FlorinelFrancisc/OessonCapstone.git
cd OessonCapstone
```

## 2. Build and Push Docker Image

```bash
docker build -t florinelfrancisc/oessoncapstone:1.0 -f docker/Dockerfile .
docker push florinelfrancisc/oessoncapstone:1.0
```

3. Deploy to Kubernetes

kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secret.yaml
kubectl apply -f k8s/resourcequota.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

4. Access the Service

kubectl port-forward -n microservices svc/oessoncapstone-service 8080:80
