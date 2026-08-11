# Assignment 4 – otssh

Submitted by Devashish Sathawane

A utility to save SSH server details and connect to them by name, instead of typing host/user/port every time.

## make touch otssh

```bash
touch otssh
chmod +x otssh
```

Script saves connections in a file `~/.otssh/servers.db` (format: `name|host|user|port|key`).

Commands: `-a` (add), `-u` (update), `ls`, `ls -d`, `rm`, and connect by name.

## Add ssh connection

```bash
./otssh -a -n server1 -h 3.91.227.242 -u kirti
./otssh -a -n server2 -h 3.91.227.242 -u kirti -p 2022
./otssh -a -n server3 -h 3.91.227.242 -u ubuntu -p 2022 -i ~/.ssh/server3.pem
```
<img width="1101" height="150" alt="image" src="https://github.com/user-attachments/assets/3774d66a-fd0d-4e52-999d-fc1551e2b687" />

## List ssh connection

```bash
./otssh ls
```
<img width="862" height="145" alt="image" src="https://github.com/user-attachments/assets/3f0c0c3c-d0dd-49cb-ad67-7585beb6d83a" />

```bash
./otssh ls -d
```
`ls -d` shows the full ssh command for each saved connection.
<img width="1095" height="125" alt="image" src="https://github.com/user-attachments/assets/b3d91ce3-93d0-4840-b7f3-d2a351dcd7b7" />

## Update ssh connection

```bash
./otssh -u -n server1 -h server1 -u user1
./otssh -u -n server2 -h server2 -u user2 -p 2022
```
<img width="1097" height="116" alt="image" src="https://github.com/user-attachments/assets/7ba35b63-c345-4b31-9adf-8067ab4589ec" />

```bash
./otssh ls -d
```
<img width="1095" height="118" alt="image" src="https://github.com/user-attachments/assets/a72d9f0b-8da9-415e-aef1-5c8a8ca36f78" />

## Delete ssh connection

```bash
./otssh rm server1
./otssh rm server2
```
<img width="1097" height="112" alt="image" src="https://github.com/user-attachments/assets/23ab68cf-ea24-4c0d-9e93-19249e2b9fb4" />

```bash
./otssh ls -d
```
<img width="1096" height="61" alt="image" src="https://github.com/user-attachments/assets/27ebe326-062f-4feb-b939-360f7e60518c" />

## Connect to server

```bash
./otssh server1
```
```
[ERROR]: Server information is not available.
```
(server1 was already deleted, so no record found)

```bash
./otssh server2
```
```
[ERROR]: Server information is not available.
```
_(screenshot here)_

```bash
./otssh server3
```
```
Connecting to server3...
Connecting to server3 on 2022 port as ubuntu via /home/ubuntu/.ssh/server3.pem key
```
<img width="1092" height="202" alt="image" src="https://github.com/user-attachments/assets/158c9ff8-1068-4f2a-a56f-7e22de2623c5" />
