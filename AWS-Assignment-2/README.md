# AWS Assignment 2 – Deployment Strategies

**Assignment Done By:** Devashish Prakash Sathawane

## Objective

Learn about various deployment strategies and implement them while integrating Amazon S3 for asset management and deployment artifacts.

### Deployment Strategies

1. Recreate Deployment
2. Rolling Deployment
3. Blue-Green Deployment
4. A/B Deployment
5. Canary Deployment

---

# 1. Create S3 Bucket

![Create S3 Bucket](images/01-create-s3-bucket.png)

An S3 bucket named `assignment2-devashish-2026` was created for storing application deployment artifacts and assets.

---

# 2. Create 3 Folders in S3

![S3 Folders](images/02-s3-folders.png)

Three folders were created inside the S3 bucket:

- `assets`
- `deployment`
- `logs`

---

# 3. Create V1 Folder

![Deployment V1 Folder](images/03-deployment-v1.png)

A `v1` folder was created inside the `deployment` folder for storing the Version 1 application.

---

# 4. Upload Version 1 Application

![Upload V1](images/04-upload-v1.png)

The Version 1 `index.html` application file was uploaded to the S3 `deployment/v1` folder.

---

# 5. Launch EC2 Instance

![EC2 Instance](images/05-ec2-instance.png)

An EC2 instance named `Assignment2-Recreate-V1` was launched for implementing the Recreate Deployment strategy.

---

# 6. Install Apache2

![Apache2 Installation](images/06-apache2-install.png)

Apache2 was installed on the EC2 instance and the service was verified successfully.

---

# 7. Install AWS CLI

![AWS CLI](images/07-aws-cli.png)

AWS CLI was installed on the EC2 instance to access the S3 deployment artifacts.

---

# 8. Create IAM Role

![IAM Role](images/08-iam-role.png)

An IAM role named `Assignment2-EC2-S3-Role` was created to allow the EC2 instance to access S3 resources securely.

---

# 9. Attach IAM Role to EC2

![IAM Role Attached](images/09-iam-role-attached.png)

The IAM role was successfully attached to the EC2 instance.

This allowed the EC2 instance to access S3 without using access keys or secret keys.

---

# 10. Verify S3 Access

![S3 Access](images/10-s3-access.png)

S3 access was successfully verified from the EC2 instance using AWS CLI.

---

# 11. Retrieve Version 1 Artifact

![Retrieve V1](images/11-retrieve-v1.png)

The Version 1 application artifact was successfully retrieved from S3 using AWS CLI.

    aws s3 cp s3://assignment2-devashish-2026/deployment/v1/index.html .

---

# 12. Deploy Version 1

![Version 1 Deployment](images/12-v1-deployment.png)

The Version 1 application was successfully deployed on the EC2 instance using the artifact retrieved from Amazon S3.

---

# 13. Create AMI from Version 1

![AMI V1](images/13-ami-v1.png)

An Amazon Machine Image was created from the Version 1 EC2 instance for the Recreate Deployment strategy.

---

# 14. Upload Version 2 Application

![Upload V2](images/14-upload-v2.png)

The Version 2 `index.html` application artifact was uploaded to the S3 `deployment/v2` folder.

---

# 15. Stop Version 1 Instance

![Stop V1](images/15-stop-v1.png)

The Version 1 EC2 instance was stopped before deploying the updated application version as part of the Recreate Deployment strategy.

---

# 16. Restart EC2 Instance

![Restart EC2](images/16-restart-ec2.png)

The EC2 instance was restarted to continue the Recreate Deployment process.

---

# 17. Retrieve Version 2 Artifact

![Retrieve V2](images/17-retrieve-v2.png)

The Version 2 application artifact was successfully retrieved from S3 using AWS CLI.

    aws s3 cp s3://assignment2-devashish-2026/deployment/v2/index.html .

---

# 18. Deploy Version 2

![Version 2 Deployment](images/18-v2-deployment.png)

The Version 2 application was copied to the Apache2 web directory and deployed successfully.

    sudo cp index.html /var/www/html/index.html

---

# 19. Verify Version 2 Application

![Version 2 Application](images/19-v2-application.png)

The Version 2 application was successfully accessed through the browser.

### Recreate Deployment – COMPLETE ✅

The Recreate Deployment strategy was successfully implemented and verified.

---

# 20. Create Version 1 Launch Template

![Launch Template V1](images/20-launch-template-v1.png)

A Version 1 EC2 Launch Template was created for the Rolling Deployment strategy.

---

# 21. Create Auto Scaling Group

![Auto Scaling Group V1](images/21-asg-v1.png)

An Auto Scaling Group was configured with two healthy EC2 instances using the Version 1 launch template.

---

# 22. Create Launch Template Version 2

![Launch Template V2](images/22-launch-template-v2.png)

A new Launch Template Version 2 was created with the updated application configuration.

---

# 23. Update Auto Scaling Group

![Updated Auto Scaling Group](images/23-asg-updated.png)

The Auto Scaling Group was updated to use Launch Template Version 2.

---

# 24. Start Instance Refresh

![Instance Refresh](images/24-instance-refresh.png)

An Instance Refresh was started to update the existing EC2 instances with the new Version 2 launch template.

---

# 25. Rolling Deployment Completed

![Rolling Deployment Complete](images/25-rolling-deployment-complete.png)

The Instance Refresh completed successfully with 100% of the Auto Scaling Group instances updated.

---

# 26. Verify Healthy Instances

![Healthy ASG](images/26-healthy-asg.png)

After the Rolling Deployment, two EC2 instances were InService and healthy across different Availability Zones.

---

# 27. Verify Version 2 Application

![Rolling Deployment V2](images/27-rolling-v2.png)

The Version 2 application was successfully verified after the Rolling Deployment.

### Rolling Deployment – COMPLETE ✅

The Rolling Deployment strategy was successfully implemented using:

- Launch Template Version 1
- Auto Scaling Group
- Launch Template Version 2
- Instance Refresh
- Version 2 Application

---

# Deployment Strategy Status

| Deployment Strategy | Status |
|---|---|
| Recreate Deployment | ✅ Completed |
| Rolling Deployment | ✅ Completed |
| Blue-Green Deployment | ⏳ Not Implemented |
| A/B Deployment | ⏳ Not Implemented |
| Canary Deployment | ⏳ Not Implemented |

---

# AWS Services Used

- Amazon EC2
- Amazon S3
- AWS IAM
- Amazon Machine Image (AMI)
- Auto Scaling Group
- EC2 Launch Template
- AWS CLI
- Apache2

---

# Final Result

The following deployment strategies were successfully implemented:

### Recreate Deployment ✅

- S3 deployment artifacts
- EC2 instance
- IAM role
- AWS CLI
- Version 1 deployment
- AMI creation
- Version 2 deployment
- Recreate process

### Rolling Deployment ✅

- Launch Template Version 1
- Auto Scaling Group
- Two healthy EC2 instances
- Launch Template Version 2
- ASG update
- Instance Refresh
- 100% instance update
- Version 2 verification

The application deployment artifacts were stored in Amazon S3 and securely retrieved from the EC2 instance using the attached IAM role.

# Conclusion

Recreate Deployment and Rolling Deployment were successfully implemented and verified using Amazon EC2, Amazon S3, AWS IAM, AMI, Auto Scaling Group, Launch Templates, AWS CLI, and Instance Refresh.
