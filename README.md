# 🚀 DevOps EC2 Automation with Terraform

This project automates the provisioning of EC2 instances on AWS using Terraform. It supports multi-environment deployments (`Dev`, `Prod`) in a single script and deploys a Spring Boot application (`techeazy-devops`) with secure SSH access, auto-shutdown logic, and S3 log upload capabilities.

---

## 📁 Project Structure

```
.
├── backend/
│   └── techeazy-devops-0.0.1-SNAPSHOT.jar     # Compiled Spring Boot JAR
├── README.md                                  # Project documentation
├── scripts/
│   └── user_data.sh.tpl                       # EC2 bootstrap script template with S3 injection
└── terraform/
    ├── deploy.sh                              # Stage-aware deployment script
    ├── dev_config.tfvars                      # Dev environment config
    ├── prod_config.tfvars                     # Prod environment config
    ├── main.tf                                # Terraform resources
    ├── outputs.tf                             # Terraform outputs
    ├── variables.tf                           # Input variable definitions
    ├── terraform.tfstate                      # Terraform state (auto-generated)
    └── terraform.tfstate.backup               # Backup state (auto-generated)
```

---

## ⚙️ Features

- 🔁 Stage-based config loading (`Dev`, `Prod`)
- 🔐 Automatic SSH key pair generation (4096-bit RSA)
- 🛡️ Security group restricts SSH to user IP and opens port 80 for HTTP
- 📀 Custom EBS volume, AMI, and instance type per environment
- ⏲️ EC2 auto-shutdown after 1 hour
- 🚀 Fully automated Spring Boot JAR build and background launch
- 📃 Upload logs to private S3 bucket with **write-only IAM role** from EC2
- 👁️ Read logs securely using **read-only IAM role** from other EC2 machine.
- ⚡ Lifecycle policy to auto-delete logs from S3 after 7 days

---

## 🛠️ Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- AWS credentials configured, or export:

```bash
export AWS_SHARED_CREDENTIALS_FILE="/path/to/your/custom/credentials/file"
export AWS_PROFILE="your_profile_name"
```

- Public IP whitelisted in '\*.tfvars' (Optional: if you want SSH access to EC2)

---

## 🧱️ IAM Roles

- `writeonly`: Attached to EC2 for uploading logs to S3 (PutObject only)
- `readonly`: Used locally for listing and viewing logs from S3 (ListBucket, GetObject)

---

## 🧰 Deploy Infrastructure + App

Run the deployment script with the desired stage:

```bash
./deploy.sh Dev    # or ./deploy.sh Prod
```

> This script runs Terraform with the appropriate `.tfvars` file and injects your stage and S3 bucket name into the EC2 startup script.

---

# 🚀 EC2 Initialization Script – `user_data.sh.tpl`

This script automates the setup and deployment of the `techeazy-devops` Spring Boot application on EC2 and handles secure log uploads.

---

## 📜 Actions Performed

- System package upgrade and installation of JDK 21, Maven, AWS CLI
- Git clone and Maven build of Spring Boot app
- Background launch of JAR file
- Upload of `/home/ubuntu/script.log` to private S3 bucket on shutdown
- Systemd service to ensure graceful log uploads
- Auto shutdown of EC2 after 60 minutes

---

## 🔐 Viewing Logs from S3

Once logs are uploaded to the S3 bucket, you can view them using your `read-only` IAM role credentials from other machine:

```bash
aws configure --profile readonly
aws s3 ls s3://<your-bucket-name>/app/logs/ --profile readonly
aws s3 cp s3://<your-bucket-name>/app/logs/<logfile>.log . --profile readonly
```

---
