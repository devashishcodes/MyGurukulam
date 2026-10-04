# AWS Assignment 1 – Load Balancer & Auto Scaling Group

**Assignment Done By:** Devashish Prakash Sathawane

## Objective

The goal of this assignment is to design and implement AWS infrastructure for deploying a Spring 3 Hibernate application with high availability, scalability, and security.

The application is deployed on private EC2 servers and accessed through an Application Load Balancer.

---

# 1. Create VPC

![Create VPC](images/01-create-vpc.png)

A VPC named `Assignment01-VPC` was created to provide the network environment for all AWS resources.

---

# 2. Create 4 Subnets

![Create Subnets](images/02-create-subnets.png)

Four subnets were created across two Availability Zones:

- 2 Public Subnets
- 2 Private Subnets

The public subnets are used for the Load Balancer and the private subnets are used for the application servers.

---

# 3. Create Internet Gateway

![Internet Gateway](images/03-internet-gateway.png)

An Internet Gateway was created and attached to the VPC to provide internet connectivity to the public subnets.

---

# 4. Create Public Route Table

![Public Route Table](images/04-public-route-table.png)

A public route table was created with a default route through the Internet Gateway.

The two public subnets were associated with the public route table.

---

# 5. Allocate Elastic IP

![Elastic IP](images/05-elastic-ip.png)

An Elastic IP address was allocated for the NAT Gateway.

---

# 6. Create NAT Gateway

![NAT Gateway](images/06-nat-gateway.png)

A NAT Gateway was created in a public subnet using the allocated Elastic IP.

The NAT Gateway allows resources in the private subnets to access the internet for required outbound operations.

---

# 7. Create Private Route Table

![Private Route Table](images/07-private-route-table.png)

A private route table was created with the NAT Gateway as the default route.

The two private subnets were associated with the private route table.

---

# 8. Create ALB Security Group

![ALB Security Group](images/08-alb-security-group.png)

A Security Group named `Assignment01-ALB-SG` was created for the Application Load Balancer.

It controls inbound and outbound traffic to the Load Balancer.

---

# 9. Create Application Server Security Group

![Application Security Group](images/09-application-security-group.png)

A Security Group named `Assignment01-App-SG` was created for the private application servers.

The application servers are placed inside private subnets.

---

# 10. Create Target Group

![Target Group](images/10-target-group.png)

A target group named `Assignment01-TG-8080` was created for the application servers.

The target group is used by the Application Load Balancer to forward traffic to the application instances.

---

# 11. Create Application Load Balancer

![Application Load Balancer](images/11-load-balancer.png)

An Application Load Balancer named `Assignment01-ALB` was created using the public subnets.

The ALB distributes incoming application traffic to the private application servers.

---

# 12. Create Launch Template

![Launch Template](images/12-launch-template.png)

A Launch Template named `Assignment01-LaunchTemplate` was created for launching the application EC2 instances.

The Launch Template contains the required instance configuration, AMI, security group, and other instance settings.

---

# 13. Create Auto Scaling Group

![Auto Scaling Group](images/13-auto-scaling-group.png)

An Auto Scaling Group named `Assignment01-ASG` was created using the Launch Template.

The ASG was configured to maintain the required number of application instances.

---

# 14. Launch Application Instances

![Application Instances](images/14-application-instances.png)

The Auto Scaling Group successfully launched two EC2 instances in the private subnets.

The instances are distributed across Availability Zones for high availability.

---

# 15. Create Database Security Group

![Database Security Group](images/15-database-security-group.png)

A database Security Group named `Assignment01-DB-SG` was created.

The Security Group allows MySQL traffic on port `3306` from the application tier.

---

# 16. Create RDS DB Subnet Group

![RDS DB Subnet Group](images/16-rds-subnet-group.png)

An RDS DB subnet group was configured using the private subnets in two Availability Zones.

This allows the database to remain inside the private network.

---

# 17. Create Amazon RDS MySQL Database

![RDS MySQL](images/17-rds-mysql.png)

An Amazon RDS MySQL database was successfully created inside the `Assignment01-VPC`.

---

# 18. Verify RDS Connectivity

![RDS Connectivity](images/18-rds-connectivity.png)

The RDS configuration was verified with private connectivity using MySQL port `3306`.

The database uses:

- Assignment01-VPC
- Private DB Subnet Group
- Assignment01-DB-SG
- MySQL Port 3306

---

# 19. Configure Launch Template User Data

![Launch Template User Data](images/19-launch-template-user-data.png)

User Data was configured in the EC2 Launch Template to automatically:

- Clone the Spring3Hibernate application
- Configure the application
- Configure Amazon RDS MySQL connectivity
- Build the application
- Run the application

A new Launch Template version was created with the configured User Data.

---

# 20. Update Auto Scaling Group

![Updated Auto Scaling Group](images/20-updated-asg.png)

The Auto Scaling Group was updated to use the latest Launch Template version.

The ASG was configured with:

- Desired Capacity: 2
- Minimum Capacity: 2
- Maximum Capacity: 4

---

# 21. Configure Instance Refresh

![Instance Refresh Configuration](images/21-instance-refresh-config.png)

The Auto Scaling Group Instance Refresh configuration was checked before performing the rolling update.

---

# 22. Start Instance Refresh

![Start Instance Refresh](images/22-start-instance-refresh.png)

The Instance Refresh was started using a rolling replacement strategy.

The configuration included:

- 100% Minimum Healthy Capacity
- 300-second Instance Warmup
- Skip Matching Enabled

---

# 23. Instance Refresh Progress

![Instance Refresh Progress](images/23-instance-refresh-progress.png)

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

![Higher Memory Launch Template](images/26-higher-memory-launch-template.png)

To resolve the memory issue, a new Launch Template version was created using a higher-memory `m7i-flex.large` instance type.

No storage change was required because the issue was related to memory.

---

# 27. Update ASG and Perform Rolling Replacement

![ASG Rolling Replacement](images/27-asg-rolling-replacement.png)

The Auto Scaling Group was updated to use the new Launch Template version.

An Instance Refresh was started using a rolling replacement strategy to replace the existing instances with the higher-memory instances.

---

# 28. Verify Instance Refresh

![Instance Refresh Status](images/28-instance-refresh-status.png)

The Instance Refresh status was verified after updating the Auto Scaling Group.

The refreshed instances were successfully processed.

---

# 29. Verify Target Group Health

![Healthy Target Group](images/29-target-group-healthy.png)

The Application Load Balancer target group was checked and the application instances were shown as healthy.

---

# 30. Verify Application Through ALB

![Application Through ALB](images/30-application-alb.png)

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
