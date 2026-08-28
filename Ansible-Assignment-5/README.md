# Ansible Assignment 5 – github_runner_role

Submitted by Devashish Sathawane

An Ansible role to install and register a GitHub Actions self-hosted runner. Version-specific, OS-independent (Ubuntu/CentOS), fully variablelized, uses Jinja2 templates for config files, and keeps handlers separate from tasks. Can run on CentOS, Ubuntu, or both together.

## Create the Role

```bash
mkdir -p ansible-assignment5
cd ansible-assignment5/
ansible-galaxy init github_runner_role
touch github_runner_role/vars/RedHat.yml github_runner_role/vars/Debian.yml
```
Used `ansible-galaxy init` to scaffold the standard role structure, then added per-OS vars files for OS independence.
<img width="975" height="84" alt="image" src="https://github.com/user-attachments/assets/86fae172-d449-4a0f-be72-fec9e768f90f" />

## defaults/main.yml – Variablelized Config

```bash
nano github_runner_role/defaults/main.yml
cat github_runner_role/defaults/main.yml
```
```yaml
runner_version: "2.319.1"          # version-specific install
github_owner: "your-github-username-or-org"
github_repo: "your-repo-name"
github_runner_token: "PASTE_YOUR_RUNNER_TOKEN_HERE"
runner_name: "{{ ansible_hostname }}-runner"
runner_labels: "self-hosted,linux,{{ ansible_os_family }}"
runner_work_dir: "_work"
runner_install_dir: "/opt/actions-runner"
runner_user: "runner"
```
Every value that could change (version, repo, token, labels, paths) is a variable, so nothing is hardcoded.
<img width="975" height="430" alt="image" src="https://github.com/user-attachments/assets/2a291f66-73dc-4e0d-9263-6952720a37d0" />

## OS-Specific Dependencies (RedHat.yml / Debian.yml)

```bash
cat github_runner_role/vars/RedHat.yml
```
```yaml
runner_dependencies:
  - curl
  - tar
  - jq
  - krb5-libs
  - libicu
  - openssl-libs
```
<img width="975" height="232" alt="image" src="https://github.com/user-attachments/assets/28a2028b-68e6-4221-928e-04342ab65884" />

```bash
cat github_runner_role/vars/Debian.yml
```
```yaml
runner_dependencies:
  - curl
  - tar
  - jq
  - liblttng-ust1
  - libkrb5-3
  - libicu-dev
```
Same variable name, different package names per OS - this is what makes the role OS independent.
<img width="975" height="237" alt="image" src="https://github.com/user-attachments/assets/10ee24b0-745a-469c-aad7-b410d3c48fd8" />

## Jinja2 Templates

```bash
cat github_runner_role/templates/actions-runner.service.j2
```
Systemd unit file with dynamic values (`runner_name`, `runner_user`, `runner_install_dir`) filled in at deploy time.
<img width="975" height="354" alt="image" src="https://github.com/user-attachments/assets/b2fd2dab-2522-4e10-9d5e-e2fc5800517e" />

```bash
cat github_runner_role/templates/runner.env.j2
```
Runner environment file - name, repo URL, labels, workdir, version - all templated.
<img width="975" height="170" alt="image" src="https://github.com/user-attachments/assets/b9875da9-030b-42f9-a4e1-5dc3caa5d332" />

## tasks/main.yml

```bash
cat github_runner_role/tasks/main.yml
```
Loads OS-specific vars first:
```yaml
- name: Load OS-specific variables
  include_vars: "{{ ansible_os_family }}.yml"
```
Then updates apt cache (Ubuntu only), installs dependencies with the generic `package` module, creates a dedicated runner user, and creates the install directory.
<img width="913" height="640" alt="image" src="https://github.com/user-attachments/assets/45ad735d-abc1-4c28-b7e9-177fd75e48b3" />

Continuing: downloads the runner tarball for the exact `runner_version`, extracts it, runs its dependency install script, deploys the env file and systemd service from the Jinja templates, registers the runner with GitHub (`config.sh`), and starts the service - notifying a handler on change.
<img width="856" height="1009" alt="image" src="https://github.com/user-attachments/assets/c12619b7-e5d8-4eb6-bb73-36ad411a4a1c" />

## handlers/main.yml (kept separate from tasks)

```bash
cat github_runner_role/handlers/main.yml
```
```yaml
- name: restart github runner
  systemd:
    name: actions-runner
    state: restarted
    daemon_reload: yes
```
<img width="975" height="182" alt="image" src="https://github.com/user-attachments/assets/5d43094b-705a-42e5-9d29-15a927d7cf19" />

## Inventory - run on Ubuntu, CentOS, or both

```bash
nano inventory.ini
cat inventory.ini
```
```ini
[ubuntu]
ubuntu-node1 ansible_host=... ansible_user=ubuntu ...
ubuntu-node2 ansible_host=... ansible_user=ubuntu ...

[all_targets:children]
ubuntu
```
A `centos` group can be added the same way; `all_targets` groups everything together so the user can target one OS or both.
<img width="975" height="134" alt="image" src="https://github.com/user-attachments/assets/e01d6bfd-5d3a-40e4-80e6-32e069435831" />

