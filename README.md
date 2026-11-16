# ☁️ AWS & Kubernetes Infrastructure with Terraform (`terraform-aws-floci`)

![Terraform](https://shields.io)
![AWS](https://shields.io)
![Kubernetes](https://shields.io)

## 🎯 Project Purpose
This repository serves as a hands-on engineering showcase demonstrating end-to-end **Infrastructure-as-Code (IaC)** workflows across **AWS**, **Terraform**, and **Kubernetes**. Rather than relying on monolithic scripts, this project implements industry-standard modular design and environment separation to provision scalable, repeatable cloud infrastructure.

---

## 🏗️ Architectural & Engineering Highlights
* **DRY Modular Design (`modules/`):** Abstracted core cloud resources into reusable, composable Terraform modules to minimize code duplication and simplify maintenance.
* **Multi-Environment Isolation (`Environments/`):** Structured configurations to support isolated lifecycles (e.g., Dev, Staging, Prod) with distinct variable sets.
* **Automated Kubernetes Orchestration:** End-to-end cluster provisioning and worker node configuration automated via Terraform.
* **Clean Configuration Management:** Follows Terraform best practices by separating input variables (`variables.tf`), computed values (`locals.tf`), provider locks (`provider.tf`), and resource exports (`output.tf`).

---

## 📂 Repository Structure
```text
terraform-aws-floci/
├── Environments/       # Environment-specific configurations & tfvars
├── modules/            # Reusable Terraform infrastructure & K8s modules
├── main.tf             # Core resource orchestration
├── variables.tf        # Input variable definitions
├── locals.tf           # Local expressions and naming conventions
├── output.tf           # Exported resource attributes & cluster endpoints
└── provider.tf         # AWS & Kubernetes provider configurations
```

---

## 🛠️ Skills & Concepts Demonstrated
* **Cloud Architecture (AWS):** IAM roles/policies, VPC networking, security groups, and compute provisioning.
* **Infrastructure as Code (Terraform):** Module authoring, variable parameterization, dependency management, and declarative state workflows.
* **Container Orchestration (Kubernetes):** Cluster bootstrapping, networking setup, and declarative workload readiness.

---

## 🚀 Quick Start / Usage

```bash
# 1. Clone the repository
# Clone via HTTPS
git clone https://github.com/AnupJacob/terraform-aws-floci.git
OR
# clone via SSH
git clone git@github.com:AnupJacob/terraform-aws-floci.git

cd terraform-aws-floci

# 2. Initialize Terraform & download providers
terraform init

# 3. Review the execution plan
terraform plan

# 4. Provision the AWS infrastructure & Kubernetes cluster
terraform apply
```
