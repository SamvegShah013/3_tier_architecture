#!/bin/bash

# Update System and Install Required Packages
sudo yum update -y
sudo yum install httpd -y
sudo yum install git -y 
sudo yum install -y gcc-c++ make 
sudp curl -sL https://rpm.nodesource.com/setup_21.x | sudo -E bash - 
sudo yum install -y nodejs
# Clone Frontend Repository
sudo git clone https://github.com/SamvegShah013/TodoApp.git

# Navigate to Frontend Folder
cd TodoApp/frontend

# Install Node.js Dependencies and Build Project
sudo npm install 
sudo npm run build

# Deploy Built Files to Apache Server
sudo cp -r dist/* /var/www/html/

# Start and Enable Apache Service
sudo systemctl start httpd
sudo systemctl enable httpd
