# 🚀 DevOps EC2 Automation with Terraform

This project automates the provisioning of EC2 instances on AWS using Terraform. It supports multi-environment deployments (`Dev`, `Prod`) in a single script and deploys a Spring Boot application (`techeazy-devops`) with secure SSH access and auto-shutdown logic.

---

## 📁 Project Structure

```
.
├── backend/
│   └── techeazy-devops-0.0.1-SNAPSHOT.jar     # Compiled Spring Boot JAR
├── README.md                                  # Project documentation
├── scripts/
│   └── user_data.sh                           # EC2 bootstrap script
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
- 🔐 Automatic SSH key pair creation
- 🛡️ Security group restricts SSH to your IP and Ports are configured
- 💾 Custom disk, AMI, instance type per stage
- ⏲️ EC2 auto-shutdown after 1 hours
- 🚀 Single Script Spring Boot JAR deployment support

---

## 🛠️ Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- AWS credentials configured or export ```AWS_SHARED_CREDENTIALS_FILE="/path/to/your/custom/credentials/file"
 &&  export AWS_PROFILE="your_profile_name"```

- Public IP whitelisted in '*.tfvars' (Optional :- if you want to connect to the EC2 instances.)

---

## 🧱 Deploy Infrastructure + 

Run the deployment script with the desired stage:

```bash
./deploy.sh Dev    # or ./deploy.sh Prod 
```
````(This script will call the terraform + deployment of the application)````


---
# 🚀 EC2 Initialization Script – `user_data.sh`

This script automates the setup and deployment of the `techeazy-devops` Spring Boot application on an AWS EC2 instance. It is intended to be used as a **user data script** in Terraform or directly in EC2 launch configuration.

---

## 📜 File: `scripts/user_data.sh`

### 🎯 Purpose

Automates the following on EC2 launch:
- System updates and required package installations
- Git repository cloning
- Port reconfiguration
- Maven build
- Application launch in background
- Automatic shutdown after 1 hour to reduce cost

---






