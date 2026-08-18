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
<img width="975" height="82" alt="image" src="https://github.com/user-attachments/assets/78563c90-9a02-4fad-8b08-8c1eca5f0d04" />
<img width="975" height="133" alt="image" src="https://github.com/user-attachments/assets/79fb4306-500f-435b-b3d5-65bab31aa23b" />

```bash
cat ansible.cfg
cat inventory
```
<img width="975" height="352" alt="image" src="https://github.com/user-attachments/assets/3d929b39-1293-413b-9e2c-aaf3f3c9e47c" />

### Test connection

```bash
ansible all -m ping
```
<img width="975" height="238" alt="image" src="https://github.com/user-attachments/assets/b49dbeab-eafb-4fc7-a882-f964c3fcb621" />

## Team Structure: Create Groups

```bash
ansible all -m group -a "name=dev-team state=present" -b
ansible all -m group -a "name=devops-team state=present" -b
ansible all -m group -a "name=admin-group state=present" -b
```
<img width="975" height="671" alt="image" src="https://github.com/user-attachments/assets/992e5278-b692-4c30-ae35-b233eb9aca86" />

```bash
ansible all -m shell -a "getent group dev-team devops-team admin-group"
```
<img width="975" height="87" alt="image" src="https://github.com/user-attachments/assets/d1622b58-f73d-41dd-9ec0-eea23edb3f1f" />

## Advanced User Management

### Create dev-team users (UID 2000-2002)

```bash
ansible all -m user -a "name=devuser1 uid=2000 group=dev-team shell=/bin/bash create_home=yes state=present" -b
ansible all -m user -a "name=devuser2 uid=2001 group=dev-team shell=/bin/bash create_home=yes state=present" -b
ansible all -m user -a "name=devuser3 uid=2002 group=dev-team shell=/bin/bash create_home=yes state=present" -b
```
<img width="975" height="603" alt="image" src="https://github.com/user-attachments/assets/9a7e5edb-aa4e-4605-8dcc-e123422f6513" />

### Create devops-team users (UID 2003-2005)

```bash
ansible all -m user -a "name=devopsuser1 uid=2003 group=devops-team shell=/bin/bash create_home=yes state=present" -b
ansible all -m user -a "name=devopsuser2 uid=2004 group=devops-team shell=/bin/bash create_home=yes state=present" -b
ansible all -m user -a "name=devopsuser3 uid=2005 group=devops-team shell=/bin/bash create_home=yes state=present" -b
```
<img width="975" height="580" alt="image" src="https://github.com/user-attachments/assets/11df3c88-a7aa-4220-aa4e-91756f7fda9b" />

### Create admin-group users (UID 2006-2008)

```bash
ansible all -m user -a "name=adminuser1 uid=2006 group=admin-group shell=/bin/bash create_home=yes state=present" -b
ansible all -m user -a "name=adminuser2 uid=2007 group=admin-group shell=/bin/bash create_home=yes state=present" -b
ansible all -m user -a "name=adminuser3 uid=2008 group=admin-group shell=/bin/bash create_home=yes state=present" -b
```
<img width="975" height="578" alt="image" src="https://github.com/user-attachments/assets/679d8039-8567-4b3a-ba95-9c0fbefc0f2d" />

### Verify all 9 users

```bash
ansible all -m shell -a "getent passwd | awk -F: '\$3 >= 2000 && \$3 <= 2008'"
```
<img width="975" height="185" alt="image" src="https://github.com/user-attachments/assets/154dd1f9-0154-4e05-902c-8e8caf35b79d" />

### Set different login shells per team role

```bash
ansible all -m command -a "cat /etc/shells"
```
<img width="975" height="143" alt="image" src="https://github.com/user-attachments/assets/23f6f6fe-a046-4f82-82f9-9af714384d5c" />

Admin users set to `/bin/sh`, dev and devops kept on `/bin/bash`:

```bash
ansible all -m shell -a "getent passwd | awk -F: '\$3 >= 2000 && \$3 <= 2008'"
```
<img width="975" height="178" alt="image" src="https://github.com/user-attachments/assets/9d5f4b71-e516-4228-a3a7-45174e38474c" />

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
<img width="975" height="561" alt="image" src="https://github.com/user-attachments/assets/f4c4a0e2-8b50-407d-a044-0d8bd6b7c2f8" />

```bash
ansible all -m command -a "chage -l devuser1" -b
```
<img width="975" height="206" alt="image" src="https://github.com/user-attachments/assets/a32aa6d8-6e9f-4843-9534-e1262dabddf8" />

```bash
ansible all -m command -a "chage -l devuser1" -b
ansible all -m command -a "chage -l devopsuser1" -b
ansible all -m command -a "chage -l adminuser1" -b
```
<img width="975" height="602" alt="image" src="https://github.com/user-attachments/assets/a029be74-7c6e-40c5-82eb-e8aa47ed55c1" />

