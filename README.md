# 📑 Table of Contents:

1. [🚀 Project Overview](#project-overview)
2. [🖼️ Architecture Diagram](#architecture-diagram)
3. [🧰 Overview of Used AWS Services](#overview-of-used-aws-services)
4. [⚙️ Terraform Configuration Overview](#terraform-configuration-overview)
5. [🏗️ Infrastructure Components](#infrastructure-components)
   - [🌐 VPC](#vpc)
   - [🛡️ Security Groups](#security-groups)
   - [🖥️ EC2 Launch Template](#ec2-launch-template)
   - [⚖️ Application Load Balancer (ALB)](#application-load-balancer-alb)
   - [💾 Amazon RDS](#amazon-rds)
   - [🗂️ S3 Bucket](#s3-bucket)

  
---
 ## 🚀 Project Overview:

This project is part of the Cloud Track in our Software Engineering bootcamp at Masterschool. The application was originally developed by Alejandro Román, our Track Mentor (A big Thanks to him!). Our task was to design and deploy its AWS infrastructure step by step, implementing each component individually.

 ### 🌐 AWS Services Used:
- 🖥️ **EC2 Instance**: Deployed virtual servers to run the application.
- 🏢 **Application Load Balancer (ALB)**: Ensured high availability and traffic distribution across instances.
- 💾 **RDS (Relational Database Service)**: Managed and scaled the database with ease.
- 🗂️ **S3 Bucket**: Stored and managed static files for the application.
- 🛡️ **IAM Roles**: Configured and attached IAM roles to securely manage permissions and access control for various AWS resources.

Instead of a manual setup, I took the challenge further by fully automating the provisioning and deployment using Terraform. This approach ensures a scalable, repeatable, and error-resistant deployment process, eliminating the need for manual configurations.

For details about the application's features, functionality, and local installation, refer to the original README.md by Alejandro.

---

 ### 2. 🖼️ Architecture Diagram:
![image](https://github.com/user-attachments/assets/7c5fe55e-e6c9-482c-84a8-4a74bc18e0fb)
---

## 🧰 Overview of Used AWS Services:

### 🖥️ **Amazon EC2 (Elastic Compute Cloud):**
   - Virtual servers to host and run the grocery web application. Scalable and flexible compute power.

### 🌐 **Application Load Balancer (ALB):**
   - Distributes incoming HTTP(S) traffic across multiple EC2 instances to ensure high availability and fault tolerance.

### 💾 **Amazon RDS (Relational Database Service):**
   - Managed database service (e.g., PostgreSQL or MySQL) used to store structured app data such as users, orders, and inventory.

### 🗂️ **Amazon S3 (Simple Storage Service):**
   - Object storage for static files, such as product images, frontend assets, and backups.

### 🔐 **IAM Roles (Identity & Access Management):**
   - Provides temporary, secure, and scoped permissions for services like EC2 to access RDS or S3 without hardcoding credentials.

### 🛡️ **Security Groups (SG):**
   - Acts as a virtual firewall for your EC2 instances to control inbound and outbound traffic based on defined rules.

### ⚙️ **Terraform (Infrastructure as Code):**
   - Automates the entire provisioning process. Ensures infrastructure is repeatable, version-controlled, and error-resistant.

---
### 4. ⚙️ Terraform Configuration Overview:

terraform/
│
├── main.tf              # Root module wiring all other modules
├── variables.tf         # Input variables
├── outputs.tf           # Output values from root module
├── terraform.tfvars     # Variable values used during plan/apply
│
└── modules/
    ├── alb/
    ├── security_groups/
    ├── ec2_launch_template/
    ├── rds/
    ├── s3_bucket/
    └── vpc/
---

### 5. 🏗️ Infrastructure Components:

### **🌐 VPC:**
-Location: modules/vpc
-Description: Defines the Virtual Private Cloud, subnets, route tables, and internet gateways.
-Key Resources:
-aws_vpc
-aws_subnet
-aws_internet_gateway
-aws_route_table
 




















