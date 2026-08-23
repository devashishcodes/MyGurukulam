# Ansible Assignment 2 – Nginx + Apache Reverse Proxy with Rotating Websites

Submitted by Devashish Sathawane

Setting up Nginx (with capped log size) and Apache on 3 servers, hosting 3 team-member websites that rotate every 2 hours, with Nginx acting as a reverse proxy in front of Apache.

## Setup & Inventory

```bash
mkdir assignment2
cd assignment2/
nano mykey.pem
chmod 400 mykey.pem
```
<img width="856" height="70" alt="image" src="https://github.com/user-attachments/assets/6e1c330c-cffb-4061-9008-20805f62292c" />
<img width="866" height="72" alt="image" src="https://github.com/user-attachments/assets/0d377de7-cb55-4027-93e8-28dad22c4edf" />

```bash
nano hosts.ini
cat hosts.ini
```
Inventory with 3 nodes (webservers group):
<img width="975" height="353" alt="image" src="https://github.com/user-attachments/assets/c3f3c7c0-fe30-4cf9-bee2-6d76e753aba6" />

```bash
ansible webservers -i hosts.ini -m ping
```
<img width="975" height="725" alt="image" src="https://github.com/user-attachments/assets/64b56942-9cae-42b3-b7fe-e135d9061fc5" />

## Swap Memory (1GB)

No swap was present on any node initially, so a 1GB swapfile was added.

```bash
ansible webservers -i hosts.ini -m shell -a "free -h" --become
```
<img width="975" height="407" alt="image" src="https://github.com/user-attachments/assets/ab353e08-92cb-41b3-876b-2ed27e0fa846" />

```bash
ansible webservers -i hosts.ini -m command -a "fallocate -l 1G /swapfile" --become
```
<img width="975" height="236" alt="image" src="https://github.com/user-attachments/assets/fdd52b43-7981-455b-b31e-ec6a7003303d" />

```bash
ansible webservers -i hosts.ini -m file -a "path=/swapfile mode=0600" --become
```
<img width="975" height="767" alt="image" src="https://github.com/user-attachments/assets/39198226-5eec-4307-9be5-0a98c5c13bc0" />

```bash
ansible webservers -i hosts.ini -m command -a "mkswap /swapfile" --become
ansible webservers -i hosts.ini -m command -a "swapon /swapfile" --become
```
<img width="975" height="454" alt="image" src="https://github.com/user-attachments/assets/6a083528-4132-4b3c-a19c-ed4a15bc0804" />

```bash
ansible webservers -i hosts.ini -m lineinfile -a "path=/etc/fstab line='/swapfile none swap sw 0 0'" --become
```
Added to fstab so swap persists after reboot.
<img width="975" height="385" alt="image" src="https://github.com/user-attachments/assets/dd60f174-b0a9-44d9-8ee7-c15ccbff681a" />

```bash
ansible webservers -i hosts.ini -m shell -a "free -h" --become
```
1GB swap confirmed on all 3 nodes.
<img width="975" height="349" alt="image" src="https://github.com/user-attachments/assets/762ff1fb-1a24-4534-84bf-0e13145a0e30" />

## Nginx Install (Rolling – one node at a time)

```bash
ansible webservers -i hosts.ini -m apt -a "name=nginx state=present update_cache=yes" --become
```
<img width="975" height="264" alt="image" src="https://github.com/user-attachments/assets/2a43d820-0a80-4aef-94f7-b0367f743a43" />
<img width="975" height="259" alt="image" src="https://github.com/user-attachments/assets/78a0dbf4-896f-422e-93d8-907b52b18ebe" />
<img width="975" height="241" alt="image" src="https://github.com/user-attachments/assets/98605326-2f7b-46ce-bf6a-df4637083b64" />

```bash
ansible webservers -i hosts.ini -m service -a "name=nginx state=started enabled=yes" --become -f 1
```
`-f 1` (forks=1) makes Ansible run this task on one node at a time instead of all together, which is the rolling requirement.
<img width="975" height="167" alt="image" src="https://github.com/user-attachments/assets/971f3d02-f8d8-4423-bfa6-027dff7ea097" />
<img width="975" height="221" alt="image" src="https://github.com/user-attachments/assets/82635d4d-5880-4009-be73-03e04e8a6e65" />
<img width="975" height="246" alt="image" src="https://github.com/user-attachments/assets/185481f7-d054-4570-b816-1b2f6decd099" />

## Nginx Log Limit (1GB via logrotate)

```bash
cat > nginx-logrotate << 'EOF'
/var/log/nginx/*.log {
    daily
    rotate 7
    maxsize 1G
    missingok
    notifempty
    compress
    delaycompress
    sharedscripts
    postrotate
        [ -f /var/run/nginx.pid ] && kill -USR1 `cat /var/run/nginx.pid`
    endscript
}
EOF
```
`maxsize 1G` makes sure the log gets rotated as soon as it hits 1GB, so it never grows past that.
<img width="975" height="381" alt="image" src="https://github.com/user-attachments/assets/9082fa46-ca5b-40e0-ac14-9d3229b41422" />

