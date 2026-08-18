# Ansible Assignment 1 – UserManager (Project Management System)

Submitted by Devashish Sathawane

Using Ansible ad-hoc commands to set up teams, users, password policies, sudo access, and a full directory/permission structure for a project management system.

## Setup

```bash
mkdir ansible
cd ansible/
vim ansible.cfg
vim mykey.pem
chmod 400 mykey.pem
vim inventory
```
![Setup folder](screenshots/ans1-01-setup-folder.png)
![cfg, key, inventory files](screenshots/ans1-02-cfg-key-inventory.png)

```bash
cat ansible.cfg
cat inventory
```
![Check cfg and inventory](screenshots/ans1-03-cat-cfg-inventory.png)

### Test connection

```bash
ansible all -m ping
```
![Ping test](screenshots/ans1-04-ping-test.png)

## Team Structure: Create Groups

```bash
ansible all -m group -a "name=dev-team state=present" -b
ansible all -m group -a "name=devops-team state=present" -b
ansible all -m group -a "name=admin-group state=present" -b
```
![Create groups](screenshots/ans1-05-create-groups.png)

```bash
ansible all -m shell -a "getent group dev-team devops-team admin-group"
```
![Verify groups](screenshots/ans1-06-verify-groups.png)

## Advanced User Management

### Create dev-team users (UID 2000-2002)

```bash
ansible all -m user -a "name=devuser1 uid=2000 group=dev-team shell=/bin/bash create_home=yes state=present" -b
ansible all -m user -a "name=devuser2 uid=2001 group=dev-team shell=/bin/bash create_home=yes state=present" -b
ansible all -m user -a "name=devuser3 uid=2002 group=dev-team shell=/bin/bash create_home=yes state=present" -b
```
![Create dev-team users](screenshots/ans1-07-create-devusers.png)

### Create devops-team users (UID 2003-2005)

```bash
ansible all -m user -a "name=devopsuser1 uid=2003 group=devops-team shell=/bin/bash create_home=yes state=present" -b
ansible all -m user -a "name=devopsuser2 uid=2004 group=devops-team shell=/bin/bash create_home=yes state=present" -b
ansible all -m user -a "name=devopsuser3 uid=2005 group=devops-team shell=/bin/bash create_home=yes state=present" -b
```
![Create devops-team users](screenshots/ans1-08-create-devopsusers.png)

### Create admin-group users (UID 2006-2008)

```bash
ansible all -m user -a "name=adminuser1 uid=2006 group=admin-group shell=/bin/bash create_home=yes state=present" -b
ansible all -m user -a "name=adminuser2 uid=2007 group=admin-group shell=/bin/bash create_home=yes state=present" -b
ansible all -m user -a "name=adminuser3 uid=2008 group=admin-group shell=/bin/bash create_home=yes state=present" -b
```
![Create admin-group users](screenshots/ans1-09-create-adminusers.png)

### Verify all 9 users

```bash
ansible all -m shell -a "getent passwd | awk -F: '\$3 >= 2000 && \$3 <= 2008'"
```
![Verify all users](screenshots/ans1-10-verify-all-users.png)

### Set different login shells per team role

```bash
ansible all -m command -a "cat /etc/shells"
```
![Check available shells](screenshots/ans1-11-check-shells-available.png)

Admin users set to `/bin/sh`, dev and devops kept on `/bin/bash`:

```bash
ansible all -m shell -a "getent passwd | awk -F: '\$3 >= 2000 && \$3 <= 2008'"
```
![Verify shells set](screenshots/ans1-12-verify-shells-set.png)

### Password policy with expiry (max 30 days)

```bash
ansible all -m command -a "chage -M 30 devuser1" -b
ansible all -m command -a "chage -M 30 devuser2" -b
ansible all -m command -a "chage -M 30 devuser3" -b
ansible all -m command -a "chage -M 30 devopsuser1" -b
ansible all -m command -a "chage -M 30 devopsuser2" -b
ansible all -m command -a "chage -M 30 devopsuser3" -b
ansible all -m command -a "chage -M 30 adminuser1" -b
ansible all -m command -a "chage -M 30 adminuser2" -b
ansible all -m command -a "chage -M 30 adminuser3" -b
```
![Set password expiry](screenshots/ans1-13-password-expiry-set.png)

```bash
ansible all -m command -a "chage -l devuser1" -b
```
![Check chage devuser1](screenshots/ans1-14-check-chage-devuser1.png)

