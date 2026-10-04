# AWS Assignment 1 – Load Balancer & Auto Scaling Group

**Assignment Done By:** Devashish Prakash Sathawane

## Objective

The goal of this assignment is to design and implement AWS infrastructure for deploying a Spring 3 Hibernate application with high availability, scalability, and security.

The application is deployed on private EC2 servers and accessed through an Application Load Balancer.

---

# 1. Create VPC

<img width="975" height="718" alt="image" src="https://github.com/user-attachments/assets/6a45ae40-f060-4ce5-8c52-57c85d37ee85" />

A VPC named `Assignment01-VPC` was created to provide the network environment for all AWS resources.

---

# 2. Create 4 Subnets

<img width="975" height="329" alt="image" src="https://github.com/user-attachments/assets/e833cee5-5903-4c16-9893-5f840f05f9e7" />

Four subnets were created across two Availability Zones:

- 2 Public Subnets
- 2 Private Subnets

The public subnets are used for the Load Balancer and the private subnets are used for the application servers.

---

# 3. Create Internet Gateway

<img width="975" height="348" alt="image" src="https://github.com/user-attachments/assets/e85ff348-a7cb-41b9-b3b1-60db756c875b" />

An Internet Gateway was created and attached to the VPC to provide internet connectivity to the public subnets.

---

# 4. Create Public Route Table

<img width="975" height="460" alt="image" src="https://github.com/user-attachments/assets/413d1926-ca37-4ef8-9a98-05e3500de9a0" />

A public route table was created with a default route through the Internet Gateway.

The two public subnets were associated with the public route table.

<img width="975" height="380" alt="image" src="https://github.com/user-attachments/assets/9bc41a1d-ec9b-4e6a-af17-037caff6c65a" />

---

# 5. Allocate Elastic IP

<img width="975" height="275" alt="image" src="https://github.com/user-attachments/assets/014704f7-53b7-436d-9d4a-4d6ad303997c" />

An Elastic IP address was allocated for the NAT Gateway.

---

# 6. Create NAT Gateway

<img width="975" height="228" alt="image" src="https://github.com/user-attachments/assets/00f6e202-c339-4d6d-819c-748e9574cb1d" />

A NAT Gateway was created in a public subnet using the allocated Elastic IP.

The NAT Gateway allows resources in the private subnets to access the internet for required outbound operations.

---

# 7. Create Private Route Table

<img width="975" height="374" alt="image" src="https://github.com/user-attachments/assets/23499b37-2737-4f7e-aea6-79fc4b1b74ee" />

A private route table was created with the NAT Gateway as the default route.

The two private subnets were associated with the private route table.

<img width="975" height="375" alt="image" src="https://github.com/user-attachments/assets/ed119f0b-501f-47e9-9f19-accaebc0eeb0" />

---

# 8. Create ALB Security Group

<img width="975" height="377" alt="image" src="https://github.com/user-attachments/assets/682e8ce3-37f8-4a22-8fbe-0397efed1aa7" />

A Security Group named `Assignment01-ALB-SG` was created for the Application Load Balancer.

It controls inbound and outbound traffic to the Load Balancer.

---

# 9. Create Application Server Security Group

<img width="975" height="385" alt="image" src="https://github.com/user-attachments/assets/fba34714-6750-421d-abbd-14271011cf37" />

A Security Group named `Assignment01-App-SG` was created for the private application servers.

The application servers are placed inside private subnets.

---

# 10. Create Target Group

<img width="975" height="461" alt="image" src="https://github.com/user-attachments/assets/438d0e20-8186-4c06-a7dd-b3a919c2e8a7" />

A target group named `Assignment01-TG-8080` was created for the application servers.

The target group is used by the Application Load Balancer to forward traffic to the application instances.

---

# 11. Create Application Load Balancer

<img width="975" height="443" alt="image" src="https://github.com/user-attachments/assets/853dc69b-36cb-4e79-aa16-7189c15c67d2" />

An Application Load Balancer named `Assignment01-ALB` was created using the public subnets.

The ALB distributes incoming application traffic to the private application servers.

---

# 12. Create Launch Template

