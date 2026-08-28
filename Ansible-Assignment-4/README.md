# Ansible Assignment 4 – system_manager Role

Submitted by Devashish Sathawane

An Ansible role to manage a VM end to end: install packages, manage users, clone/manage git repos, keep a required folder structure in place, and configure general system settings (timezone, hostname, MOTD, sysctl, services, SSH hardening).

## Project & Role Structure

```bash
mkdir -p system_manager_project/roles/system_manager/{defaults,tasks,handlers,templates,meta}
mkdir -p system_manager_project/inventory
cd system_manager_project
```
Standard Ansible role layout.
<img width="975" height="53" alt="image" src="https://github.com/user-attachments/assets/a455f36d-3882-40d4-b361-97ccd71ebc39" />

## Setup

```bash
nano ansible.cfg
cat ansible.cfg
```
`become=True` set globally so every task runs with sudo by default.
<img width="975" height="426" alt="image" src="https://github.com/user-attachments/assets/312b5f5c-e512-4a70-89ad-fb51dd278d88" />

```bash
nano inventory/hosts.ini
cat inventory/hosts.ini
```
<img width="975" height="115" alt="image" src="https://github.com/user-attachments/assets/1d0e5274-d63d-4de1-bd44-5b3b777ade89" />

```bash
nano site.yml
cat site.yml
```
Playbook simply calls the `system_manager` role on `managed_nodes`.
<img width="975" height="233" alt="image" src="https://github.com/user-attachments/assets/5746ada1-4f4f-4a9b-bad9-af60360ffae1" />

```bash
nano requirements.yml
cat requirements.yml
```
External collections needed: `community.crypto` (SSH keypair generation), `ansible.posix` (authorized_key, sysctl), `community.general` (timezone).
<img width="975" height="295" alt="image" src="https://github.com/user-attachments/assets/c03a92a8-677b-45f6-bc6b-318b665bce3d" />

## Role Variables (defaults/main.yml)

### 1. Software / Package Management

```yaml
sm_packages_state: present
sm_packages:
  - git
  - vim
  - curl
  - wget
  - htop
  - unzip
  - tree
  - net-tools
```

### 2. User Management

```yaml
sm_users:
  - name: devops
    groups: sudo
    generate_ssh_key: true
  - name: appuser
    groups: []
    generate_ssh_key: false
sm_users_absent: []
```

### 3. Git Repository Management

```yaml
sm_git_repos:
  - name: sample-app
    repo: "https://github.com/ansible/ansible-examples.git"
    dest: /opt/repos/sample-app
    version: master
    owner: devops
    group: devops
```
<img width="975" height="969" alt="image" src="https://github.com/user-attachments/assets/862b9c2b-503d-4766-a22c-218375416a24" />

### 4. Folder Structure Management

```yaml
sm_directories:
  - path: /opt/repos
  - path: /opt/apps
  - path: /opt/apps/logs
  - path: /opt/apps/config
  - path: /var/backups/system_manager
```

### 5. Other System Settings

```yaml
sm_timezone: "Asia/Kolkata"
sm_hostname_enabled: true
sm_hostname: "system-manager-node"
sm_motd_enabled: true
sm_motd_message: "Managed by Ansible - system_manager role. Unauthorized access is prohibited."
sm_chrony_enabled: true
sm_sysctl_settings:
  - name: net.ipv4.ip_forward
    value: 0
  - name: vm.swappiness
    value: 10
sm_services_enabled: [ssh]
sm_ssh_hardening_enabled: true
sm_ssh_permit_root_login: "no"
sm_ssh_password_authentication: "no"
```
Directory structure and system settings vars.
<img width="975" height="1014" alt="image" src="https://github.com/user-attachments/assets/4ed8ecc8-df42-41c0-ae1a-02baf84ac9cb" />

## Role Tasks

```bash
nano roles/system_manager/tasks/main.yml
cat roles/system_manager/tasks/main.yml
```
`main.yml` just includes each concern as its own file, with tags so any part can be run in isolation:
```yaml
- include_tasks: packages.yml
  tags: [packages]
- include_tasks: users.yml
  tags: [users]
- include_tasks: directories.yml
  tags: [directories]
- include_tasks: git_repos.yml
  tags: [git]
- include_tasks: system_settings.yml
  tags: [system_settings]
```
<img width="964" height="473" alt="image" src="https://github.com/user-attachments/assets/84962f77-459a-42ab-b9cd-219ed20be45b" />

### packages.yml

```bash
cat roles/system_manager/tasks/packages.yml
```
Updates apt cache (Debian only), then installs `sm_packages` using the generic `package` module so it works across apt/yum/dnf automatically.
<img width="975" height="281" alt="image" src="https://github.com/user-attachments/assets/b2b20a65-9de8-4187-899e-ca358f917fbb" />

### users.yml

