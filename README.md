# 📋 Terraform Three-Tier Architecture Project

## 🚀 Project Overview
This project implements a highly available, secure, and scalable three-tier architecture using Terraform. It includes a web tier (frontend), an application tier (backend), and a database tier (RDS). Each tier is deployed across multiple availability zones in AWS.

---

## 📂 Project Structure
```
/three-tier-project
├── terraform
│   ├── main.tf              # Main Terraform file linking all modules
│   ├── provider.tf          # AWS Provider configuration
│   ├── network-resources.tf # VPC, Subnets, and Networking
│   ├── asg_app.tf           # AutoScaling for Backend
│   ├── asg_lb_web.tf        # AutoScaling for Frontend
│   ├── rds.tf               # RDS Instance
│   ├── security.tf          # Security Groups
│   ├── variables.tf         # Variable Definitions
│   ├── outputs.tf           # Terraform Outputs
├── scripts
│   ├── backend.sh           # Backend Deployment Script
│   ├── frontend.sh          # Frontend Deployment Script
└── README.md                # Project Documentation
```

---

## 📌 Deployment Steps
1. **Install Terraform:**
   ```bash
   brew install terraform  # macOS
   choco install terraform # Windows
   ```

2. **Clone the Repository:**
   ```bash
   git clone https://github.com/YourUsername/three-tier-project.git
   cd three-tier-project/terraform
   ```

3. **Initialize Terraform:**
   ```bash
   terraform init
   ```

4. **Validate the Configuration:**
   ```bash
   terraform validate
   ```

5. **Deploy the Infrastructure:**
   ```bash
   terraform apply
   ```

6. **Destroy the Infrastructure (if needed):**
   ```bash
   terraform destroy
   ```

---

## 🌐 Key Features Implemented
- **Networking:** VPC, subnets, internet gateway, and NAT gateway.
- **Security:** Security groups for EC2, Load Balancer, and RDS.
- **Scalability:** Auto-scaling for frontend and backend tiers.
- **Database:** RDS with Multi-AZ setup and secure connection.
- **Automation:** Automated deployment using Terraform modules.

---

## 🏆 License
This project is licensed under the MIT License.

Happy Deploying! 🚀

