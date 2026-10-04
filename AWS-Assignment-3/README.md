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

![VPC](images/01-vpc.png)

A VPC named `assignment3-vpc` was created with CIDR `10.0.0.0/16`.

---

## 2. Create Public and Private Subnets

![Subnets](images/02-subnets.png)

Four subnets were created across two Availability Zones, including two public and two private subnets.

---

## 3. Create Internet Gateway

![Internet Gateway](images/03-internet-gateway.png)

An Internet Gateway was created and attached to the VPC for internet connectivity.

---

## 4. Configure Route Tables

![Route Tables](images/04-route-tables.png)

Public and private route tables were configured and associated with their respective subnets.

---

## 5. Create Security Groups

![Security Groups](images/05-security-groups.png)

Separate Security Groups were created for the ALB, Bastion Host, and Nginx servers.

---

## 6. Launch Nginx Base Instance

![Nginx Base Instance](images/06-nginx-base-instance.png)

An Ubuntu EC2 instance was launched as the base Nginx server.

---

## 7. Install Nginx

![Nginx Welcome Page](images/07-nginx-welcome.png)

Nginx was installed and the default welcome page was verified successfully.

---

## 8. Create Nginx AMI-1

![AMI-1](images/08-ami-1.png)

An AMI was created from the base Nginx instance.

---

## 9. Create Nginx Version 1

![Nginx V1](images/09-nginx-v1.png)

Nginx Version 1 was launched from AMI-1 and verified successfully.

---

## 10. Customize Nginx Version 1

![Nginx V1 Webpage](images/10-nginx-v1-webpage.png)

The Nginx welcome page was customized with the Devashish AWS, DevOps and Cloud Infrastructure webpage.

---

## 11. Create Nginx AMI-2

![AMI-2](images/11-ami-2.png)

A second AMI was created containing the customized Nginx webpage.

---

## 12. Launch Nginx Version 2

![Nginx V2](images/12-nginx-v2.png)

Nginx Version 2 was launched from the customized AMI-2.

---

## 13. Verify Nginx Version 2

![Nginx V2 Webpage](images/13-nginx-v2-webpage.png)

The upgraded Nginx Version 2 webpage was verified successfully.

---

## 14. Create Target Group

![Target Group](images/14-target-group.png)

A target group was created for the Nginx EC2 instances.

---

## 15. Register Nginx Instances

![Registered Targets](images/15-registered-targets.png)

The Nginx EC2 instances were registered with the target group and health checks were verified.

---

## 16. Create Application Load Balancer

![Application Load Balancer](images/16-alb.png)

An internet-facing Application Load Balancer was created across two Availability Zones.

---

## 17. Verify ALB Traffic

![ALB Traffic](images/17-alb-traffic.png)

The ALB successfully routed traffic to the Nginx servers.

---

## 18. Verify Load Balancing

![Load Balancing](images/18-load-balancing.png)

Requests were distributed across different Nginx instances and both Nginx versions were observed during testing.

---

## 19. Create Launch Template

![Launch Template](images/19-launch-template.png)

A Launch Template was created using the Nginx AMI for Auto Scaling.

---

## 20. Create Auto Scaling Group

![Auto Scaling Group](images/20-auto-scaling-group.png)

An Auto Scaling Group was created using the Launch Template.

---

## 21. Verify Auto Scaling Instances

![ASG Instances](images/21-asg-instances.png)

The Auto Scaling Group successfully maintained healthy EC2 instances across Availability Zones.

---

# Day 2 – Nginx Web Hosting with S3

## 22. Create GitHub Repository

![GitHub Repository](images/22-github-repository.png)

A GitHub repository was created to maintain the Nginx webpage and image files.

---

## 23. Upload Images to S3

![S3 Upload](images/23-s3-upload.png)

The webpage images were uploaded to an S3 bucket using AWS CLI from an EC2 instance.

---

## 24. Verify S3 Images

![S3 Images](images/24-s3-images.png)

The uploaded image files were verified in the S3 bucket.

---

## 25. Host Webpage Using Nginx and S3

![Nginx S3 Webpage](images/25-nginx-s3-webpage.png)

The webpage was hosted using Nginx and the images were fetched from the S3 bucket.

---

# Day 3 – Nginx Failure Testing

## 26. Stop Nginx Service

![Nginx Failure](images/26-nginx-failure.png)

The Nginx service was intentionally stopped on one EC2 instance to simulate server failure.

---

## 27. ALB Health Check Failure

![ALB Health Check](images/27-alb-health-check.png)

The ALB detected the unhealthy Nginx instance through its health check.

---

## 28. Auto Scaling Recovery

![ASG Recovery](images/28-asg-recovery.png)

The Auto Scaling Group launched and maintained healthy EC2 instances after the failure.

---

## 29. CPU Load Testing

![CPU Utilization](images/29-cpu-utilization.png)

CPU utilization was increased to test the Auto Scaling policy.

---

## 30. Auto Scaling During Load

![Auto Scaling Load Test](images/30-auto-scaling-load.png)

The Auto Scaling Group increased capacity based on the configured scaling policy.

---

# Day 4 – Bastion Host & Path-Based Routing

## 31. Private Nginx Servers

![Private Nginx Servers](images/31-private-nginx-servers.png)

Two Nginx servers were configured in private subnets.

---

## 32. Configure Nginx Ninja1

![Ninja1](images/32-ninja1.png)

The first Nginx server was configured with the `/ninja1` path and Image-1.

---

## 33. Configure Nginx Ninja2

![Ninja2](images/33-ninja2.png)

The second Nginx server was configured with the `/ninja2` path and Image-2.

---

## 34. Create Target Groups

![Day 4 Target Groups](images/34-target-groups.png)

Two HTTP target groups were created for the two Nginx servers.

---

## 35. Create Application Load Balancer

![Day 4 ALB](images/35-day4-alb.png)

An Application Load Balancer was created across the public subnets.

---

## 36. Configure Path-Based Routing

![ALB Listener Rules](images/36-listener-rules.png)

Path-based listener rules were configured:

- `/ninja1` → Nginx Server 1
- `/ninja2` → Nginx Server 2

---

## 37. Verify Ninja1 Routing

![Ninja1 Routing](images/37-ninja1-routing.png)

The `/ninja1` path successfully routed traffic to the first private Nginx server.

---

## 38. Verify Ninja2 Routing

![Ninja2 Routing](images/38-ninja2-routing.png)

The `/ninja2` path successfully routed traffic to the second private Nginx server.

---

# Day 5 – S3 & IAM Access Control

## 39. Create S3 Environment Folders

![S3 Folders](images/39-s3-folders.png)

Separate `prod` and `nonprod` folders were created inside the S3 bucket.

---

## 40. Create Custom IAM Policy

![IAM Policy](images/40-iam-policy.png)

Custom IAM policies were created to control access to the S3 environments.

---

## 41. Configure Non-Prod Access

![Non-Prod IAM](images/41-nonprod-iam.png)

A dedicated IAM policy was configured for controlled access to the non-prod environment.

---

## 42. Configure Prod Access

![Prod IAM](images/42-prod-iam.png)

A separate policy was configured for controlled production access.

---

## 43. Verify S3 & IAM Access

![S3 IAM Access](images/43-s3-iam-access.png)

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
