# sso_ms_azure
ms azure sso configuration for any application in an organization


## Deployment to EC2 instance (Ubuntu 24.04-amd64):
- Instantiate instance in EC2 console - snap chat of my instance type
```
ubuntu-noble-24.04-amd64-server-20240423
```
- Update linux system
```sudo apt-get update```

- Install python 3.12
```sudo apt install python3.12```

- Install some system dependencies
```
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```
- Install Docker
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io

```

- Check version
```
docker --version

```

- Add user group and re-start server
```
sudo usermod -aG docker $USER

sudo systemctl restart docker
```
- Install Docker compose
```
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

- Check version
```
docker-compose --version
```




- Finally Run container
```
docker-compose up --build

```

- check on container
```docker-compose ps
```