### Sudo access for admin-group

```bash
ansible all -m copy -a "content='%admin-group ALL=(ALL) ALL\n' dest=/etc/sudoers.d/admin-group mode=0440" -b
ansible all -m command -a "visudo -c" -b
```
<img width="975" height="309" alt="image" src="https://github.com/user-attachments/assets/17e6e8af-cf58-4b0b-a7f0-9a395cdfc7fd" />

## Advanced Directory Structure

### Personal workspace for dev-team

```bash
ansible all -m file -a "path=/home/devuser1/workspace state=directory owner=devuser1 group=dev-team mode=0750" -b
ansible all -m file -a "path=/home/devuser2/workspace state=directory owner=devuser2 group=dev-team mode=0750" -b
ansible all -m file -a "path=/home/devuser3/workspace state=directory owner=devuser3 group=dev-team mode=0750" -b
```
<img width="975" height="584" alt="image" src="https://github.com/user-attachments/assets/0220c8d5-02dd-4137-9919-da4455d96e43" />

### Personal workspace for devops-team

```bash
ansible all -m file -a "path=/home/devopsuser1/workspace state=directory owner=devopsuser1 group=devops-team mode=0750" -b
ansible all -m file -a "path=/home/devopsuser2/workspace state=directory owner=devopsuser2 group=devops-team mode=0750" -b
ansible all -m file -a "path=/home/devopsuser3/workspace state=directory owner=devopsuser3 group=devops-team mode=0750" -b
```
<img width="975" height="556" alt="image" src="https://github.com/user-attachments/assets/d650111c-6c28-42ad-b329-0ebfa52faa42" />

### Personal workspace for admin-group

```bash
ansible all -m file -a "path=/home/adminuser1/workspace state=directory owner=adminuser1 group=admin-group mode=0750" -b
ansible all -m file -a "path=/home/adminuser2/workspace state=directory owner=adminuser2 group=admin-group mode=0750" -b
ansible all -m file -a "path=/home/adminuser3/workspace state=directory owner=adminuser3 group=admin-group mode=0750" -b
```
<img width="975" height="567" alt="image" src="https://github.com/user-attachments/assets/232bede2-119b-4f12-9d16-0a2a0c767539" />

### Verify all workspaces

```bash
ansible all -m shell -a "ls -ld /home/*/workspace" -b
```
<img width="975" height="226" alt="image" src="https://github.com/user-attachments/assets/3bdce1a9-f83f-4359-b597-ad96750ea94a" />

### Team collaboration directories

```bash
ansible all -m file -a "path=/team-data state=directory owner=root group=root mode=0755" -b
ansible all -m file -a "path=/team-data/dev-team state=directory owner=root group=dev-team mode=0775" -b
ansible all -m file -a "path=/team-data/devops-team state=directory owner=root group=devops-team mode=0775" -b
ansible all -m file -a "path=/team-data/admin-area state=directory owner=root group=admin-group mode=0770" -b
```
<img width="975" height="973" alt="image" src="https://github.com/user-attachments/assets/f2fbdb67-fd72-40a6-8cbf-9bbddb68fdd6" />

```bash
ansible all -m shell -a "ls -ld /team-data /team-data/*" -b
```
<img width="975" height="122" alt="image" src="https://github.com/user-attachments/assets/d4d7f24c-05a7-4406-bbbf-7e600274c068" />

### Team directory ACLs (team full access, others read-only)

```bash
ansible all -m command -a "which setfacl"
```
<img width="975" height="71" alt="image" src="https://github.com/user-attachments/assets/ad2e020f-f06a-4790-92c9-e84ce9e026ba" />

```bash
ansible all -m shell -a "setfacl -m g:dev-team:rwx,g:devops-team:r-x,g:admin-group:r-x /team-data/dev-team" -b
ansible all -m shell -a "setfacl -m g:devops-team:rwx,g:dev-team:r-x,g:admin-group:r-x /team-data/devops-team" -b
```
<img width="975" height="67" alt="image" src="https://github.com/user-attachments/assets/aaa6a648-36d5-4330-844a-c3fb1ab3e843" />

```bash
ansible all -m shell -a "getfacl /team-data/dev-team /team-data/devops-team" -b
```
<img width="975" height="371" alt="image" src="https://github.com/user-attachments/assets/0a302cfa-0089-49ef-a9eb-bc3842d66e2b" />

### Project-specific directories (WebApp, API, Mobile)

```bash
ansible all -m file -a "path=/projects state=directory owner=root group=root mode=0755" -b
ansible all -m file -a "path=/projects/WebApp state=directory owner=root group=root mode=0755" -b
ansible all -m file -a "path=/projects/API state=directory owner=root group=root mode=0755" -b
ansible all -m file -a "path=/projects/Mobile state=directory owner=root group=root mode=0755" -b
```
<img width="975" height="979" alt="image" src="https://github.com/user-attachments/assets/77b253a3-d529-4668-95e1-e365ccb7bdb2" />

