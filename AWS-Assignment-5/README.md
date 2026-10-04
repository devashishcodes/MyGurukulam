# AWS Assignment 5 – Implement Infrastructure with Terraform Modules

**Assignment Done By:** Devashish Prakash Sathawane

## Problem Statement

Implement Infrastructure with Terraform Module.

- Create reusable Terraform modules for infrastructure components such as VPC, Subnets, Security Groups, and EC2 instances.
- Configure Terraform state management using Amazon S3.
- Enable state locking using DynamoDB.

---

## 1. Terraform Module Structure

The Terraform project was organized into reusable modules for different infrastructure components.

<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/01545ec6-065e-44bd-afa0-32905a460b1c" />

The project contains separate modules for VPC, Subnet, Security Group, EC2 Instance, and backend configuration.

---

## 2. Terraform Initialization and Plan

Terraform was initialized and the configuration was checked using `terraform init` and `terraform plan`.

<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/ebd47357-62d7-43ca-9553-6d4d8d48fbbd" />

The Terraform plan verified the resources that would be created before applying the configuration.

---

## 3. Create S3 Bucket for Terraform State

An Amazon S3 bucket was created to store the Terraform state file.

<img width="744" height="415" alt="image" src="https://github.com/user-attachments/assets/ba7e4dc6-160a-4b9a-ad29-df3cb083cdf3" />

The plan showed the S3 bucket and its required configuration before creation.

---

## 4. Apply S3 Backend Configuration

The S3 bucket was created successfully using Terraform.

<img width="871" height="519" alt="image" src="https://github.com/user-attachments/assets/677b23d6-c506-4bdc-b144-194af5e87972" />

The Terraform apply completed successfully and the S3 bucket was created.

---

## 5. Create Infrastructure Using Terraform Modules

The Terraform configuration was applied to create the infrastructure using the reusable modules.

<img width="975" height="443" alt="image" src="https://github.com/user-attachments/assets/f91de1c5-08a5-4267-8286-cb309815071b" />

The infrastructure resources were created successfully using the Terraform modules.

---

## 6. Verify Terraform State

The created resources were verified using the Terraform state list command.

<img width="940" height="620" alt="image" src="https://github.com/user-attachments/assets/42a435f2-3c36-4c43-a5df-7782286e15a6" />

The `terraform state list` command displayed the resources managed by Terraform.

---

## 7. Check Terraform Outputs

Terraform outputs were checked to verify the created infrastructure details.

<img width="838" height="915" alt="image" src="https://github.com/user-attachments/assets/56c08974-dd3e-42ee-89b7-af7b498083e7" />

The output displayed the VPC ID, subnet IDs, security group ID, public IPs, private IPs, and instance IDs.

---

## 8. Verify S3 State Bucket & Verify DynamoDB State Lock

The Terraform state bucket was checked in the AWS Management Console. The DynamoDB table used for Terraform state locking was checked.

<img width="975" height="157" alt="image" src="https://github.com/user-attachments/assets/697fa567-5d24-417c-9bc5-621d12e7e9a1" />

The S3 bucket used for Terraform state management was successfully created. The DynamoDB table was active and configured for Terraform state locking.

---

## 9. Verify EC2 Instances

The EC2 instances created through Terraform were verified in the AWS Console.

<img width="975" height="240" alt="image" src="https://github.com/user-attachments/assets/201f0d15-2ad5-484f-b18a-9713d0f933d8" />

The EC2 instances were successfully created and running.

---

## 10. Verify VPC

The VPC created using the Terraform module was verified in the AWS Console.

<img width="975" height="298" alt="image" src="https://github.com/user-attachments/assets/3ce02e31-799f-4268-812f-493e9ceabfdf" />

The VPC and its associated networking resources were successfully created.

---

## 12. Final Result

The infrastructure was successfully implemented using reusable Terraform modules.

### Resources Created

- VPC
- Public Subnets
- Private Subnets
- Route Tables
- Security Group
- EC2 Instances
- S3 Bucket for Terraform State
- DynamoDB Table for State Locking

### Terraform Commands Used

```bash
terraform init
terraform validate
terraform plan
terraform apply
terraform state list
terraform output
