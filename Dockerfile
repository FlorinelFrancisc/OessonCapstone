FROM jenkins/jenkins:lts

USER root

# Install docker (if needed)
RUN apt-get update && apt-get install -y docker.io curl

# Install kubectl (latest stable)
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

USER jenkins
