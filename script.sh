#!/bin/bash
# Function to check for errors
check_error() {
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "Error: $1"
        exit $exit_code
    fi
}
#################  ##########################
# Update package repositories
sudo yum update -y
check_error "Failed to update package repositories"

#################  ##########################
# Install Git
sudo yum install git -y
check_error "Failed to install Git"

#################  ##########################
# Install Maven
sudo yum install -y maven
check_error "Failed to install Maven"

#################  ##########################
# Install Java (Amazon Corretto)
sudo yum install -y java-11-amazon-corretto-headless
check_error "Failed to install Java"

#################  ##########################
# Install necessary packages
yum update -y
yum install -y httpd

# Start Apache web server
systemctl start httpd
systemctl enable httpd

#################  ##########################
# Install Docker 
sudo yum install docker -y
check_error "Failed to install Docker"
sudo systemctl enable docker
sudo systemctl start docker
check_error "Failed to start Docker"
sudo usermod -a -G docker ec2-user
check_error "Failed to add ec2-user to Docker group"

#################  ##########################
# Install Docker Compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
check_error "Failed to download Docker Compose"
sudo chmod +x /usr/local/bin/docker-compose
check_error "Failed to make Docker Compose executable"

#################  ##########################
# Install terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
check_error "Failed to install Terraform"

#################  ##########################
# Install jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
check_error "Failed to download Jenkins repository file"
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
check_error "Failed to import Jenkins repository key"
sudo yum install jenkins -y
check_error "Failed to install Jenkins"
sudo systemctl enable jenkins
sudo systemctl start jenkins
check_error "Failed to start Jenkins"

# Add jenkins user to docker group
sudo usermod -a -G docker jenkins
check_error "Failed to add jenkins to Docker group"

echo "Setup completed successfully."



# #!/bin/bash

# # Update package repositories
# sudo yum update -y

# # Install Git
# sudo yum install git -y

# # Install Maven
# sudo yum install -y maven

# # Install Java (Amazon Corretto)
# sudo yum install -y java-11-amazon-corretto-headless

# # Install Docker 
# sudo yum install docker -y
# sudo systemctl enable docker
# sudo systemctl start docker
# sudo usermod -a -G docker ec2-user

# # Install Docker Compose
# sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose

# # Install terraform
# sudo yum install -y yum-utils
# sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
# sudo yum -y install terraform

# # Install jenkins
# sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
# sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
# sudo yum install jenkins -y
# sudo systemctl enable jenkins
# sudo systemctl start jenkins

# # Add jenkins user to docker group
# sudo usermod -a -G docker jenkins