<img width="975" height="438" alt="image" src="https://github.com/user-attachments/assets/57ab976d-4b60-4ef5-8952-749b4206a633" />

A Launch Template named `Assignment01-LaunchTemplate` was created for launching the application EC2 instances.

The Launch Template contains the required instance configuration, AMI, security group, and other instance settings.

---

# 13. Create Auto Scaling Group

<img width="975" height="459" alt="image" src="https://github.com/user-attachments/assets/57a43500-121f-4900-b2dd-1a8c172b81c0" />

An Auto Scaling Group named `Assignment01-ASG` was created using the Launch Template.

The ASG was configured to maintain the required number of application instances.

---

# 14. Launch Application Instances

<img width="975" height="252" alt="image" src="https://github.com/user-attachments/assets/9cf84204-0cd8-4a9b-91c7-50e2ddccb695" />

The Auto Scaling Group successfully launched two EC2 instances in the private subnets.

The instances are distributed across Availability Zones for high availability.

---

# 15. Create Database Security Group

<img width="975" height="413" alt="image" src="https://github.com/user-attachments/assets/2937f12c-c7c2-4638-82b3-d989afce5c67" />

A database Security Group named `Assignment01-DB-SG` was created.

The Security Group allows MySQL traffic on port `3306` from the application tier.

---

# 16. Create RDS DB Subnet Group

<img width="975" height="496" alt="image" src="https://github.com/user-attachments/assets/94a5bc9c-b2f1-4ab3-82da-6f6190304d86" />

An RDS DB subnet group was configured using the private subnets in two Availability Zones.

This allows the database to remain inside the private network.

---

# 17. Create Amazon RDS MySQL Database

<img width="975" height="471" alt="image" src="https://github.com/user-attachments/assets/b739daad-0d74-422e-9840-3b6024eaaa57" />

An Amazon RDS MySQL database was successfully created inside the `Assignment01-VPC`.

---

# 18. Verify RDS Connectivity

<img width="975" height="473" alt="image" src="https://github.com/user-attachments/assets/df4da13a-d54b-490a-be76-6abdef1aa764" />
<img width="975" height="521" alt="image" src="https://github.com/user-attachments/assets/654944e3-7580-4fe5-89c3-f8e19a13b992" />

The RDS configuration was verified with private connectivity using MySQL port `3306`.

The database uses:

- Assignment01-VPC
- Private DB Subnet Group
- Assignment01-DB-SG
- MySQL Port 3306

---

# 19. Configure Launch Template User Data

<img width="975" height="525" alt="image" src="https://github.com/user-attachments/assets/c00bc8a5-eae7-4b59-b4f7-49caa1f82db5" />

User Data was configured in the EC2 Launch Template to automatically:

- Clone the Spring3Hibernate application
- Configure the application
- Configure Amazon RDS MySQL connectivity
- Build the application
- Run the application

A new Launch Template version was created with the configured User Data.

---

# 20. Update Auto Scaling Group

<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/a780c85f-4dc2-4bf4-b45d-b02c2a262e58" />

The Auto Scaling Group was updated to use the latest Launch Template version.

The ASG was configured with:

- Desired Capacity: 2
- Minimum Capacity: 2
- Maximum Capacity: 4

---

# 21. Configure Instance Refresh

<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/7fcc485d-3977-4c2a-a00d-d8c0f86988b7" />

The Auto Scaling Group Instance Refresh configuration was checked before performing the rolling update.

---

# 22. Start Instance Refresh

<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/ae729ece-1548-4cea-ab4d-45e90ffcf0bc" />

The Instance Refresh was started using a rolling replacement strategy.

The configuration included:

- 100% Minimum Healthy Capacity
- 300-second Instance Warmup
- Skip Matching Enabled

---

# 23. Instance Refresh Progress

<img width="975" height="368" alt="image" src="https://github.com/user-attachments/assets/1ee4536b-1f75-460d-8c3d-a0f67fd52499" />

The Instance Refresh completed with 100% of the required instances updated and no instances remaining to update.

---

# 24. Auto Scaling Group Activity

![ASG Activity History](images/24-asg-activity-history.png)

The Auto Scaling Group activity history showed EC2 instance replacement triggered by ELB health check failures.