```bash
ansible webservers -i hosts.ini -m copy -a "src=./nginx-logrotate dest=/etc/logrotate.d/nginx owner=root mode=0644" --become -f 1
```
<img width="975" height="588" alt="image" src="https://github.com/user-attachments/assets/e0d9ee86-aeb3-4c29-a220-7e2d7cc345fe" />

```bash
ansible webservers -i hosts.ini -m shell -a "cat /etc/logrotate.d/nginx" --become
```
<img width="975" height="723" alt="image" src="https://github.com/user-attachments/assets/c8b19933-7068-48f3-a84d-7d90d098a17f" />

## Apache Install

```bash
ansible webservers -i hosts.ini -m apt -a "name=apache2 state=present" --become -f 1
```
<img width="975" height="177" alt="image" src="https://github.com/user-attachments/assets/a9600f66-2add-44d1-b6b9-cb90603b0d21" />
<img width="975" height="291" alt="image" src="https://github.com/user-attachments/assets/dfe6809c-419b-4549-82e2-b4bfcf5c12f5" />
<img width="975" height="261" alt="image" src="https://github.com/user-attachments/assets/c2534612-515e-4d6c-b71d-1e1543c1c74d" />

### Move Apache to port 8080 (since Nginx will take port 80)

```bash
ansible webservers -i hosts.ini -m lineinfile -a "path=/etc/apache2/ports.conf regexp='^Listen 80' line='Listen 8080'" --become -f 1
```
<img width="975" height="335" alt="image" src="https://github.com/user-attachments/assets/483d83ae-16a2-4a17-b200-2b678d555d9f" />

```bash
ansible webservers -i hosts.ini -m replace -a "path=/etc/apache2/sites-available/000-default.conf regexp='<VirtualHost \*:80>' replace='<VirtualHost *:8080>'" --become -f 1
```
<img width="975" height="314" alt="image" src="https://github.com/user-attachments/assets/e31afcbb-c30d-4504-852e-88f60f3aecce" />

```bash
ansible webservers -i hosts.ini -m service -a "name=apache2 state=restarted" --become -f 1
```
<img width="975" height="158" alt="image" src="https://github.com/user-attachments/assets/3c2fc87c-ec69-4bc7-8988-c339815636fa" />
<img width="975" height="164" alt="image" src="https://github.com/user-attachments/assets/94f8d820-727e-4d6d-bf87-90eda24c9a55" />
<img width="975" height="162" alt="image" src="https://github.com/user-attachments/assets/64ea65a4-f816-4d2c-963c-40ffdb7471f2" />

## Website Content (Tanya, Heena, Devashish)

```bash
ls
```
3 site folders prepared locally: tanya_site, heena_site, devashish_site.
<img width="975" height="36" alt="image" src="https://github.com/user-attachments/assets/df229372-127a-4125-969e-11db128edcd6" />

```bash
cat tanya_site/index.html
cat heena_site/index.html
```
<img width="975" height="420" alt="image" src="https://github.com/user-attachments/assets/b57ed966-c470-4462-b8db-041e307fda5a" />

```bash
cat devashish_site/index.html
```
A custom styled page for the third member.
<img width="792" height="1249" alt="image" src="https://github.com/user-attachments/assets/55252d30-bfd0-4c27-88e3-7a1fa7236bd3" />

```bash
ansible webservers -i hosts.ini -m copy -a "src=./tanya_site/ dest=/var/www/tanya/" --become
```
<img width="975" height="756" alt="image" src="https://github.com/user-attachments/assets/94bd719f-e135-4356-b32b-718949dfbdbe" />

```bash
ansible webservers -i hosts.ini -m copy -a "src=./heena_site/ dest=/var/www/heena/" --become
```
<img width="975" height="763" alt="image" src="https://github.com/user-attachments/assets/2a1bf726-b2c6-4994-8d43-746ab02c4052" />

```bash
ansible webservers -i hosts.ini -m copy -a "src=./devashish_site/ dest=/var/www/devashish/" --become
```
<img width="975" height="801" alt="image" src="https://github.com/user-attachments/assets/dd6070a3-5db7-4fdf-a0b4-6ac0fa90ec96" />

## Rotation Script (3-Way, 2-Hour) + Cron

```bash
cat > switch_site.sh << 'EOF'
#!/bin/bash
MIN=$(date +%s)
BLOCK=$(( (MIN / 120) % 3 ))
if [ $BLOCK -eq 0 ]; then
  ln -sfn /var/www/tanya /var/www/current
elif [ $BLOCK -eq 1 ]; then
  ln -sfn /var/www/heena /var/www/current
else
  ln -sfn /var/www/devashish /var/www/current
fi
systemctl reload apache2
EOF
```
Script picks one of the 3 sites based on a rotating time block and points `/var/www/current` at it.

> Note: for testing purposes the rotation interval used here is 2 minutes; the actual cron for the 2-hour requirement is `*/2` hours in production.

<img width="975" height="678" alt="image" src="https://github.com/user-attachments/assets/826ef03b-4e43-4064-b03a-aa2eb4be53f3" />

