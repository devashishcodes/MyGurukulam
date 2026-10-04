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

<img width="975" height="525" alt="image" src="https://github.com/user-attachments/assets/8b771976-fc76-48c5-9632-92bda7ca1aad" />

An S3 bucket named `assignment2-devashish-2026` was created for storing application deployment artifacts and assets.

---

# 2. Create 3 Folders in S3

<img width="975" height="523" alt="image" src="https://github.com/user-attachments/assets/02a17b27-415f-46aa-b2fa-ae5adbd71062" />

Three folders were created inside the S3 bucket:

- `assets`
- `deployment`
- `logs`

---

# 3. Create V1 Folder

<img width="975" height="349" alt="image" src="https://github.com/user-attachments/assets/95be357a-a96d-4f0e-9407-9e8b023f9a04" />

A `v1` folder was created inside the `deployment` folder for storing the Version 1 application.

---

# 4. Upload Version 1 Application

<img width="975" height="524" alt="image" src="https://github.com/user-attachments/assets/f31437b1-3f0f-41b1-935d-bd096a133fc5" />

The Version 1 `index.html` application file was uploaded to the S3 `deployment/v1` folder.

---

# 5. Launch EC2 Instance

<img width="975" height="269" alt="image" src="https://github.com/user-attachments/assets/02bce297-6c9d-4e88-a362-bf8a96677046" />

An EC2 instance named `Assignment2-Recreate-V1` was launched for implementing the Recreate Deployment strategy.

---

# 6. Install Apache2

<img width="975" height="399" alt="image" src="https://github.com/user-attachments/assets/7b910041-2fd1-46cf-8e3f-6088826d95e6" />

Apache2 was installed on the EC2 instance and the service was verified successfully.

---

# 7. Install AWS CLI

<img width="975" height="174" alt="image" src="https://github.com/user-attachments/assets/c7aed215-5e8a-4c1e-99d8-b04600e418e7" />

AWS CLI was installed on the EC2 instance to access the S3 deployment artifacts.

---

# 8. Create IAM Role

<img width="975" height="253" alt="image" src="https://github.com/user-attachments/assets/dc066c5b-15e1-42a4-a22c-1c1d82cb629d" />

An IAM role named `Assignment2-EC2-S3-Role` was created to allow the EC2 instance to access S3 resources securely.

---

# 9. Attach IAM Role to EC2

<img width="975" height="520" alt="image" src="https://github.com/user-attachments/assets/5d98dc19-e839-44fb-989e-1c16022d05e0" />

The IAM role was successfully attached to the EC2 instance.

This allowed the EC2 instance to access S3 without using access keys or secret keys.

---

# 10. Verify S3 Access

<img width="975" height="114" alt="image" src="https://github.com/user-attachments/assets/e8d62ec2-dd50-42e1-b5fc-9b8b0498ab75" />

S3 access was successfully verified from the EC2 instance using AWS CLI.

---

# 11. Retrieve Version 1 Artifact

<img width="975" height="40" alt="image" src="https://github.com/user-attachments/assets/3827475e-8054-4f50-90e1-2035e3f94fe3" />

The Version 1 application artifact was successfully retrieved from S3 using AWS CLI.

    aws s3 cp s3://assignment2-devashish-2026/deployment/v1/index.html .

---

# 12. Deploy Version 1

<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/d3fc10c0-76e4-43ff-ba0f-956a9d8610a1" />

The Version 1 application was successfully deployed on the EC2 instance using the artifact retrieved from Amazon S3.

---

# 13. Create AMI from Version 1

<img width="975" height="229" alt="image" src="https://github.com/user-attachments/assets/bdece9e2-a249-44ba-b7ec-51a868e5d699" />

An Amazon Machine Image was created from the Version 1 EC2 instance for the Recreate Deployment strategy.

---

# 14. Upload Version 2 Application

<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/0ebdfce3-d4d6-4a57-b63e-c212c02b568f" />

The Version 2 `index.html` application artifact was uploaded to the S3 `deployment/v2` folder.

---

# 15. Stop Version 1 Instance

<img width="975" height="269" alt="image" src="https://github.com/user-attachments/assets/39c8fb7c-b201-4962-9f6b-0cfa0e1e18ed" />

The Version 1 EC2 instance was stopped before deploying the updated application version as part of the Recreate Deployment strategy.

---

# 16. Restart EC2 Instance

<img width="975" height="248" alt="image" src="https://github.com/user-attachments/assets/96c2632e-c432-43f9-b49b-f5ef047c0caf" />

The EC2 instance was restarted to continue the Recreate Deployment process.

---

# 17. Retrieve Version 2 Artifact

<img width="975" height="138" alt="image" src="https://github.com/user-attachments/assets/a8460849-b55a-4ac8-9e68-553f064ca58f" />

The Version 2 application artifact was successfully retrieved from S3 using AWS CLI.

    aws s3 cp s3://assignment2-devashish-2026/deployment/v2/index.html .

---

# 18. Deploy Version 2

<img width="975" height="61" alt="image" src="https://github.com/user-attachments/assets/dea45c78-0de1-4325-80b4-0852a42b0082" />

The Version 2 application was copied to the Apache2 web directory and deployed successfully.

    sudo cp index.html /var/www/html/index.html

---

# 19. Verify Version 2 Application

<img width="975" height="524" alt="image" src="https://github.com/user-attachments/assets/a3e30e7d-3726-4133-89ec-50d6ac591879" />

The Version 2 application was successfully accessed through the browser.

### Recreate Deployment – COMPLETE ✅

The Recreate Deployment strategy was successfully implemented and verified.

---

# 20. Create Version 1 Launch Template

<img width="975" height="226" alt="image" src="https://github.com/user-attachments/assets/a634a335-be00-4c5d-8d0b-9877c09540ad" />

A Version 1 EC2 Launch Template was created for the Rolling Deployment strategy.

---

# 21. Create Auto Scaling Group

<img width="975" height="226" alt="image" src="https://github.com/user-attachments/assets/24751f5a-358f-49a3-ba50-884616cec7e4" />

An Auto Scaling Group was configured with two healthy EC2 instances using the Version 1 launch template.

---

# 22. Create Launch Template Version 2

<img width="975" height="247" alt="image" src="https://github.com/user-attachments/assets/0c38beb6-95a1-4fcc-b77a-ddeef2f25b0e" />

A new Launch Template Version 2 was created with the updated application configuration.

---

# 23. Update Auto Scaling Group

<img width="975" height="285" alt="image" src="https://github.com/user-attachments/assets/a78c8250-bc37-4e71-8f6c-0c68efa9d91f" />

The Auto Scaling Group was updated to use Launch Template Version 2.

---

# 24. Start Instance Refresh

<img width="975" height="521" alt="image" src="https://github.com/user-attachments/assets/d5df3bff-4f21-46a2-94a0-708619d5ea51" />

An Instance Refresh was started to update the existing EC2 instances with the new Version 2 launch template.

---

# 25. Verify Healthy Instances

<img width="975" height="283" alt="image" src="https://github.com/user-attachments/assets/e54868ca-7631-462f-bec1-b9f6c1d7b805" />

After the Rolling Deployment, two EC2 instances were InService and healthy across different Availability Zones.

---

# 26. Verify Version 2 Application

<img width="975" height="523" alt="image" src="https://github.com/user-attachments/assets/5f65e8e0-5f64-4077-a900-645cc2a34ef6" />

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
