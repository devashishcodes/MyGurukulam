# AWS Assignment 3 – Nginx High Availability, Auto Scaling & S3 Integration

**Assignment Done By:** Devashish Prakash Sathawane

## Problem Statement

The client application was not able to handle increasing traffic and load.

The solution was to configure Nginx as a reverse proxy with:

- High Availability
- Auto Scaling
- Application Load Balancer
- Nginx version management using AMIs
- S3 integration
- Failure testing
- Path-based routing
- IAM and S3 access control

---

# Day 1 – Nginx Setup, AMI, ALB & Auto Scaling

## 1. Create VPC

<img width="975" height="364" alt="image" src="https://github.com/user-attachments/assets/4c864288-41b5-4ff4-b3e8-09d18852e936" />

A VPC named `assignment3-vpc` was created with CIDR `10.0.0.0/16`.

---

## 2. Create Public and Private Subnets

<img width="975" height="305" alt="image" src="https://github.com/user-attachments/assets/764f8582-c951-4081-aa9b-47e312298af1" />

Four subnets were created across two Availability Zones, including two public and two private subnets.

---

## 3. Create Internet Gateway

<img width="975" height="308" alt="image" src="https://github.com/user-attachments/assets/f3e28362-172d-4c1c-b96b-d477bdd63db8" />

An Internet Gateway was created and attached to the VPC for internet connectivity.

---

## 4. Configure Route Tables

<img width="975" height="440" alt="image" src="https://github.com/user-attachments/assets/85c515b1-314c-4745-a9a5-613548d5164e" />
<img width="975" height="413" alt="image" src="https://github.com/user-attachments/assets/6045f983-28ba-4f44-b7ca-741b72b66b6e" />

Public and private route tables were configured and associated with their respective subnets.

---

## 5. Create Security Groups

<img width="975" height="283" alt="image" src="https://github.com/user-attachments/assets/24277c3a-b88e-4166-a88e-267666f148b8" />

Separate Security Groups were created for the ALB, Bastion Host, and Nginx servers.

---

## 6. Launch Nginx Base Instance

<img width="975" height="215" alt="image" src="https://github.com/user-attachments/assets/d9b5086d-c1b7-4dad-9935-37e5d6cb555d" />

An Ubuntu EC2 instance was launched as the base Nginx server.

---

## 7. Install Nginx

<img width="975" height="181" alt="image" src="https://github.com/user-attachments/assets/d14e3ef7-4dcc-4797-93b2-9f9bddeba192" />

Nginx was installed and the default welcome page was verified successfully.

---

## 8. Create Nginx AMI-1

<img width="975" height="212" alt="image" src="https://github.com/user-attachments/assets/5a672299-e503-4282-8fcb-3af2f0e562bb" />

An AMI was created from the base Nginx instance.

---

## 9. Create Nginx Version 1

<img width="975" height="226" alt="image" src="https://github.com/user-attachments/assets/bf61d081-6b38-47bf-beda-ab95b77c9a6d" />
<img width="975" height="179" alt="image" src="https://github.com/user-attachments/assets/d9a0efc2-7202-4371-8e42-8f468f90cc30" />

Nginx Version 1 was launched from AMI-1 and verified successfully.

---

## 10. Customize Nginx Version 1

<img width="975" height="523" alt="image" src="https://github.com/user-attachments/assets/2f6807ff-a303-4dec-a001-0dde4961bb03" />

The Nginx welcome page was customized with the Devashish AWS, DevOps and Cloud Infrastructure webpage.

---

## 11. Create Nginx AMI-2

<img width="975" height="230" alt="image" src="https://github.com/user-attachments/assets/68d0cbbc-ad3a-473b-8203-0e7aec89d811" />

A second AMI was created containing the customized Nginx webpage.

---

## 12. Launch Nginx Version 2

<img width="975" height="228" alt="image" src="https://github.com/user-attachments/assets/2cf4c605-a883-4199-9bac-1e5344720e4c" />

Nginx Version 2 was launched from the customized AMI-2.

---

## 13. Verify Nginx Version 2

<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/14240b30-5b10-44ee-95e1-8904e482845c" />

The upgraded Nginx Version 2 webpage was verified successfully.

---

## 14. Create Target Group

<img width="975" height="520" alt="image" src="https://github.com/user-attachments/assets/2a26011a-6bb2-4a4f-a90e-333178a06035" />

A target group was created for the Nginx EC2 instances.

---

## 15. Register Nginx Instances