```bash
cat roles/system_manager/tasks/users.yml
```
Creates groups → creates user accounts → generates an SSH keypair for users who ask for one (`community.crypto.openssh_keypair`) → adds any authorized public keys (`ansible.posix.authorized_key`) → removes users listed in `sm_users_absent`.
<img width="975" height="1147" alt="image" src="https://github.com/user-attachments/assets/39503f79-016c-4eb2-a9fb-d9f32a8a0f82" />

### directories.yml

```bash
cat roles/system_manager/tasks/directories.yml
```
Loops over `sm_directories` and ensures each path exists with the right owner/group/mode.
<img width="975" height="263" alt="image" src="https://github.com/user-attachments/assets/8551ec5f-5fdd-47b0-9be3-e692337aad5a" />

### git_repos.yml

```bash
cat roles/system_manager/tasks/git_repos.yml
```
Ensures the parent directory exists → clones/updates each repo in `sm_git_repos` (`update: true`, runs as the repo's owner) → fixes ownership recursively afterward.
<img width="975" height="750" alt="image" src="https://github.com/user-attachments/assets/fc34c7e1-ca8e-4728-9c29-e1f635003990" />

### system_settings.yml

```bash
cat roles/system_manager/tasks/system_settings.yml
```
Sets timezone, hostname, deploys the MOTD from a template, applies sysctl kernel parameters, starts/enables required services (and stops unwanted ones), and hardens SSH (`PermitRootLogin`, `PasswordAuthentication`) - notifying a handler to restart sshd on change.
<img width="731" height="964" alt="image" src="https://github.com/user-attachments/assets/dc61161e-af0e-43c2-bae8-54a34f058e62" />

## Handlers

```bash
cat roles/system_manager/handlers/main.yml
```
```yaml
- name: restart sshd
  ansible.builtin.service:
    name: ssh
    state: restarted
```
<img width="975" height="149" alt="image" src="https://github.com/user-attachments/assets/64a1d14e-6697-4259-b889-1f9507bbdc9e" />

## MOTD Template

```bash
cat roles/system_manager/templates/motd.j2
```
Shows the custom message plus live facts - hostname, OS, distro version, last apply time.
<img width="975" height="209" alt="image" src="https://github.com/user-attachments/assets/9c93a08d-2273-4cfc-99fa-120d9e23f6b6" />

## Role Metadata

```bash
cat roles/system_manager/meta/main.yml
```
Declares role name, author, description, license, and supported platforms (EL 8/9, Amazon Linux 2/2023, Ubuntu 20.04/22.04/24.04).
<img width="954" height="428" alt="image" src="https://github.com/user-attachments/assets/a0d78851-85e2-48cf-9266-452f257f1eef" />

## Running the Role

```bash
ansible-galaxy collection install -r requirements.yml
```
<img width="975" height="48" alt="image" src="https://github.com/user-attachments/assets/911da7ed-f523-43f4-8955-5426a5a34a24" />

```bash
ansible managed_nodes -m ping
```
<img width="975" height="125" alt="image" src="https://github.com/user-attachments/assets/ac2d61a5-a6ad-4c3f-9288-326e9cb2ba11" />

```bash
ansible-playbook site.yml --syntax-check
```
<img width="869" height="56" alt="image" src="https://github.com/user-attachments/assets/36edd2b6-03a7-47db-9ef9-f68a883f36c5" />

```bash
ansible-playbook site.yml
```

Packages installed, then user/group tasks run (devops, appuser created, SSH keys generated):
<img width="975" height="517" alt="image" src="https://github.com/user-attachments/assets/24458475-32a1-41d4-9d22-ae18caa01fe4" />

Directory structure created, git repo cloned, timezone/hostname/MOTD applied:
<img width="975" height="514" alt="image" src="https://github.com/user-attachments/assets/e625af4f-7e0d-4a04-80e6-6a64f7bd8054" />

Sysctl applied, services enabled, SSH hardened, handler restarts sshd:
```
PLAY RECAP
ec2-node : ok=24  changed=10  unreachable=0  failed=0  skipped=3
```
<img width="975" height="277" alt="image" src="https://github.com/user-attachments/assets/7c7ea82a-a110-4af3-860c-31643088c214" />

## Verification on the Node

SSH'd directly into the managed node to manually confirm everything the role set up: users (`devops`, `appuser`), the `/opt` and `/var/backups` directory structure with correct ownership, the cloned git repo, the custom `/etc/motd`, the timezone (`Asia/Kolkata` via `timedatectl`), and the `vm.swappiness` sysctl value.

```bash
id devops
id appuser
ls -la /opt/repos /opt/apps /opt/apps/logs /opt/apps/config /var/backups/system_manager
git -C /opt/repos/sample-app log -1
cat /etc/motd
timedatectl
sudo sysctl vm.swappiness
```
<img width="975" height="833" alt="image" src="https://github.com/user-attachments/assets/cf9aa1fd-63b6-478c-a421-f0c850ffb0a0" />