```bash
ansible webservers -i hosts.ini -m copy -a "src=./switch_site.sh dest=/usr/local/bin/switch_site.sh mode=0755" --become
```
<img width="975" height="712" alt="image" src="https://github.com/user-attachments/assets/b967e614-b284-43a7-979b-70db94219ab1" />

```bash
ansible webservers -i hosts.ini -m shell -a "/usr/local/bin/switch_site.sh" --become
```
<img width="975" height="172" alt="image" src="https://github.com/user-attachments/assets/390a1214-084f-497a-a885-cbc0252bb43a" />

```bash
ansible webservers -i hosts.ini -m cron -a "name='website rotation' minute='*/2' job='/usr/local/bin/switch_site.sh' user='root'" --become
```
<img width="975" height="389" alt="image" src="https://github.com/user-attachments/assets/3374e194-b590-4e1e-a759-300cbb62430e" />

```bash
ansible webservers -i hosts.ini -m shell -a "crontab -l" --become
```
<img width="975" height="281" alt="image" src="https://github.com/user-attachments/assets/275c2fe1-3b4d-4fc8-94b9-be79b54ff217" />

## Apache DocumentRoot → /var/www/current

```bash
ansible webservers -i hosts.ini -m lineinfile -a "path=/etc/apache2/sites-available/000-default.conf regexp='DocumentRoot .*' line='DocumentRoot /var/www/current'" --become
ansible webservers -i hosts.ini -m service -a "name=apache2 state=restarted" --become
```
<img width="975" height="415" alt="image" src="https://github.com/user-attachments/assets/0c8daa62-e082-48e1-b9a9-3d506c0fd056" />
<img width="975" height="192" alt="image" src="https://github.com/user-attachments/assets/db9f0581-dc63-459e-84ef-ab124450989e" />
<img width="975" height="224" alt="image" src="https://github.com/user-attachments/assets/80addef6-5bd0-4475-965c-07986c8f7fb3" />

## Nginx Reverse Proxy Config

```bash
cat > default_proxy.conf << 'EOF'
server {
    listen 80;
    server_name team.opstree.com;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
EOF
```
Nginx listens on port 80 and forwards all requests to Apache running on 8080.
<img width="975" height="278" alt="image" src="https://github.com/user-attachments/assets/56c68ab8-8b96-4c4f-aab3-988fa4aa6dc2" />

```bash
ansible webservers -i hosts.ini -m copy -a "src=./default_proxy.conf dest=/etc/nginx/sites-available/default" --become
```
<img width="975" height="683" alt="image" src="https://github.com/user-attachments/assets/3901c10f-6dd7-431f-bae7-8aeb09a78e5d" />

```bash
ansible webservers -i hosts.ini -m shell -a "nginx -t" --become -f 1
```
<img width="975" height="270" alt="image" src="https://github.com/user-attachments/assets/5fa3bbe1-1dac-4bab-817b-e500ba22c061" />

```bash
ansible webservers -i hosts.ini -m service -a "name=nginx state=reloaded" --become -f 1
```
<img width="975" height="161" alt="image" src="https://github.com/user-attachments/assets/39e6817b-d529-4ff7-bb0a-3b2f7bae08cf" />
<img width="975" height="181" alt="image" src="https://github.com/user-attachments/assets/9e28d358-7c60-45a0-99b4-d5523232e086" />
<img width="975" height="190" alt="image" src="https://github.com/user-attachments/assets/77487de5-d413-438a-9e8b-9473fdef275b" />

## Verification / Testing

```bash
ansible webservers -i hosts.ini -m shell -a "ss -tlnp | grep -E '80|8080'" --become
ansible webservers -i hosts.ini -m shell -a "ls -la /var/www/current" --become
```
Confirms nginx listening on port 80, apache on 8080, and the `current` symlink pointing to the active site.
<img width="975" height="444" alt="image" src="https://github.com/user-attachments/assets/4943159b-0c0a-4fd3-8ee2-4764a3608307" />

```bash
ansible webservers -i hosts.ini -m uri -a "url=http://localhost/ return_content=yes" --become
```
<img width="975" height="140" alt="image" src="https://github.com/user-attachments/assets/3e7b7fae-253f-4f02-8bc9-593cacf079c4" />
<img width="975" height="171" alt="image" src="https://github.com/user-attachments/assets/17e4a8a3-2bfa-4f80-90ac-e5df1e9ea0e6" />
<img width="975" height="185" alt="image" src="https://github.com/user-attachments/assets/d8f1f7d5-c8f2-4df5-95ff-e282bc861aeb" />

### Browser verification of rotation

```
http://team.opstree.com
```
First check - Tanya's site is live:
<img width="975" height="87" alt="image" src="https://github.com/user-attachments/assets/69e5fddd-7a72-4b81-b59c-b8dce2a0b555" />

After rotation triggers - Heena's site is live:
<img width="975" height="87" alt="image" src="https://github.com/user-attachments/assets/97452c1f-2247-4d4b-be8c-01c28ef6dd0d" />

After next rotation - Devashish's site is live:
<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/9e01cb10-0461-4e5d-9d3d-837c06330d2b" />