```bash
ansible all -m command -a "chage -l devuser1" -b
ansible all -m command -a "chage -l devopsuser1" -b
ansible all -m command -a "chage -l adminuser1" -b
```
![Check chage for all teams](screenshots/ans1-15-check-chage-all.png)

### Sudo access for admin-group

```bash
ansible all -m copy -a "content='%admin-group ALL=(ALL) ALL\n' dest=/etc/sudoers.d/admin-group mode=0440" -b
ansible all -m command -a "visudo -c" -b
```
![Sudo access for admin-group](screenshots/ans1-16-sudo-admin-group.png)

## Advanced Directory Structure

### Personal workspace for dev-team

```bash
ansible all -m file -a "path=/home/devuser1/workspace state=directory owner=devuser1 group=dev-team mode=0750" -b
ansible all -m file -a "path=/home/devuser2/workspace state=directory owner=devuser2 group=dev-team mode=0750" -b
ansible all -m file -a "path=/home/devuser3/workspace state=directory owner=devuser3 group=dev-team mode=0750" -b
```
![Dev team workspace](screenshots/ans1-17-dev-workspace.png)

### Personal workspace for devops-team

```bash
ansible all -m file -a "path=/home/devopsuser1/workspace state=directory owner=devopsuser1 group=devops-team mode=0750" -b
ansible all -m file -a "path=/home/devopsuser2/workspace state=directory owner=devopsuser2 group=devops-team mode=0750" -b
ansible all -m file -a "path=/home/devopsuser3/workspace state=directory owner=devopsuser3 group=devops-team mode=0750" -b
```
![Devops team workspace](screenshots/ans1-18-devops-workspace.png)

### Personal workspace for admin-group

```bash
ansible all -m file -a "path=/home/adminuser1/workspace state=directory owner=adminuser1 group=admin-group mode=0750" -b
ansible all -m file -a "path=/home/adminuser2/workspace state=directory owner=adminuser2 group=admin-group mode=0750" -b
ansible all -m file -a "path=/home/adminuser3/workspace state=directory owner=adminuser3 group=admin-group mode=0750" -b
```
![Admin group workspace](screenshots/ans1-19-admin-workspace.png)

### Verify all workspaces

```bash
ansible all -m shell -a "ls -ld /home/*/workspace" -b
```
![Verify workspaces](screenshots/ans1-20-verify-workspaces.png)

### Team collaboration directories

```bash
ansible all -m file -a "path=/team-data state=directory owner=root group=root mode=0755" -b
ansible all -m file -a "path=/team-data/dev-team state=directory owner=root group=dev-team mode=0775" -b
ansible all -m file -a "path=/team-data/devops-team state=directory owner=root group=devops-team mode=0775" -b
ansible all -m file -a "path=/team-data/admin-area state=directory owner=root group=admin-group mode=0770" -b
```
![Team data dirs](screenshots/ans1-21-team-data-dirs.png)

```bash
ansible all -m shell -a "ls -ld /team-data /team-data/*" -b
```
![Verify team-data](screenshots/ans1-22-verify-team-data.png)

### Team directory ACLs (team full access, others read-only)

```bash
ansible all -m command -a "which setfacl"
```
![Check setfacl available](screenshots/ans1-23-check-setfacl.png)

```bash
ansible all -m shell -a "setfacl -m g:dev-team:rwx,g:devops-team:r-x,g:admin-group:r-x /team-data/dev-team" -b
ansible all -m shell -a "setfacl -m g:devops-team:rwx,g:dev-team:r-x,g:admin-group:r-x /team-data/devops-team" -b
```
![Set team ACL](screenshots/ans1-24-set-team-acl.png)

```bash
ansible all -m shell -a "getfacl /team-data/dev-team /team-data/devops-team" -b
```
![Verify team ACL](screenshots/ans1-25-verify-team-acl.png)

### Project-specific directories (WebApp, API, Mobile)

```bash
ansible all -m file -a "path=/projects state=directory owner=root group=root mode=0755" -b
ansible all -m file -a "path=/projects/WebApp state=directory owner=root group=root mode=0755" -b
ansible all -m file -a "path=/projects/API state=directory owner=root group=root mode=0755" -b
ansible all -m file -a "path=/projects/Mobile state=directory owner=root group=root mode=0755" -b
```
![Project dirs](screenshots/ans1-26-project-dirs.png)

