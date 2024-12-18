#!/bin/bash

# Update system packages
sudo yum update -y

# Install Git and Node.js
sudo yum install -y git 

sudo yum install -y gcc-c++ make 
sudo curl -sL https://rpm.nodesource.com/setup_20.x | sudo -E bash - 
sudo yum install -y nodejs 



# Install MySQL Community Server
sudo yum install -y https://dev.mysql.com/get/mysql80-community-release-el9-5.noarch.rpm
sudo yum install -y mysql-community-server

# Enable and Start MySQL Service
sudo systemctl enable mysqld
sudo systemctl start mysqld

mysql -h "database-1.ctiew2c2oy8q.ap-south-1.rds.amazonaws.com" -u admin -p"samveg1234" <<EOF
CREATE DATABASE IF NOT EXISTS todo_app;
USE todo_app;

DROP TABLE IF EXISTS todos;

CREATE TABLE todos (
  id INT NOT NULL AUTO_INCREMENT,
  task VARCHAR(45) NOT NULL,
  createdAt DATE NOT NULL,
  status VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id_UNIQUE (id)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
EOF
# Clone the TodoApp Repository
sudo git clone https://github.com/SamvegShah013/TodoApp.git


# Navigate to Backend Directory
cd TodoApp/backend

# Install Node.js Dependencies
sudo npm install
sudo npm install dotenv express cors mysql2

# Start the Backend Server
sudo node index.js 

# End of Script
