# Ansible Assignment 3 – Spring3HibernateApp Deployment on AWS

Submitted by Devashish Sathawane

Setting up a full infra on AWS using a single Ansible playbook: MySQL, JDK 11, Maven, build the app's WAR file, install Tomcat, and deploy the WAR - all automated.

Repo used: https://github.com/opstree/spring3hibernate

## Setup & Inventory

```bash
mkdir ansible-assignment-3
cd ansible-assignment-3/
nano inventory
cat inventory
```
```ini
[app]
server1 ansible_host=100.59.218.160 ansible_user=ubuntu ansible_ssh_private_key_file=/home/devashish/mykey.pem
```
<img width="975" height="100" alt="image" src="https://github.com/user-attachments/assets/7d7f9322-e33f-4fd1-aa26-0e0b8ac39149" />

```bash
ansible -i inventory app -m ping
```
<img width="975" height="256" alt="image" src="https://github.com/user-attachments/assets/831dc69f-73f4-4d9d-b052-676cdbad4c82" />

```bash
nano ansible.cfg
cat ansible.cfg
```
<img width="975" height="351" alt="image" src="https://github.com/user-attachments/assets/f9527530-4942-43ee-a5e2-e20914340ecb" />

## Playbook

```bash
nano site.yml
ansible-playbook site.yml --syntax-check
```
Syntax checked before running.
<img width="975" height="351" alt="image" src="https://github.com/user-attachments/assets/5f604362-b2fd-442d-afde-a9d4175d9fb3" />

```bash
ansible-playbook site.yml
```

### JDK 11, Maven and Git installed

Tasks: update apt cache → install JDK 11 → install Maven → install Git → verify Java and Maven versions.
<img width="975" height="589" alt="image" src="https://github.com/user-attachments/assets/0f962550-2e4e-4542-a12c-316a57b2fa84" />

### MySQL Server and employeedb database configured

Tasks: install MySQL server → install python MySQL dependency → ensure MySQL running → create application database.
<img width="975" height="193" alt="image" src="https://github.com/user-attachments/assets/eb134a43-41d1-4907-9254-facb6e432752" />

### Spring3Hibernate source code cloned

```
TASK [Clone Spring3Hibernate application]
```
Cloned using the `git` module.
<img width="975" height="46" alt="image" src="https://github.com/user-attachments/assets/3ea0b15a-73c7-4908-944b-524ee729d5c0" />

### Configure app DB connection and upload directory

Tasks: update the app's database connection properties → create the file upload directory the app needs.
<img width="975" height="100" alt="image" src="https://github.com/user-attachments/assets/1c57788f-7e25-4ddd-9c15-a0ce3edc2882" />

### WAR file built using Maven

Tasks: run `mvn package` to build the WAR → find the generated file → display its path.
```
Generated WAR: ['/opt/spring3hibernate/target/Spring3HibernateApp.war']
```
<img width="975" height="178" alt="image" src="https://github.com/user-attachments/assets/9a6adc45-3386-41ce-bde3-aa60f2f28ee2" />

### Apache Tomcat 7.0.108 installed and started

Tasks: create install directory → download Tomcat 7.0.108 → extract it → create tomcat user → set ownership → make startup/shutdown scripts executable → create a systemd service → reload systemd → start and enable Tomcat.
<img width="975" height="449" alt="image" src="https://github.com/user-attachments/assets/b0e1d397-9137-4c23-a3ab-ff67ace5ac38" />

### WAR deployed to Tomcat, Tomcat restarted

Tasks: copy the WAR to `/opt/tomcat/apache-tomcat-7.0.108/webapps/` → restart Tomcat → wait for it to come up → verify the deployed WAR.
```
"msg": "WAR deployed successfully: True"
```
<img width="975" height="274" alt="image" src="https://github.com/user-attachments/assets/05c626f1-e438-47b6-a1eb-65c007218f12" />

### App verified through Ansible

```
"msg": "Spring3Hibernate application is running. HTTP status: 200"
PLAY RECAP: server1: ok=34  changed=5  unreachable=0  failed=0
```
<img width="975" height="176" alt="image" src="https://github.com/user-attachments/assets/3f538583-6e4a-4d50-beec-5b8e7b857e0a" />

## Verify in browser

```
http://100.59.218.160:8080/Spring3HibernateApp/
```
<img width="975" height="523" alt="image" src="https://github.com/user-attachments/assets/89887f2a-caf1-4d53-af97-56bb0521796a" />