```bash
ansible all -m shell -a "ls -ld /projects /projects/*" -b
```
![Verify project dirs](screenshots/ans1-27-verify-project-dirs.png)

### Assign project leads (full access owner)

```bash
ansible all -m file -a "path=/projects/WebApp owner=devuser1 group=dev-team" -b
ansible all -m file -a "path=/projects/API owner=devopsuser1 group=devops-team" -b
ansible all -m file -a "path=/projects/Mobile owner=devuser2 group=dev-team" -b
```
![Assign project leads](screenshots/ans1-28-project-leads.png)

### Project ACLs (assigned teams read/write, others read-only)

```bash
ansible all -m shell -a "setfacl -m g:dev-team:rwx,g:devops-team:r-x,g:admin-group:r-x /projects/WebApp" -b
ansible all -m shell -a "setfacl -m g:devops-team:rwx,g:dev-team:r-x,g:admin-group:r-x /projects/API" -b
ansible all -m shell -a "setfacl -m g:dev-team:rwx,g:devops-team:r-x,g:admin-group:r-x /projects/Mobile" -b
```
![Set project ACL](screenshots/ans1-29-project-acl.png)

```bash
ansible all -m shell -a "getfacl /projects/WebApp /projects/API /projects/Mobile" -b
```
![Verify project ACL](screenshots/ans1-30-verify-project-acl.png)

### Shared resources (all teams read/write)

```bash
ansible all -m file -a "path=/shared-resources state=directory owner=root group=root mode=0775" -b
ansible all -m shell -a "setfacl -m g:dev-team:rwx,g:devops-team:rwx,g:admin-group:rwx /shared-resources" -b
```
![Shared resources](screenshots/ans1-31-shared-resources.png)

```bash
ansible all -m shell -a "getfacl /shared-resources" -b
```
![Verify shared-resources ACL](screenshots/ans1-32-verify-shared-acl.png)

### Archive directory (all users read-only, mode 0555)

```bash
ansible all -m file -a "path=/archive state=directory owner=root group=root mode=0755" -b
ansible all -m file -a "path=/archive/WebApp state=directory owner=root group=root mode=0555" -b
ansible all -m file -a "path=/archive/API state=directory owner=root group=root mode=0555" -b
ansible all -m file -a "path=/archive/Mobile state=directory owner=root group=root mode=0555" -b
```
![Archive dirs](screenshots/ans1-33-archive-dirs.png)

```bash
ansible all -m shell -a "ls -ld /archive/*" -b
```
![Verify archive](screenshots/ans1-34-verify-archive.png)

## Verification: Permission Matrix Test

Testing that admin-area is only accessible by admin-group, and that read-only areas like archive block writes:

```bash
ansible all -m shell -a "sudo -u adminuser1 ls -ld /team-data/admin-area"
ansible all -m shell -a "sudo -u devuser1 ls /team-data/admin-area"
ansible all -m shell -a "sudo -u devuser1 touch /team-data/dev-team/test.txt"
ansible all -m shell -a "sudo -u devopsuser1 touch /team-data/dev-team/test2.txt"
ansible all -m shell -a "sudo -u devuser1 touch /shared-resources/dev-test.txt"
ansible all -m shell -a "sudo -u devopsuser1 touch /shared-resources/devops-test.txt"
ansible all -m shell -a "sudo -u devuser1 touch /archive/WebApp/test.txt"
```
Devops user is correctly denied writing into dev-team's directory, and no one can write into archive (read-only) - permission matrix working as expected.
![Permission matrix test](screenshots/ans1-35-permission-matrix-test.png)

### Final directory structure

```bash
ansible all -m shell -a "find /team-data /projects /shared-resources /archive -maxdepth 2 -type d | sort" -b
```
![Final structure](screenshots/ans1-36-final-structure.png)

### Final sudoers and ACL summary

```bash
ansible all -m command -a "cat /etc/sudoers.d/admin-group" -b
```
![Sudoers content](screenshots/ans1-37-sudoers-content.png)

```bash
ansible all -m shell -a "getfacl /team-data/dev-team /team-data/devops-team" -b
ansible all -m shell -a "getfacl /projects/WebApp /projects/API /projects/Mobile" -b
ansible all -m shell -a "getfacl /shared-resources" -b
```
![Final ACL summary 1](screenshots/ans1-38-getfacl-summary1.png)
![Final ACL summary 2](screenshots/ans1-39-getfacl-summary2.png)