```bash
nano ansible.cfg
cat ansible.cfg
```
<img width="879" height="175" alt="image" src="https://github.com/user-attachments/assets/ae611f0b-112f-4ebe-88e4-8568425ee5e6" />

```bash
ansible -i inventory.ini ubuntu -m ping
```
<img width="975" height="487" alt="image" src="https://github.com/user-attachments/assets/59d6388a-7f99-4e90-9756-79f6b529bcb9" />

## site.yml

```bash
cat site.yml
```
```yaml
- name: Install and configure GitHub Actions self-hosted runner
  hosts: "{{ target_hosts | default('all_targets') }}"
  become: yes
  roles:
    - github_runner_role
```
`target_hosts` lets the user choose at runtime which group to run against (ubuntu, centos, or all_targets for both) instead of it being fixed in the playbook.
<img width="975" height="203" alt="image" src="https://github.com/user-attachments/assets/b8b96647-d22f-4fcc-bc9a-345f979e6846" />

```bash
ansible-playbook -i inventory.ini site.yml --syntax-check
```
<img width="975" height="61" alt="image" src="https://github.com/user-attachments/assets/f785253b-23a4-4dfc-b98f-56d82b1f4002" />

## Run the Role

```bash
ansible-playbook -i inventory.ini site.yml -l ubuntu-node1 \
  -e "github_owner=devashishcodes github_repo=my-project github_runner_token=<TOKEN>"
```
Vars are overridden per node/repo at runtime with `-e`.
<img width="975" height="909" alt="image" src="https://github.com/user-attachments/assets/b0a3dc4c-7b46-4d21-a249-b8c9d9435e52" />

Runner registered with GitHub, systemd service deployed and started, handler restarts the runner:
```
PLAY RECAP
ubuntu-node1 : ok=13  changed=6  unreachable=0  failed=0  skipped=1
```
<img width="975" height="909" alt="image" src="https://github.com/user-attachments/assets/6bcb2393-7cd7-4b81-b439-ada69f838d0b" />

```bash
ansible-playbook -i inventory.ini site.yml -l ubuntu-node2 \
  -e "github_owner=... github_repo=... github_runner_token=<TOKEN>"
```
Same role, run again for the second node with its own token.
<img width="975" height="1095" alt="image" src="https://github.com/user-attachments/assets/a7f37e3f-1361-46d0-a9d0-93bfc6c3aab1" />

```
PLAY RECAP
ubuntu-node2 : ok=14  changed=12  unreachable=0  failed=0
```
<img width="975" height="329" alt="image" src="https://github.com/user-attachments/assets/ef23dc55-233a-4821-9c5f-ff59b3818681" />

## Final Role Structure

```bash
tree github_runner_role
```
```
github_runner_role
├── README.md
├── defaults/main.yml
├── files
├── handlers/main.yml
├── meta/main.yml
├── tasks/main.yml
├── templates
│   ├── actions-runner.service.j2
│   └── runner.env.j2
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    ├── Debian.yml
    ├── RedHat.yml
    └── main.yml

9 directories, 12 files
```
<img width="975" height="689" alt="image" src="https://github.com/user-attachments/assets/eab7678e-6bec-4f4d-bd91-31f2878079e8" />

## Verification

### Set up a test repo and workflow

```bash
git clone https://github.com/devashishcodes/my-project.git
cd my-project
mkdir -p .github/workflows
nano .github/workflows/test.yml
git add .github/workflows/test.yml
git commit -m "Add self-hosted runner test workflow"
git push origin main
```
<img width="975" height="438" alt="image" src="https://github.com/user-attachments/assets/7eb4e847-6a43-40fb-9451-67cf0785411a" />

### SSH to Node1 - confirm runner service is live

```bash
cd /opt/actions-runner
sudo ./svc.sh status
```
Service active, connected to GitHub, listening for jobs.
<img width="975" height="598" alt="image" src="https://github.com/user-attachments/assets/d2bbc4cc-6d16-4716-89a6-db19293d0592" />

### SSH to Node2 - confirm runner service is live

```bash
cd /opt/actions-runner
sudo ./svc.sh status
```
<img width="975" height="569" alt="image" src="https://github.com/user-attachments/assets/3696ed82-b64c-49b6-8296-802ea7e532dc" />

### GitHub Actions - workflow runs succeeded

Both test workflow runs completed successfully on the self-hosted runners.
<img width="975" height="517" alt="image" src="https://github.com/user-attachments/assets/974eb65c-fe87-499b-aa98-209dec85df34" />

### GitHub Settings - both runners registered and idle

```
Settings → Actions → Runners
```
Both `ip-172-31-43-148-runner` and `ip-172-31-43-170-runner` show up, self-hosted, Linux, and idle - ready to pick up jobs.
<img width="975" height="517" alt="image" src="https://github.com/user-attachments/assets/fa48df03-4c49-43c0-9f1e-52d673a3b128" />
