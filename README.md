# 📑 Table of Contents:

1. [🚀 Project Overview](#project-overview)
2. [🖼️ Architecture Diagram](#architecture-diagram)
3. [🧰 Architectural Design Rationale](#overview-of-used-aws-services)
4. [⚙️ Terraform Configuration Overview](#terraform-configuration-overview)
5. [🏗️ Infrastructure Components](#infrastructure-components)
   - [🌐 VPC](#vpc)
   - [🛡️ Security Groups](#security-groups)
   - [🖥️ EC2 Launch Template](#ec2-launch-template)
   - [⚖️ Application Load Balancer (ALB)](#application-load-balancer-alb)
   - [💾 Amazon RDS](#amazon-rds)
   - [🗂️ S3 Bucket](#s3-bucket)
   - [🔐 IAM Roles for EC2](#iam-roles-for-ec2)
   - [🔐AWS Secrets Manager](#aws-secrets-manager) 
6.  [🔐 Security Considerations](#securtity-considerations)
7. [🚀 CI/CD Pipeline with GitHub Actions](#cicdpipelines-githubactions)
8. [🧩 Understanding GitHub Actions Strategy](#githubaction-strategy)
9. [🚧 Future Developments](#furture-developments)
10. [🚀 Step-by-Step Deployment Guide](#step-by-developments)
11. [🔧 Troubleshooting & FAQ](#troubleshooting-faq)
12. [📋 FAQ (Frequently Asked Questions)](#12--faq-frequently-asked-questions)
13. [ 📚 Glossary](#13--glossary)
14. [🤝 Contributing](#contributing)
15. [📜 License](#license)
  
---
 ## 🚀 Project Overview:

This project is part of the Cloud Track in our Software Engineering bootcamp at Masterschool. The application was originally developed by Alejandro Román, our Track Mentor (A big Thanks to him!). Our task was to design and deploy its AWS infrastructure step by step, implementing each component individually.

GroceryMate is an application developed as part of the Masterschools program by Alejandro Roman Ibanez. It is a modern, full-featured e-commerce platform designed for seamless online grocery shopping. It provides an intuitive user interface and a secure backend, allowing users to browse products, manage their shopping basket, and complete purchases efficiently.

GroceryMate is a modern, full-featured e-commerce platform designed for seamless online grocery shopping. It provides an intuitive user interface and a secure backend, allowing users to browse products, manage their shopping basket, and complete purchases efficiently.



 ### 🌐 AWS Services Used:
- 🖥️ **EC2 Instance**: Deployed virtual servers to run the application.
- 🏢 **Application Load Balancer (ALB)**: Ensured high availability and traffic distribution across instances.
- 💾 **RDS (Relational Database Service)**: Managed and scaled the database with ease.
- 🗂️ **S3 Bucket**: Stored and managed static files for the application.
- 🛡️ **IAM Roles**: Configured and attached IAM roles to securely manage permissions and access control for various AWS resources.

The objective was to architect and deploy a resilient, highly available, and secure infrastructure, following Infrastructure as Code (IaC) principles and AWS best practices. Every component was provisioned, configured, and integrated through Terraform — ensuring consistency, repeatability, and version-controlled deployments.
For details about the application's features, functionality, and local installation, refer to the original README.md by Alejandro.

---

 ### 2. 🖼️ Architecture Diagram:
  ![img_1.png](img_1.png)
  ![img.png](img.png)
---
## 📌 Architectural Design Rationale:

## 🧠 Architecture & Tooling Decisions

### 🖥️ Amazon EC2 (Elastic Compute Cloud)
- **Why EC2?**  
  EC2 was selected for full control over the OS, networking, and runtime—essential for learning infrastructure at a granular level. It allows SSH access, custom AMI usage, and fine-grained provisioning control.
- **Why not App Runner, Lambda, or ECS?**  
  These services abstract away too much for foundational infrastructure education. Lambda limits runtime flexibility, ECS adds orchestration complexity, and App Runner is optimized for containerized workloads without hands-on control.

---

### 🌐 Application Load Balancer (ALB)
- **Why ALB?**  
  ALB enables dynamic routing and health checks for multiple EC2 instances, supporting high availability and auto-scaling. It integrates easily with ASGs and provides rich metrics.

---

### 💾 Amazon RDS (Relational Database Service)
- **Why RDS?**  
  RDS was chosen to host a PostgreSQL database due to the application's reliance on a **relational data model with multiple interrelated tables** (e.g., users, products, orders). It ensures data integrity, supports complex SQL queries, and enables structured relationships across entities.
- **Why not DynamoDB or Aurora Serverless?**  
  DynamoDB lacks relational joins and is optimized for key-value and document access patterns—not suitable for this schema-heavy workload. Aurora Serverless adds dynamic complexity and may be overkill for early-stage deployments with predictable traffic.

---

### 🗂️ Amazon S3 (Simple Storage Service)
- **Why S3?**  
  Used for storing static assets like product images—it's durable, scalable, and cost-effective. It integrates seamlessly with other AWS services and supports lifecycle policies and versioning.
- **Why not EFS or EBS?**  
  Those are better for block-level or POSIX file systems—not object storage.

---

### ⚙️ Terraform (Infrastructure as Code)
- **Why Terraform?**  
  Terraform was selected for its provider-agnostic design, robust AWS module ecosystem, and remote state capabilities. It ensures reproducible, version-controlled deployments across environments.
- **Why not AWS CloudFormation or Pulumi?**  
  CloudFormation is AWS-only and has a steeper learning curve. Pulumi requires a general-purpose language like TypeScript or Python, which introduces extra complexity for infrastructure beginners. structure in a scalable, automated, and version-controlled manner.

---
## 4. ⚙️ Terraform Configuration Overview:

   ```bash
terraform/
├── main.tf                 # Root module wiring all other modules
├── variables.tf            # Input variables
├── outputs.tf              # Output values from root module
├── terraform.tfvars        # Variable values used during plan/apply
└── modules/
    ├── alb/                    # Application Load Balancer configuration
    ├── security_groups/        # Security group rules for ALB, EC2, RDS
    ├── ec2_launch_template/    # EC2 instance setup and Auto Scaling
    ├── rds/                    # Amazon RDS (PostgreSQL/MySQL) database
    ├── s3_bucket/              # S3 bucket for static files
    ├── vpc/                    # VPC, subnets, IGW, route tables, etc.
    └── iam_roles_ec2/         # IAM role and policy for EC2 to access S3


   ```
---

## 5. 🏗️ Infrastructure Components:

### 🌐 VPC Module
 
- **📝 Description:**  
  Defines the **Virtual Private Cloud (VPC)** and associated networking resources including subnets, internet gateway, and route tables. This sets up the foundational network layer for your AWS infrastructure.


---

### 🛡️ Security Groups


- **📝 Description:**
  Creates security groups for EC2, RDS, and ALB to control inbound/outbound traffic.



---
###  🖥️ EC2 Launch Template

- **📝 Description:**  
  Configures EC2 launch template with AMI, instance type, and user data script.



---
###  🌐 Application Load Balancer (ALB)

- **📝 Description:**  
  Sets up an ALB to distribute traffic across EC2 instances.



---
###  💾 RDS

- **📝 Description:**  
  Sets up an ALB to distribute traffic across EC2 instances.

  
---

###  💾 S3 Bucket

- **📝 Description:**  
  Sets up an ALB to distribute traffic across EC2 instances.



---
###  🔐 IAM Roles for EC2

- **📝 Description:**  
  Creates an IAM role and instance profile for EC2 instances, granting them permissions to access a specific S3 bucket or folder path within the bucket.


---
### 🔐 AWS Secrets Manager

- **📝 Description:**  
  Manages sensitive data like database credentials or API keys securely using AWS Secrets Manager. This module creates and stores secrets, allowing secure access by applications or services without hardcoding sensitive values.


---
###  ⚙️ Root Module

- **📝 Description:**  
  Integrates all individual modules and manages global variables, outputs, and backend config.
-  **Purpose:**
   Serves as the central orchestrator for Terraform execution.
---

## 6. 🔐 Security Considerations:
- Security was integrated into each layer of the infrastructure, following AWS security best practices and the principle of least privilege.

### 🌐 VPC Module  and Subnets

- **📝 Description:**  
  Custom VPC design isolates public-facing and private resources:
   - Public subnets host the Application Load Balancer (ALB) to handle inbound traffic.
   -  Private subnets host EC2 instances and RDS, isolating sensitive services from direct internet access.
---

### 🛡️ Security Groups


- **📝 Description:**
  Security groups act as virtual firewalls to regulate traffic:
  - ALB Security Group: Allows inbound HTTP/HTTPS traffic from the internet.
  - EC2 Security Group: Accepts traffic exclusively from the ALB.
  - RDS Security Group: Permits traffic only from EC2 instances within private subnets.

---

###  🔐 IAM Roles for EC2

- **📝 Description:**  
  Defines scoped IAM roles granting EC2 instances secure, temporary permissions:
  - Enables controlled access to AWS services such as S3.
  - Prevents hardcoding sensitive credentials within application code.

---
### 🔐 AWS Secrets Manager

- **📝 Description:**  
  Manages sensitive data like database credentials securely:
  - Applications retrieve secrets programmatically at runtime.
  - Prevents embedding sensitive information in code or configuration files.
---
###  🔒 Encryption
- **📝 Description:**  
   Ensures data security at rest and in transit:
   - RDS storage and automated backups are encrypted at rest.
   - S3 bucket utilizes server-side encryption for all stored objects.
---

## 6. 🚀 CI/CD Pipeline with GitHub Actions
- To automate infrastructure provisioning and ensure consistency across environments, this project uses GitHub Actions for continuous integration and deployment (CI/CD). The CI/CD workflow is tailored to securely authenticate with AWS, generate environment-specific configurations, and run Terraform plans.

### 🔐 Secure AWS Access with OIDC and IAM Roles:
- Instead of using hardcoded AWS access keys or secrets in the pipeline, we use OIDC (OpenID Connect) to securely assume an IAM role directly from GitHub. This provides several key benefits:  
- **📝 Description:**  
  - Enhanced Security: No long-lived credentials are stored in GitHub — tokens are temporary and scoped.
  - Automatic Rotation: Tokens expire automatically, eliminating the need for manual key rotation.
  - Least Privilege Access: The IAM role has only the permissions required to run Terraform, minimizing the blast radius.
  - Tight Integration: GitHub’s native support for OIDC makes this setup seamless and cloud-native.
---
## 7. 🧩 Understanding Our GitHub Actions Strategy
- **📝 Description:**  
  During the GitHub Actions run:
  - The workflow authenticates to AWS using a role that trusts GitHub’s OIDC identity provider.
  - It dynamically generates a terraform.tfvars file by securely injecting values from GitHub Secrets. This includes whitelisted IPs, database credentials, AMI IDs, and more.
  - The Terraform CLI is then used to initialize the project and generate a plan using the configuration.
  - This design ensures that infrastructure deployments are secure, reproducible, and environmentally isolated, while still allowing dynamic configuration through centralized secrets' management.
  - By combining Infrastructure as Code (Terraform) with secure CI/CD practices, this setup aligns with modern DevOps and cloud security best practices.
---
## 8 🚧 Future Developments

While the current infrastructure is functional and secure, there are several enhancements planned to improve scalability, maintainability, and observability:

- **Add Monitoring & Logging** using AWS CloudWatch and centralized logging for EC2/RDS metrics.
- **Implement Auto-scaling Policies** for EC2 instances based on CPU/memory thresholds.
- **Add Blue/Green Deployment Support** via separate target groups in the ALB.
- **Enable GitHub Actions Terraform Apply** in a secure, gated manner (e.g., with manual approvals).
---

## 10  🚀 Step-by-Step Deployment Guide:
Follow these steps to clone the repository and deploy the Grocery App on AWS:

### Step 1: Create an AWS Account

- Sign up at AWS Sign-Up.
- Verify your email and complete the setup.  

---
### Step 2:  Create an IAM User and Access Keys
 
- Navigate to IAM > Users > Create User.
- Enable Programmatic Access.
- Attach these policies:
 - AmazonEC2FullAccess
 - AmazonRDSFullAccess
 - AmazonS3FullAccess
 - AmazonVPCFullAccess
 - IAMFullAccess
- Save your Access Key ID and Secret Access Key securely.
---
### Step 3: Install and Configure AWS CLI
 
- Install: AWS CLI Installation Guide
- Configure:
   - aws configure
- Provide your Access Key ID, Secret Access Key, and preferred AWS region (e.g., eu-central-1).
---
### Step 4: Create an SSH Key Pair
 
- Go to EC2 > Key Pairs > Create Key Pair.
- Format: .pem
- Save the .pem file securely for SSH access.
---
### Step 5: Clone the Repository
 
- git clone https://github.com/N123p/AWS_grocery_app.git
- cd AWS_grocery_app

---
### Step 6: Configure Terraform Variables

- Navigate to the infrastructure directory:
- cd infrastructure
- Edit terraform.tfvars with your configuration:
  - Region
  - DB Username/Password
  - S3 Bucket name (must be globally unique!)
  - SSH Key Pair name
  - Allowed SSH IP address
- (Optional) Existing AMI ID or RDS snapshot ID
---
### Step 7: Bootstrap Backend for Terraform State

- Initialize Terraform backend (S3 + DynamoDB locking):
  - terraform init
  - terraform apply
- This will set up your backend if it’s not already configured.
---
### Step 8: Setup GitHub Actions Secrets

- In your GitHub Repo:
- Navigate to Settings > Secrets and variables > Actions. init
- Add the following secrets:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY
  - TF_VAR_AMI_ID
  - TF_VAR_db_user
  - TF_VAR_db_password
  - TF_VAR_KEY_NAME
---

### Step 9: Deploy Infrastructure

- In your GitHub Repo:
- Push changes to the main branch.
- GitHub Actions will automatically:
  - Deploy the network (VPC, Subnets, Security Groups)
  - Launch the EC2 instances
  - Set up the RDS database
  - Configure the ALB
  - Deploy the backend and frontend applications.
---
### Step 10: Verify Deployment
- Access the app using the ALB DNS name (find in GitHub Actions output).
- SSH into EC2 (example):
  - ssh -i path/to/your-key.pem ec2-user@<EC2_PUBLIC_IP>
---
### Step 11: Destroy Resources (Teardown)
- Navigate to infrastructure/:
 - terraform destroy
- Confirm destruction by typing yes.
- If you created bootstrap resources separately, destroy them too.
---
### Step 12: (Optional) Deactivate GitHub Actions
- Go to Settings > Actions > General.
- Disable GitHub Actions if you want to stop automatic deployments.
---
# 11 🔧 Troubleshooting & FAQ

## Common Issues and Solutions

| Problem | Possible Cause | Solution |
|:--------|:---------------|:---------|
| **GitHub Actions workflow fails** | Incorrect IAM role ARN or missing secrets | Double-check GitHub repository secrets. Ensure all secrets are properly named and valid. |
| **Cannot SSH into EC2 instance** | Wrong key or wrong public IP address | Make sure you use the correct `.pem` key. Also check that your IP is whitelisted in the security group (`allowed_ssh_ip`). |
| **ALB DNS not reachable** | EC2 instances not registered or health check failures | Confirm target group health. Check security groups, and make sure the application server is running on the correct port. |
| **AWS CLI commands fail** | Misconfigured credentials or region | Re-run `aws configure` to fix credentials or region settings. |
| **RDS database not accessible** | Security group misconfiguration | Ensure the RDS security group allows incoming connections from the application server's security group. |


---


## 12 📋 FAQ (Frequently Asked Questions)

**Q1: Can I deploy this app outside `eu-central-1` region?**  
> Yes! Update the region in `terraform.tfvars` and GitHub secrets. Make sure AMI IDs and other region-specific resources match your selected region.

**Q2: How can I customize the EC2 instance size?**  
> Modify the instance type in the Terraform configuration under `aws_launch_template` resource (example: `t3.micro`, `t3.medium`).

**Q3: What happens if the deployment fails midway?**  
> Terraform keeps a state file. You can fix the issue and re-run the workflow to continue. No need to start from scratch unless backend resources are broken.



**Q4: How to safely rotate secrets and access keys?**  
> - Rotate your keys in AWS IAM.
> - Update the new values in GitHub Secrets immediately.
> - Re-run the GitHub Actions workflow if needed.

---

# 13 📚 Glossary

| Term | Description |
|:-----|:------------|
| **AWS CLI** | Command Line Interface tool to interact with AWS services. |
| **Terraform** | Infrastructure as Code (IaC) tool to provision cloud resources automatically. |
| **GitHub Actions** | CI/CD tool built into GitHub to automate workflows such as deployments. |
| **S3** | AWS Simple Storage Service, used for storing objects like Terraform state files. |
| **DynamoDB** | Managed NoSQL database by AWS, used here for Terraform state locking. |
| **IAM** | Identity and Access Management service in AWS to control user access and roles. |
| **EC2** | Elastic Compute Cloud — Virtual servers for running applications. |
| **ALB** | Application Load Balancer — Distributes incoming application traffic across multiple targets. |
| **RDS** | Relational Database Service — Managed SQL database service. |


---

## 14 🤝 Contributing
- We welcome contributions! Follow these steps:
  - Fork the repository 
  - Create a feature branch: git checkout -b feature/your-feature 
  - Implement changes & commit 
  - Push & create a Pull Request (PR)
---
## 15 📜 License
- This project is licensed under the MIT License and is free for non-commercial use.