# Terraform-multi-resource

This project creates:

* 4 EC-2 instance with different subnet 
* Subnet-1 with EC2-0, EC2-1
* Subnet-2 with EC2-2, EC2-3

---

## ✅ Prerequisites

Before running the Terraform commands, ensure you have:

* An **AWS account** with an **IAM user** (configured via `aws configure`)

* **Terraform** installed on your system

* you have a **static website** code in the same folder 

* In my case i have an application of TO-DO list app (which is create in React Technology and it is Build already, so i have it's build file /dist)

* **Git** installed to clone the repository

* Cloned this repo using:

  ```bash
  git clone <repo-link-here>
  ```

* Navigated into the folder containing `main.tf`:

  ```bash
  cd <repo-folder-name>
  ```

* Generated an **SSH key** with the same name used in the Terraform code for the `key_pair` (or modify the code to match your own key name)

---

## 🚀 Run These Terraform Commands

### 1. Initialize Terraform (downloads required providers)

```bash
terraform init
```

---

### 2. Plan the Infrastructure

```bash
terraform plan
```

---

### 3. Apply the Infrastructure

```bash
terraform apply
```

or with auto-approve:

```bash
terraform apply -auto-approve
```

---