---

# 25. Application Deployment Issue

![Application Deployment Issue](images/25-application-deployment-issue.png)

During application deployment, the EC2 application instances were becoming unhealthy because the Docker image build was failing due to insufficient memory.

The Maven build inside the Docker container generated an Out of Memory error, which caused the Docker build to terminate.

As a result, the application Docker image and container were not created and the ALB health checks were failing.

---

# 26. Create Higher Memory Launch Template Version

<img width="975" height="368" alt="image" src="https://github.com/user-attachments/assets/d5c315e7-30d8-4185-9b8d-a8e7e16d55e8" />

To resolve the memory issue, a new Launch Template version was created using a higher-memory `m7i-flex.large` instance type.

No storage change was required because the issue was related to memory.

---

# 27. Update ASG and Perform Rolling Replacement

<img width="975" height="240" alt="image" src="https://github.com/user-attachments/assets/68cb1f44-6b48-428c-ae3f-43534e58aa9b" />

The Auto Scaling Group was updated to use the new Launch Template version.

An Instance Refresh was started using a rolling replacement strategy to replace the existing instances with the higher-memory instances.

---

# 28. Verify Instance Refresh

<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/f395359d-7fb1-429d-b054-2b58c8825f8a" />

The Instance Refresh status was verified after updating the Auto Scaling Group.

The refreshed instances were successfully processed.

---

# 29. Verify Target Group Health

<img width="975" height="525" alt="image" src="https://github.com/user-attachments/assets/7a66cef4-a5bd-4bf0-a2f1-77532938b50b" />

The Application Load Balancer target group was checked and the application instances were shown as healthy.

---

# 30. Verify Application Through ALB

<img width="975" height="524" alt="image" src="https://github.com/user-attachments/assets/7530ab5e-b76e-4cbb-84e1-5630a6dfa490" />

The Spring 3 Hibernate application was successfully accessed through the Application Load Balancer DNS.

The application page displayed the available options:

- List of Employees
- Add Employee
- Upload File
- List Image

---

# Final Architecture

The final infrastructure contains:

- VPC
- 2 Public Subnets
- 2 Private Subnets
- Internet Gateway
- Public Route Table
- NAT Gateway
- Private Route Table
- ALB Security Group
- Application Security Group
- Database Security Group
- Application Load Balancer
- Target Group
- Launch Template
- Auto Scaling Group
- Private EC2 Instances
- Amazon RDS MySQL
- RDS DB Subnet Group

---

# Application Flow

The application traffic follows this flow:

Internet
↓
Application Load Balancer
↓
Target Group
↓
Private EC2 Instances
↓
Amazon RDS MySQL

Private EC2 instances use the NAT Gateway for required outbound internet access.

---

# Auto Scaling Configuration

The Auto Scaling Group was configured with:

- Minimum Instances: 2
- Desired Instances: 2
- Maximum Instances: 4

The ASG uses the Launch Template to launch and replace application instances.

---

# High Availability

High availability was implemented by:

- Using multiple Availability Zones
- Running application instances in private subnets
- Using an Application Load Balancer
- Using an Auto Scaling Group
- Maintaining multiple healthy application instances
- Using Amazon RDS for the database layer

---

# Security

Security was implemented using separate Security Groups for:

- Application Load Balancer
- Application Servers
- Database

The application servers and database remain inside private subnets.

---

# AWS Services Used

- Amazon VPC
- Amazon EC2
- Application Load Balancer
- Auto Scaling Group
- Amazon RDS MySQL
- NAT Gateway
- Internet Gateway
- Security Groups
- Launch Template
- Target Group

---

# Final Result

The Spring 3 Hibernate application was successfully deployed on AWS using a highly available and scalable infrastructure.

The final setup includes an Application Load Balancer, Auto Scaling Group, private application servers, NAT Gateway, and Amazon RDS MySQL.

The application was successfully accessed through the ALB after the EC2 instances became healthy.

# Conclusion

The Load Balancer and Auto Scaling infrastructure was successfully implemented for the Spring 3 Hibernate application.

The infrastructure provides high availability, scalability, private application servers, controlled network access, and database connectivity using Amazon RDS.
