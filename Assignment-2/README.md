# Assignment 2 Submitted by Devashish Sathawane

## Project Name

UserManager Utility using Bash Shell Script

## Description

This assignment focuses on creating a UserManager utility using Bash Shell Script.

The UserManager utility simulates team and user management on a Linux system. It creates teams as groups and users under those teams. It also manages permissions for user home directories and shared directories.

The utility provides operations to:

- Create a Ninja Team
- Add a user under a team
- Set permissions for user home directories
- Create shared team and ninja directories
- Change user password
- Change user shell
- Delete a user
- Delete a team
- List users
- List teams

The main purpose of this assignment is to understand Linux users, groups, permissions, ownership, home directories, and basic shell scripting.

The assignment was implemented using Bash Shell Script and Linux user/group management commands.

# Requirements

The following are required to execute this assignment:

- Ubuntu/Linux
- Bash Shell
- Root or sudo access
- Bash scripting
- nano or vim
- useradd
- userdel
- groupadd
- groupdel
- passwd
- usermod
- chmod
- chown
- mkdir
- ls
- tree
- awk
- grep

# Files

Assignment2/
│── UserManager.sh
│── README.md

# User and Team Permission Requirements

The following permission constraints are implemented in the assignment.

## User Home Directory

Every user should have:

- Read permission
- Write permission
- Execute permission

for their own home directory.

In Linux permission format:

755

The owner gets:

rwx

The group gets:

r-x

Others get:

r-x


## Team Member Access

All users belonging to the same team should have read and execute access to the home directories of fellow team members.

This allows users from the same team to access the required home directory.

## Other Users

Users outside the team should have only execute access according to the assignment permission requirement.

# Shared Directories

Every user's home directory contains two shared directories:

## team

The `team` directory is used for sharing files between members of the same team.

Same team members should have full access to this directory.

## ninja

The `ninja` directory is used as a common shared directory for all Ninja users.

All Ninja users should have full access to this directory.

# Expected Directory Structure

After creating users, the resultant structure is:

/home

├── Rakesh
│   ├── team
│   └── ninja
│
└── Sandeep
    ├── team
    └── ninja

Each user has their own home directory and two shared directories.

# Creating UserManager.sh

First, create the UserManager.sh file using nano or vim.

### Using vim
vim UserManager.sh

The Bash script is then written inside the file.

### Screenshot
<img width="1096" height="56" alt="Screenshot 2026-08-08 233129" src="https://github.com/user-attachments/assets/b0d7a7ea-2082-451d-9e9d-6b728442b669" />


Screenshot showing the creation of UserManager.sh using nano or vim.

# Give Executable Permission
Before executing the script, executable permission needs to be given.

### Command

chmod +x UserManager.sh
Alternatively, the Screenshot demonstrates:
chmod 777 UserManager.sh

### Screenshot
<img width="1232" height="65" alt="Screenshot 2026-08-08 233225" src="https://github.com/user-attachments/assets/c1691b12-b3de-4345-a800-08fb1635532c" />

Screenshot showing chmod and the executable permissions of UserManager.sh.

# Part A - Team Management

## 1. Add a Ninja Team

The `addTeam` operation is used to create a new team.
A team is simulated using a Linux group.

### Command

./UserManager.sh addTeam team1
Another team can be created using:
./UserManager.sh addTeam team2

### Output

Team 'team1' created
Team 'team2' created

### Screenshot
<img width="1496" height="192" alt="Screenshot 2026-08-08 233357" src="https://github.com/user-attachments/assets/b440fa64-c769-4150-b92f-4f79a6f0a045" />

Screenshot showing the creation of two teams.

# 2. Add a User Under a Team

The `addUser` operation is used to create a user and assign the user to a team.

### Command

./UserManager.sh addUser user1 team1
Another user can be added:
./UserManager.sh addUser user2 team2

### Screenshot
<img width="1523" height="425" alt="Screenshot 2026-08-08 233508" src="https://github.com/user-attachments/assets/e6d2a485-4091-4b72-978f-cffc5e5204cf" />

Screenshot showing users being added to their respective teams.

# 3. Directory Structure Verification

