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

---

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

---

# Files

Assignment2/
│── UserManager.sh
│── README.md

---

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

---

## Team Member Access

All users belonging to the same team should have read and execute access to the home directories of fellow team members.

This allows users from the same team to access the required home directory.

---

## Other Users

Users outside the team should have only execute access according to the assignment permission requirement.

---

# Shared Directories

Every user's home directory contains two shared directories:

## team

The `team` directory is used for sharing files between members of the same team.

Same team members should have full access to this directory.

## ninja

The `ninja` directory is used as a common shared directory for all Ninja users.

All Ninja users should have full access to this directory.

---

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

---

# Creating UserManager.sh

First, create the UserManager.sh file using nano or vim.

### Using nano

nano UserManager.sh

### Using vim

vim UserManager.sh

The Bash script is then written inside the file.

### Basic Script Header

#!/bin/bash

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the creation of UserManager.sh using nano or vim.

---

# Give Executable Permission

Before executing the script, executable permission needs to be given.

### Command

chmod +x UserManager.sh

Alternatively, the PDF demonstrates:

chmod 777 UserManager.sh

Check the permissions:

ls -l UserManager.sh

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing chmod and the executable permissions of UserManager.sh.

---

# Part A - Team Management

## 1. Add a Ninja Team

The `addTeam` operation is used to create a new team.

A team is simulated using a Linux group.

### Command

./UserManager.sh addTeam amigo

Another team can be created using:

./UserManager.sh addTeam unixkings

### Output

Team 'amigo' created

Team 'unixkings' created

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the creation of two teams.

---

# 2. Add a User Under a Team

The `addUser` operation is used to create a user and assign the user to a team.

### Command

./UserManager.sh addUser Rakesh amigo

Another user can be added:

./UserManager.sh addUser Sandeep unixkings

### Output

User 'Rakesh' added to team 'amigo'

User 'Sandeep' added to team 'unixkings'

The script also creates the user's home directory and the required shared directories.

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing users being added to their respective teams.

---

# 3. User Home Directory

After adding a user, a home directory is created for that user.

For example:

/home/Rakesh

Inside the home directory:

/home/Rakesh/team

/home/Rakesh/ninja

The same structure is created for other users.

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the user's home directory structure.

---

# 4. Team Shared Directory

The `team` directory is used for sharing data between members of the same team.

Example:

/home/Rakesh/team

Users belonging to the same team are given full access to the team directory.

---

# 5. Ninja Shared Directory

The `ninja` directory is used as a common shared directory for all Ninja users.

Example:

/home/Rakesh/ninja

All Ninja users are provided access to this directory according to the assignment requirements.

---

# Directory Structure Verification

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

[ADD SCREENSHOT HERE]

Screenshot showing the /home directory structure using the tree command.

---

# Part B - Additional Features

## 6. Change User Password

The `changePasswd` operation changes the password of an existing user.

### Command

sudo ./UserManager.sh changePasswd user1

The script asks for the new password and confirmation.

### Example Output

New password:
Retype new password:

passwd: password updated successfully

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the password change operation.

---

# 7. Change User Shell

The `changeShell` operation changes the login shell of a user.

### Command

sudo ./UserManager.sh changeShell user1 /bin/bash

### Output

Shell for 'user1' set to '/bin/bash'

The shell can be verified using:

grep user1 /etc/passwd

or:

getent passwd user1

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the user shell being changed.

---

# 8. List Users

The `ls User` operation displays the users managed by the system.

### Command

sudo ./UserManager.sh ls User

### Example Output

Rakesh team=amigo shell=/bin/bash
ubuntu team=ubuntu shell=/bin/bash
user1 team=team1 shell=/bin/bash
user2 team=team2 shell=/bin/bash

The output shows the username, team, and shell information.

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the list of users.

---

# 9. List Teams

The `ls Team` operation displays the available teams and their members.

### Command

sudo ./UserManager.sh ls Team

### Example Output

amigo: Rakesh
team1: user1
team2: user2

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the list of teams and their members.

---

# 10. Delete a User

The `delUser` operation is used to delete an existing user.

### Command

sudo ./UserManager.sh delUser user1

### Output

User 'user1' deleted

The PDF demonstrates deleting `user1` and then verifying that the user no longer appears in the user list. :contentReference[oaicite:2]{index=2}

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the deletion of the user.

---

# 11. Delete a Team

The `delTeam` operation is used to delete an existing team.

### Command

