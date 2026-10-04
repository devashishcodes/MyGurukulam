# AWS Assignment 4 – Infrastructure with Terraform

**Assignment Done By:** Devashish Prakash Sathawane

## Problem Statement

Design and implement AWS infrastructure using Terraform IaC based on the architecture requirements.

- Create infrastructure using Terraform.
- Configure networking, subnets, security groups, IAM, launch template, and Auto Scaling Group.
- Store Terraform state remotely using Amazon S3.
- Maintain consistent Terraform and provider versions.

---

## 1. Check Terraform Version

![Terraform Version](images/01-terraform-version.png)

The Terraform version and AWS provider version were verified before starting the implementation.

---

## 2. Verify AWS Account

![AWS Identity](images/02-aws-identity.png)

The AWS account identity was verified using the AWS CLI.

---

## 3. Initialize and Validate Terraform

![Terraform Validate](images/03-terraform-validate.png)

Terraform was initialized and the configuration was validated successfully.

---

## 4. Create Infrastructure

![Terraform Apply](images/04-terraform-apply.png)

The Terraform configuration was applied successfully and the required AWS infrastructure was created.

---

## 5. Configure S3 for Terraform State

![S3 Terraform State](images/05-s3-state.png)

An S3 bucket was configured to store the Terraform state file remotely.

---

## 6. Verify VPC and Networking

![VPC](images/06-vpc.png)

The VPC and networking resources created through Terraform were verified in the AWS Console.

---

## 7. Verify VPC Resource Map

![VPC Resource Map](images/07-vpc-resource-map.png)

The VPC resource map shows the VPC, subnets, route tables, and network connections.

---

## 8. Verify Security Group

![Security Group](images/08-security-group.png)

The Security Group created through Terraform was verified in the AWS Console.

---

## 9. Verify IAM Role

![IAM Role](images/09-iam-role.png)

The IAM role required for the infrastructure was created and verified.

---

## 10. Verify Launch Template

![Launch Template](images/10-launch-template.png)

The EC2 Launch Template was created successfully for the instances.

---

## 11. Verify Auto Scaling Group

![Auto Scaling Group](images/11-auto-scaling-group.png)

The Auto Scaling Group was created and configured using Terraform.

---

## 12. Verify EC2 Instance

![EC2 Instance](images/12-ec2-instance.png)

The EC2 instance launched through the Auto Scaling Group was verified in the AWS Console.

---

## 13. Verify S3 Bucket

![S3 Bucket](images/13-s3-bucket.png)

The S3 bucket used for Terraform remote state was verified in the AWS Console.

---

## 14. Upload Terraform Code to GitHub

![GitHub Repository](images/14-github-upload.png)

The Terraform configuration files were committed and pushed to the GitHub repository.

---

## 15. Verify GitHub Repository

![GitHub Repository](images/15-github-repository.png)

The Terraform project files were successfully uploaded to the GitHub repository.

---

## 16. Terraform Destroy

![Terraform Destroy](images/16-terraform-destroy.png)

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
