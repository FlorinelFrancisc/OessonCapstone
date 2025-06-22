# OessonCapstone

A Secure, Automated, Dockerized Python Flask Microservice with Kubernetes, Monitoring, and CI/CD

---

## Project Overview

OessonCapstone is a Python Flask microservice project demonstrating **DevOps best practices**:

- **Containerized with Docker** (security-hardened, non-root user)
- **Deployed to Kubernetes** (with declarative YAML, resource limits, strict security, and probes)
- **Automated with Terraform, Ansible, and Jenkins** (end-to-end provisioning, configuration, deployment, and monitoring)
- **Monitored with Prometheus and Grafana** (Helm-based, with prebuilt dashboards)
- **Uses GitHub Actions & Jenkins** for CI/CD

---

## Features

- Flask web service (`/` returns "Hello, World!")
- Runs on port 8080
- Dockerfile uses non-root user (`UID 1001`)
- Kubernetes deployment in a secure custom namespace (`microservices`)
- Liveness & readiness probes, resource limits, strict security context
- Uses **ConfigMap** and **Secret** for environment variables and API keys
- Fully declarative infrastructure as code:
  - **Terraform** (AWS VPC, EC2, security groups, subnets)
  - **Ansible** (provisions Jenkins, Docker, K8s, Helm)
  - **Helm** (installs Prometheus + Grafana monitoring stack)
- **ServiceMonitor** resources to collect app metrics
- **Grafana dashboards** pre-configured for CPU, memory, HTTP request rate
- Automated CI/CD pipeline via Jenkins (`cd-pipeline/Jenkinsfile`)
- All YAMLs & IaC scripts are organized by function

---

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
│ ├── service.yaml
│ └── servicemonitor.yaml
├── infra/
│ └── terraform/
│ ├── main.tf
│ └── variables.tf
├── ansible/
│ └── playbooks/
│ └── [your-playbooks].yml
├── monitoring/
│ └── [Helm values/configs]
├── cd-pipeline/
│ └── Jenkinsfile
└── requirements.txt

---

## Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop)
- [Git](https://git-scm.com/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/)
- [Terraform](https://developer.hashicorp.com/terraform)
- [Ansible](https://www.ansible.com/)
- AWS account (for infrastructure)
- Jenkins server (can be installed via Ansible)
- Kubernetes cluster (e.g., minikube, EKS, etc.)

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/FlorinelFrancisc/OessonCapstone.git
cd OessonCapstone
```

2. Provision Infrastructure (AWS)
   cd infra/terraform
   terraform init
   terraform apply

# Outputs will include public IPs for Jenkins and K8s nodes

3. Configure & Install Dependencies (via Ansible)

# Example command (adjust inventory and playbook as needed)

ansible-playbook -i inventory.ini ansible/playbooks/setup-all.yml

4. Build and Push Docker Image
   docker build -t florinelfrancisc/oessoncapstone:1.0 -f docker/Dockerfile .
   docker push florinelfrancisc/oessoncapstone:1.0

5. Deploy to Kubernetes
   kubectl apply -f k8s/namespace.yaml
   kubectl apply -f k8s/configmap.yaml
   kubectl apply -f k8s/secret.yaml
   kubectl apply -f k8s/resourcequota.yaml
   kubectl apply -f k8s/deployment.yaml
   kubectl apply -f k8s/service.yaml
   kubectl apply -f k8s/servicemonitor.yaml # for monitoring

6. Set Up Monitoring (Prometheus & Grafana via Helm)
   kubectl create namespace monitoring
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm repo add grafana https://grafana.github.io/helm-charts
   helm repo update
   helm install monitoring-prometheus prometheus-community/kube-prometheus-stack -n monitoring
   helm install monitoring-grafana grafana/grafana -n monitoring --set adminPassword=admin --set service.type=NodePort --set service.nodePort=30000
   Access Grafana:

Get the URL: minikube service monitoring-grafana -n monitoring

7. Automated CI/CD Pipeline
   Jenkins pipeline is defined in cd-pipeline/Jenkinsfile

Stages: Checkout → Test → Build Docker → Push → Deploy to K8s

Monitors deployment and service health

8. Access the Service
   kubectl port-forward -n microservices svc/oessoncapstone-service 8080:80

# Then browse to http://localhost:8080

Clean Up

To destroy AWS resources:
cd infra/terraform && terraform destroy

To stop all EC2 instances (from terminal):
aws ec2 terminate-instances --instance-ids <id1> <id2> ...
