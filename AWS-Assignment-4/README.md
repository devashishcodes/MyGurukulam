# AWS Assignment 4 – Infrastructure with Terraform

**Assignment Done By:** Devashish Prakash Sathawane

## Problem Statement

Design and implement AWS infrastructure using Terraform IaC based on the architecture requirements.

- Create infrastructure using Terraform.
- Configure networking, subnets, security groups, IAM, launch template, and Auto Scaling Group.
- Store Terraform state remotely using Amazon S3.
- Maintain consistent Terraform and provider versions.

---

## 1. Check Terraform Version & Verify AWS Account

<img width="975" height="291" alt="image" src="https://github.com/user-attachments/assets/b98352d7-2ced-416e-88e3-0b8e8c1b6e2d" />

The Terraform version and AWS provider version were verified before starting the implementation.

---

## 2. Initialize and Validate Terraform

<img width="683" height="101" alt="image" src="https://github.com/user-attachments/assets/2a830096-e163-4365-b897-2f6680494d96" />

Terraform was initialized and the configuration was validated successfully.

---

## 3. Create Infrastructure

<img width="890" height="470" alt="image" src="https://github.com/user-attachments/assets/77c9276e-63dd-4459-9c8c-77ba63dc5d0f" />

The Terraform configuration was applied successfully and the required AWS infrastructure was created.

---

## 4. Configure S3 for Terraform State

<img width="975" height="44" alt="image" src="https://github.com/user-attachments/assets/bc5bfaa7-aa46-4d1e-ac8c-ef5068e32eef" />

An S3 bucket was configured to store the Terraform state file remotely.

---

## 5. Verify VPC and Networking

<img width="975" height="306" alt="image" src="https://github.com/user-attachments/assets/d01baed4-35ed-4108-9acb-b30a044f1079" />

The VPC and networking resources created through Terraform were verified in the AWS Console.

---

## 6. Verify VPC Resource Map

<img width="975" height="259" alt="image" src="https://github.com/user-attachments/assets/e7bdb51b-acb5-427e-9d2e-535acfc94bee" />

The VPC resource map shows the VPC, subnets, route tables, and network connections.

---

## 7. Verify Security Group

<img width="975" height="242" alt="image" src="https://github.com/user-attachments/assets/a9e90f28-662b-4caa-910f-5fc092fb52f2" />

The Security Group created through Terraform was verified in the AWS Console.

---

## 8. Verify IAM Role

<img width="975" height="242" alt="image" src="https://github.com/user-attachments/assets/3d107f9c-705c-40f4-91f0-1971de78ed1e" />

The IAM role required for the infrastructure was created and verified.

---

## 9. Verify Launch Template

<img width="975" height="247" alt="image" src="https://github.com/user-attachments/assets/8df35242-51eb-4726-8578-d3253b47525f" />

The EC2 Launch Template was created successfully for the instances.

---

## 10. Verify Auto Scaling Group

<img width="975" height="252" alt="image" src="https://github.com/user-attachments/assets/ad4d7ca4-4da4-470f-9d0f-3849241737e9" />

The Auto Scaling Group was created and configured using Terraform.

---

## 11. Verify EC2 Instance

<img width="975" height="250" alt="image" src="https://github.com/user-attachments/assets/bdc02f6a-9b78-4648-9bde-e4f57cb69eaf" />

The EC2 instance launched through the Auto Scaling Group was verified in the AWS Console.

---

## 12. Verify S3 Bucket

<img width="975" height="339" alt="image" src="https://github.com/user-attachments/assets/ee015d0c-4140-4335-849c-97d80fe73912" />

The S3 bucket used for Terraform remote state was verified in the AWS Console.

---

## 13. Upload Terraform Code to GitHub

<img width="975" height="500" alt="image" src="https://github.com/user-attachments/assets/a8ea2bb4-52f3-49a1-8e5b-b40fcbcd91ca" />
<img width="975" height="549" alt="image" src="https://github.com/user-attachments/assets/e474cbc7-5a7e-464a-a33c-a52071a1ff85" />

The Terraform configuration files were committed and pushed to the GitHub repository.

---

## 14. Verify GitHub Repository

<img width="975" height="524" alt="image" src="https://github.com/user-attachments/assets/d901a09e-1080-4354-a287-4db672bdac3b" />

The Terraform project files were successfully uploaded to the GitHub repository.

---

## 15. Terraform Destroy

<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/c1a3c6bd-9386-4e7f-8613-ee182a0e6d99" />

After completing the assignment, `terraform destroy` was used to remove the created AWS resources.

---

## Terraform Commands Used

```bash
terraform -version
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform destroy
