# Assignment 2 – UserManager.sh

Submitted by Devashish Sathawane

A script to manage teams and users, with proper home directory permissions and shared folders.

## Make UserManager.sh script using nano/vim editor

```bash
vim UserManager.sh
```

Commands added: `addTeam`, `addUser`, `delTeam`, `delUser`, `changePasswd`, `changeShell`, `ls`

Permission rules:
- User's own home directory: read, write, execute
- Team members: read, execute
- Others: execute only
- Two shared folders in every home directory: `team` (full access to same team) and `ninja` (full access to all users)

<img width="882" height="42" alt="image" src="https://github.com/user-attachments/assets/93e1d062-6ef4-4753-bea0-2c796c05fb35" />

## Give chmod 777

```bash
chmod 777 UserManager.sh
```
<img width="998" height="53" alt="image" src="https://github.com/user-attachments/assets/9fd847bb-ed39-48ca-921d-0ab36bfe558c" />

## Create team1 and team2

```bash
sudo ./UserManager.sh addTeam team1
sudo ./UserManager.sh addTeam team2
```
<img width="1210" height="163" alt="image" src="https://github.com/user-attachments/assets/40e22f48-f034-46fd-9582-c47131d0c27e" />

## Add user1 to team1 and user2 to team2

```bash
sudo ./UserManager.sh addUser user1 team1
sudo ./UserManager.sh addUser user2 team2
```
<img width="1237" height="345" alt="image" src="https://github.com/user-attachments/assets/effdfb01-90a3-46ee-a118-77060a6b8abe" />

## tree

```bash
sudo tree /home
```
```
/home
  - user1
    - ninja
    - team
  - user2
    - ninja
    - team
```
<img width="840" height="353" alt="image" src="https://github.com/user-attachments/assets/ede4368d-c9df-4a9d-9b3f-0ed0b9a3da6c" />

## User list kiye

```bash
sudo ./UserManager.sh ls User
```
<img width="1102" height="193" alt="image" src="https://github.com/user-attachments/assets/baace423-8813-469d-86ab-69f2a37c8f08" />

## Team list kiya

```bash
sudo ./UserManager.sh ls Team
```
<img width="1105" height="160" alt="image" src="https://github.com/user-attachments/assets/96580de0-e5fc-4857-b9cb-74fea07e547c" />

## Change passwd

```bash
sudo ./UserManager.sh changePasswd user1
```
<img width="1232" height="147" alt="image" src="https://github.com/user-attachments/assets/8ec1c916-83e8-4a69-98ea-8731b60a07e8" />

## Change shell

```bash
sudo ./UserManager.sh changeShell user1 /bin/bash
```
<img width="1233" height="97" alt="image" src="https://github.com/user-attachments/assets/0240b0c8-0c8f-492c-857d-058ea0bb3185" />

## User and team deleted

```bash
sudo ./UserManager.sh delUser user1
sudo ./UserManager.sh delTeam team1
```
<img width="1237" height="191" alt="image" src="https://github.com/user-attachments/assets/970d8abc-2a88-4643-80ba-f5fecb716ea1" />

## Verify user1 and team1 deleted or not

```bash
sudo ./UserManager.sh ls User
sudo ./UserManager.sh ls Team
```
<img width="1135" height="267" alt="image" src="https://github.com/user-attachments/assets/e5994482-a629-4196-8629-b6dd71b48984" />