The `tree` command can be used to verify the directory structure.

### Command

sudo tree /home

### Example Output

/home
├── user1
│   ├── ninja
│   └── team
└── user2
    ├── ninja
    └── team

### Screenshot
<img width="1032" height="427" alt="Screenshot 2026-08-08 233635" src="https://github.com/user-attachments/assets/0ef677d7-b0aa-42aa-995e-49b80c0dd63c" />

Screenshot showing the /home directory structure using the tree command.

# Part B - Additional Features

## 4. Change User Password

The `changePasswd` operation changes the password of an existing user.

### Command
sudo ./UserManager.sh changePasswd user1

The script asks for the new password and confirmation.

### Example Output

New password:
Retype new password:

passwd: password updated successfully

### Screenshot
<img width="1527" height="185" alt="Screenshot 2026-08-08 233925" src="https://github.com/user-attachments/assets/2573c68e-e2f3-46af-83cb-cb9ff7bf4082" />

# 5. Change User Shell

The `changeShell` operation changes the login shell of a user.

### Command

sudo ./UserManager.sh changeShell user1 /bin/bash

### Screenshot
<img width="1525" height="120" alt="Screenshot 2026-08-08 234023" src="https://github.com/user-attachments/assets/4f48658a-c497-4da2-b675-4e3acacce3c5" />


# 8. List Users

The `ls User` operation displays the users managed by the system.

### Command

sudo ./UserManager.sh ls User

### Screenshot
<img width="1361" height="247" alt="Screenshot 2026-08-08 234054" src="https://github.com/user-attachments/assets/43b0b910-226f-4ebc-96ce-8af1dee9855a" />

# 9. List Teams

The `ls Team` operation displays the available teams and their members.

### Command

sudo ./UserManager.sh ls Team

### Screenshot
<img width="1365" height="200" alt="Screenshot 2026-08-08 234122" src="https://github.com/user-attachments/assets/408b6c58-8ab2-40b7-8f08-aa211e77cc9d" />


# 10. Delete a User

The `delUser` operation is used to delete an existing user.

### Command
sudo ./UserManager.sh delUser user1

### Screenshot
<img width="1520" height="140" alt="Screenshot 2026-08-08 234215" src="https://github.com/user-attachments/assets/fb486161-f951-47ec-abb5-e04dbe1c452a" />


# 11. Delete a Team

The `delTeam` operation is used to delete an existing team.

### Command
sudo ./UserManager.sh delTeam team1

### Screenshot
<img width="1517" height="97" alt="Screenshot 2026-08-08 234253" src="https://github.com/user-attachments/assets/f596361d-b6c0-43d8-b44e-bf395b40556d" />

# 12. Verify User and Team Deletion

After deleting a user and team, the `ls User` and `ls Team` commands can be used to verify the deletion.

### Commands

sudo ./UserManager.sh ls User
sudo ./UserManager.sh ls Team

### Screenshot
<img width="1397" height="327" alt="Screenshot 2026-08-08 234329" src="https://github.com/user-attachments/assets/251087f0-99bd-46fb-838e-13bbe6b6eef6" />

# Result

The UserManager utility was successfully created using Bash Shell Script.

The utility can create and manage simulated Ninja teams and users. It creates user home directories along with the required `team` and `ninja` shared directories.

The utility also provides additional features such as changing user passwords, changing user shells, deleting users, deleting teams, and listing users and teams.

The assignment demonstrates practical Linux concepts including:

- User management
- Group management
- File and directory permissions
- Ownership
- Shared directories
- User home directories
- Bash scripting
- Command-line arguments
- Case statements


# Conclusion

This assignment provided practical knowledge of Linux user and group management using Bash Shell Script.

By creating the UserManager utility, different Linux commands were combined into a single command-line utility.

The assignment helped in understanding how users and groups can be managed in Linux and how permissions can be configured to provide controlled access between team members and other users.

It also provided practical experience with Linux commands such as useradd, userdel, groupadd, groupdel, passwd, usermod, chmod, chown, mkdir, ls, tree, grep, and awk.

# Author
Devashish Sathawane

Assignment 2 - UserManager Utility