sudo ./UserManager.sh delTeam team1

### Output

Team 'team1' deleted

The team is removed after verifying that it is no longer required by any remaining user.

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the deletion of the team.

---

# 12. Verify User and Team Deletion

After deleting a user and team, the `ls User` and `ls Team` commands can be used to verify the deletion.

### Commands

sudo ./UserManager.sh ls User

sudo ./UserManager.sh ls Team

### Example Output

Rakesh team=amigo shell=/bin/bash
ubuntu team=ubuntu shell=/bin/bash
user2 team=team2 shell=/bin/bash

amigo: Rakesh
team2: user2

The deleted user and team should no longer appear in the output.

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing verification that the deleted user and team are no longer listed.

---

# Important Linux Commands Used

Command        Purpose

useradd        Create a Linux user
userdel        Delete a Linux user
groupadd       Create a Linux group
groupdel       Delete a Linux group
passwd         Change a user's password
usermod        Modify user properties
chmod          Change file and directory permissions
chown          Change ownership
mkdir          Create directories
ls             List files and directories
tree           Display directory structure
grep           Search for specific text
awk            Extract and process text
getent         Display user/group information
nano           Edit the shell script
vim            Edit the shell script

---

# Script Usage

The general syntax of the UserManager utility is:

sudo ./UserManager.sh <command> <arguments>

---

# Available Commands

## Add Team

sudo ./UserManager.sh addTeam <teamname>

Example:

sudo ./UserManager.sh addTeam amigo

---

## Add User

sudo ./UserManager.sh addUser <username> <teamname>

Example:

sudo ./UserManager.sh addUser Rakesh amigo

---

## Delete Team

sudo ./UserManager.sh delTeam <teamname>

Example:

sudo ./UserManager.sh delTeam amigo

---

## Delete User

sudo ./UserManager.sh delUser <username>

Example:

sudo ./UserManager.sh delUser Rakesh

---

## Change Password

sudo ./UserManager.sh changePasswd <username>

Example:

sudo ./UserManager.sh changePasswd Rakesh

---

## Change Shell

sudo ./UserManager.sh changeShell <username> <shell>

Example:

sudo ./UserManager.sh changeShell Rakesh /bin/bash

---

## List Users

sudo ./UserManager.sh ls User

---

## List Teams

sudo ./UserManager.sh ls Team

---

# Screenshots

## 1. UserManager.sh Creation

[ADD SCREENSHOT HERE]

Screenshot showing UserManager.sh being created using nano or vim.

---

## 2. Executable Permission

[ADD SCREENSHOT HERE]

Screenshot showing chmod command and executable permission.

---

## 3. Team Creation

[ADD SCREENSHOT HERE]

Screenshot showing addTeam command creating team1 and team2.

---

## 4. User Creation

[ADD SCREENSHOT HERE]

Screenshot showing users being added to their respective teams.

---

## 5. Home Directory Structure

[ADD SCREENSHOT HERE]

Screenshot showing the /home directory with user directories and team/ninja shared directories using tree.

---

## 6. List Users

[ADD SCREENSHOT HERE]

Screenshot showing the output of:

sudo ./UserManager.sh ls User

---

## 7. List Teams

[ADD SCREENSHOT HERE]

Screenshot showing the output of:

sudo ./UserManager.sh ls Team

---

## 8. Change Password

[ADD SCREENSHOT HERE]

Screenshot showing the changePasswd operation and successful password update.

---

## 9. Change Shell

[ADD SCREENSHOT HERE]

Screenshot showing the changeShell operation.

---

## 10. Delete User

[ADD SCREENSHOT HERE]

Screenshot showing the delUser operation.

---

## 11. Delete Team

[ADD SCREENSHOT HERE]

Screenshot showing the delTeam operation.

---

## 12. Verify Deletion

[ADD SCREENSHOT HERE]

Screenshot showing ls User and ls Team after deleting the user and team.

---

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

---

# Conclusion

This assignment provided practical knowledge of Linux user and group management using Bash Shell Script.

By creating the UserManager utility, different Linux commands were combined into a single command-line utility.

The assignment helped in understanding how users and groups can be managed in Linux and how permissions can be configured to provide controlled access between team members and other users.

It also provided practical experience with Linux commands such as useradd, userdel, groupadd, groupdel, passwd, usermod, chmod, chown, mkdir, ls, tree, grep, and awk.

---

# Author

Devashish Sathawane

Assignment 2 - UserManager Utility