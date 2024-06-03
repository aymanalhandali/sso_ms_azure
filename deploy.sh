#!/bin/bash

# Update the system
sudo apt-get update

# Install Python 3.12
sudo apt install -y python3.12

# Install system dependencies
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Check Docker version
docker --version

# Add user to Docker group and restart Docker
sudo usermod -aG docker $USER

sudo systemctl restart docker

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Check Docker Compose version
docker-compose --version

# Navigate to the directory containing your docker-compose.yml
# Replace /path/to/your/project with the actual path
cd /path/to/your/project

# Build and run the Docker containers
docker-compose up --build

# Check the status of the containers
docker-compose ps