<img width="975" height="518" alt="image" src="https://github.com/user-attachments/assets/74712133-a7aa-4e01-8980-26a11a0a3853" />

The Nginx EC2 instances were registered with the target group and health checks were verified.

---

## 16. Create Application Load Balancer

<img width="975" height="519" alt="image" src="https://github.com/user-attachments/assets/956eb8d9-af49-4844-92b5-1e452b1505bb" />

An internet-facing Application Load Balancer was created across two Availability Zones.

---

## 17. Verify ALB Traffic

<img width="975" height="199" alt="image" src="https://github.com/user-attachments/assets/e7bd728b-3a90-4fad-9507-0e880fae3edd" />
<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/ac1bb64e-f62f-496e-9a3a-b29bf3461867" />

The ALB successfully routed traffic to the Nginx servers.

---

## 18. Verify Load Balancing

<img width="975" height="463" alt="image" src="https://github.com/user-attachments/assets/d1cd6f68-e198-4128-bb39-a8d8cc11aedd" />

Requests were distributed across different Nginx instances and both Nginx versions were observed during testing.

---

## 19. Create Launch Template

<img width="975" height="405" alt="image" src="https://github.com/user-attachments/assets/6445464e-f104-4d98-bc54-f628aa3f672f" />

A Launch Template was created using the Nginx AMI for Auto Scaling.

---

## 20. Create Auto Scaling Group

<img width="975" height="235" alt="image" src="https://github.com/user-attachments/assets/eaf8263c-0c3d-4c0d-aa24-334e85fc50da" />

An Auto Scaling Group was created using the Launch Template.

---

## 21. Verify Auto Scaling Instances

<img width="975" height="253" alt="image" src="https://github.com/user-attachments/assets/47d593f5-dfb3-4491-a2d8-495cc9ee5885" />

The Auto Scaling Group successfully maintained healthy EC2 instances across Availability Zones.

---

# Day 2 – Nginx Web Hosting with S3

## 22. Create GitHub Repository

<img width="975" height="275" alt="image" src="https://github.com/user-attachments/assets/acec848c-bc8b-4adf-b6f3-9a3fd1a7d9b6" />

A GitHub repository was created to maintain the Nginx webpage and image files.

---

## 23. Upload Images to S3

<img width="975" height="388" alt="image" src="https://github.com/user-attachments/assets/5f52932b-d350-4bc0-860d-1621e95bd8be" />

The webpage images were uploaded to an S3 bucket using AWS CLI from an EC2 instance.

---

## 24. Verify S3 Images

<img width="975" height="403" alt="image" src="https://github.com/user-attachments/assets/697f30f6-8aa8-4e26-a41e-f6384096d20f" />

The uploaded image files were verified in the S3 bucket.

---

## 25. Host Webpage Using Nginx and S3

<img width="975" height="524" alt="image" src="https://github.com/user-attachments/assets/14a315b7-a97e-49dd-a5f8-77a2a971e27b" />

The webpage was hosted using Nginx and the images were fetched from the S3 bucket.

---

# Day 3 – Nginx Failure Testing

## 26. Stop Nginx Service

<img width="975" height="480" alt="image" src="https://github.com/user-attachments/assets/e55353b8-2d54-4fde-8a90-3aaf6bfa292e" />

The Nginx service was intentionally stopped on one EC2 instance to simulate server failure.

---

## 27. ALB Health Check Failure

<img width="975" height="220" alt="image" src="https://github.com/user-attachments/assets/1395a47d-13ff-4bab-8618-092d5b64b5ec" />

The ALB detected the unhealthy Nginx instance through its health check.

---

## 28. Auto Scaling Recovery

<img width="975" height="268" alt="image" src="https://github.com/user-attachments/assets/779cbe55-d6a8-468c-bd1a-45d3fc8a55f9" />

The Auto Scaling Group launched and maintained healthy EC2 instances after the failure.

---

## 29. CPU Load Testing

<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/ec355c13-51e2-4de8-8c85-6c9626aa9742" />

CPU utilization was increased to test the Auto Scaling policy.

---

## 30. Auto Scaling During Load

<img width="975" height="330" alt="image" src="https://github.com/user-attachments/assets/81f7deaf-ded5-472d-b1cb-02a3af31abec" />
<img width="975" height="325" alt="image" src="https://github.com/user-attachments/assets/4f126cb9-6361-48ef-9ef5-bea8b8024d7e" />

The Auto Scaling Group increased capacity based on the configured scaling policy.

---

# Day 4 – Bastion Host & Path-Based Routing

## 31. Private Nginx Servers

