# Terraform EKS Cluster (AWS)

This repository contains Terraform code to provision a **Amazon EKS cluster** on AWS using **Terraform Registry modules**, with a **remote backend (S3 + DynamoDB)** for state management.

---

##  Architecture Overview

The infrastructure includes:

- A custom **VPC**
  - 2 Public Subnets
  - 2 Private Subnets
  - NAT Gateway for private subnet internet access
- **Amazon EKS Cluster**
- **EKS Managed Node Group**
  - 2 worker nodes
  - Instance type: `m6a.large`
  - Nodes deployed **only in private subnets**
- **Terraform Remote Backend**
  - S3 for state storage
  - DynamoDB for state locking

---

##  Tools & Technologies

- Terraform (>= 1.5)
- AWS CLI
- Amazon EKS
- Kubernetes
- Terraform AWS VPC Module
- Terraform AWS EKS Module

---

##  Repository Structure

Terraform/
│
├── README.md
├── .gitignore
│
├── backend.tf
├── providers.tf
├── versions.tf
├── variables.tf
├── terraform.tfvars 
│
├── vpc.tf
├── eks.tf
├── outputs.tf


---

##  Prerequisites

Before you begin, ensure you have:

- An AWS account
- AWS CLI configured (`aws configure`)
- Terraform installed (`terraform --version`)
- kubectl installed
- Git installed

---

##  Remote Backend Setup (One-Time)

Terraform backend resources **must be created manually** before running Terraform.

### 1. Create S3 Bucket
- Enable versioning
- Block public access
- Enable encryption


### 2. Create DynamoDB Table
- Table name: `terraform-eks-locks`
- Partition key: `LockID` (String)
- Billing mode: On-demand

---

##  Deployment Steps

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/samiksha998/SimpleTimeService.git
cd terraform-eks-cluster

Commands:
2️⃣Initialize Terraform
terraform init


If migrating from local state:

terraform init -migrate-state

3️⃣ Validate Configuration
terraform validate

4️⃣ Review Execution Plan
terraform plan

5️⃣ Apply Terraform Configuration
terraform apply


Type yes when prompted.

 Deployment takes approximately 10–15 minutes.

 Configure kubectl Access
aws eks update-kubeconfig \
  --region us-east-1 \
  --name eks-demo-cluster


Verify nodes:

kubectl get nodes


You should see 2 worker nodes in Ready state.

 Cleanup (Important to Avoid Charges)
terraform destroy


Then manually delete:

S3 bucket

DynamoDB table