```bash
ansible all -m shell -a "ls -ld /projects /projects/*" -b
```
<img width="975" height="124" alt="image" src="https://github.com/user-attachments/assets/61cde161-1c4d-4008-a09e-3df20490311c" />

### Assign project leads (full access owner)

```bash
ansible all -m file -a "path=/projects/WebApp owner=devuser1 group=dev-team" -b
ansible all -m file -a "path=/projects/API owner=devopsuser1 group=devops-team" -b
ansible all -m file -a "path=/projects/Mobile owner=devuser2 group=dev-team" -b
```
<img width="975" height="755" alt="image" src="https://github.com/user-attachments/assets/2bf31caf-fc8f-4f0c-8075-9b7015a19279" />

### Project ACLs (assigned teams read/write, others read-only)

```bash
ansible all -m shell -a "setfacl -m g:dev-team:rwx,g:devops-team:r-x,g:admin-group:r-x /projects/WebApp" -b
ansible all -m shell -a "setfacl -m g:devops-team:rwx,g:dev-team:r-x,g:admin-group:r-x /projects/API" -b
ansible all -m shell -a "setfacl -m g:dev-team:rwx,g:devops-team:r-x,g:admin-group:r-x /projects/Mobile" -b
```
<img width="975" height="111" alt="image" src="https://github.com/user-attachments/assets/9e1ad70b-ffbb-46db-9f6b-e4e0ebd50d05" />

```bash
ansible all -m shell -a "getfacl /projects/WebApp /projects/API /projects/Mobile" -b
```
<img width="975" height="532" alt="image" src="https://github.com/user-attachments/assets/49e8f130-885d-4518-9187-6bd86cea7bc6" />

### Shared resources (all teams read/write)

```bash
ansible all -m file -a "path=/shared-resources state=directory owner=root group=root mode=0775" -b
ansible all -m shell -a "setfacl -m g:dev-team:rwx,g:devops-team:rwx,g:admin-group:rwx /shared-resources" -b
```
<img width="975" height="256" alt="image" src="https://github.com/user-attachments/assets/c2bb9f3c-15df-4c64-ab8a-e420e5a89e17" />

```bash
ansible all -m shell -a "getfacl /shared-resources" -b
```
<img width="975" height="257" alt="image" src="https://github.com/user-attachments/assets/3eb5e0f2-14ea-488e-9296-3d0ee9647892" />

### Archive directory (all users read-only, mode 0555)

```bash
ansible all -m file -a "path=/archive state=directory owner=root group=root mode=0755" -b
ansible all -m file -a "path=/archive/WebApp state=directory owner=root group=root mode=0555" -b
ansible all -m file -a "path=/archive/API state=directory owner=root group=root mode=0555" -b
ansible all -m file -a "path=/archive/Mobile state=directory owner=root group=root mode=0555" -b
```
<img width="975" height="982" alt="image" src="https://github.com/user-attachments/assets/9d925e8c-e190-4846-b4ac-fda1d17ccb3c" />

```bash
ansible all -m shell -a "ls -ld /archive/*" -b
```
<img width="975" height="115" alt="image" src="https://github.com/user-attachments/assets/5bc9a5b6-9649-4bbd-a545-63b3c06279c2" />

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
<img width="975" height="357" alt="image" src="https://github.com/user-attachments/assets/dd230573-bf07-4cfc-98a8-417e39d23638" />

### Final directory structure

```bash
ansible all -m shell -a "find /team-data /projects /shared-resources /archive -maxdepth 2 -type d | sort" -b
```
<img width="975" height="191" alt="image" src="https://github.com/user-attachments/assets/945abae7-c040-4ada-9b7a-9946baac4d95" />

### Final sudoers and ACL summary

```bash
ansible all -m command -a "cat /etc/sudoers.d/admin-group" -b
```
<img width="975" height="58" alt="image" src="https://github.com/user-attachments/assets/0bf22172-88e8-4ba2-8a1b-864217ba6914" />

```bash
ansible all -m shell -a "getfacl /team-data/dev-team /team-data/devops-team" -b
ansible all -m shell -a "getfacl /projects/WebApp /projects/API /projects/Mobile" -b
ansible all -m shell -a "getfacl /shared-resources" -b
```
<img width="975" height="589" alt="image" src="https://github.com/user-attachments/assets/232a793f-e762-4043-9301-c04f623fda9c" />
<img width="975" height="869" alt="image" src="https://github.com/user-attachments/assets/46ee5d7a-6110-4061-a74a-a99bbed0969d" />