<img width="975" height="271" alt="image" src="https://github.com/user-attachments/assets/d58e3f05-2ee0-45cd-a746-62b178448b7f" />

Two Nginx servers were configured in private subnets.

---

## 32. Configure Nginx Ninja1

<img width="975" height="723" alt="image" src="https://github.com/user-attachments/assets/5e00528e-1a99-4813-b1e5-37df4794f055" />

The first Nginx server was configured with the `/ninja1` path and Image-1.

---

## 33. Configure Nginx Ninja2

<img width="975" height="247" alt="image" src="https://github.com/user-attachments/assets/6a8a5a32-bc3c-4da6-8a40-015dfec7be7b" />

The second Nginx server was configured with the `/ninja2` path and Image-2.

---

## 34. Create Target Groups

<img width="975" height="247" alt="image" src="https://github.com/user-attachments/assets/272d7ac2-22d2-49a4-aeca-4a72ef700e0f" />

Two HTTP target groups were created for the two Nginx servers.

---

## 35. Create Application Load Balancer

<img width="975" height="520" alt="image" src="https://github.com/user-attachments/assets/d31d33be-dbda-4c02-8e9a-9e5ce7ce0893" />

An Application Load Balancer was created across the public subnets.

---

## 36. Configure Path-Based Routing

<img width="975" height="327" alt="image" src="https://github.com/user-attachments/assets/6dcd7683-5c06-442b-b0ac-7dcfa2e1476b" />

Path-based listener rules were configured:

- `/ninja1` → Nginx Server 1
- `/ninja2` → Nginx Server 2

---

## 37. Verify Ninja1 Routing

<img width="975" height="135" alt="image" src="https://github.com/user-attachments/assets/80507bd3-fc5b-4bf5-b1cb-59ec6f81eb88" />

The `/ninja1` path successfully routed traffic to the first private Nginx server.

---

## 38. Verify Ninja2 Routing

<img width="975" height="126" alt="image" src="https://github.com/user-attachments/assets/17161b81-f4d2-4b6c-992d-5f7c7746f108" />

The `/ninja2` path successfully routed traffic to the second private Nginx server.

---

# Day 5 – S3 & IAM Access Control

## 39. Create S3 Environment Folders

<img width="975" height="390" alt="image" src="https://github.com/user-attachments/assets/bbb7b7ec-d225-4177-866e-711d85585dec" />

Separate `prod` and `nonprod` folders were created inside the S3 bucket.

---

## 40. Create Custom IAM Policy

<img width="975" height="313" alt="image" src="https://github.com/user-attachments/assets/b346a453-0fff-4b75-81f8-280de424402a" />

Custom IAM policies were created to control access to the S3 environments.

---

## 41. Configure Non-Prod Access

<img width="975" height="512" alt="image" src="https://github.com/user-attachments/assets/4cb220ab-b5f3-4c8b-9a12-7287c9079a04" />

A dedicated IAM policy was configured for controlled access to the non-prod environment.

---

## 42. Configure Prod Access

<img width="975" height="527" alt="image" src="https://github.com/user-attachments/assets/80bf6638-8a75-492b-88ae-7accd8fd1ad6" />

A separate policy was configured for controlled production access.

---

## 43. Verify S3 & IAM Access

<img width="975" height="187" alt="image" src="https://github.com/user-attachments/assets/b05bdf73-a37a-44b6-8e2d-a33e8a80e3c2" />
<img width="975" height="176" alt="image" src="https://github.com/user-attachments/assets/6f502a44-1560-40d8-8b03-f0e05bafb8a3" />
<img width="975" height="180" alt="image" src="https://github.com/user-attachments/assets/a0358fee-e9e6-4d31-aaf7-bb6d42d3a339" />

S3 and IAM access restrictions were verified successfully for the required environments.

---

# Final Result

The Nginx infrastructure was successfully implemented with:

- VPC
- Public and Private Subnets
- Internet Gateway
- Route Tables
- Security Groups
- Nginx EC2 Instances
- Nginx AMIs
- Application Load Balancer
- Target Groups
- Launch Template
- Auto Scaling Group
- S3
- AWS CLI
- IAM Policies
- Bastion Host
- Path-Based Routing
- Nginx Failure Testing
- Auto Scaling Testing

## Terraform / AWS CLI

AWS infrastructure and configuration were performed using the AWS environment and AWS CLI where required.

## Conclusion

The Nginx infrastructure was successfully configured with load balancing, high availability, auto scaling, S3 integration, failure recovery, path-based routing, and IAM-based access control.
