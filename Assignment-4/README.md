# Assignment 4 – otssh

**Submitted by:** Devashish Sathawane

A Bash utility for managing and connecting to SSH server profiles — add, list, update, delete, and connect to saved connections by name, without having to remember hosts, ports, users, or key paths.

## Overview

`otssh` stores server connection details (name, host, user, port, key file) in a flat-file database at `~/.otssh/servers.db`, using `|` as the field separator. It lets you register connections once under a short name, then reference them later for listing, updating, or connecting.

## Setup

```bash
touch otssh
chmod +x otssh
```

The script auto-creates its data directory and database file on first run:
```bash
mkdir -p "$HOME/.otssh"
touch "$HOME/.otssh/servers.db"
```

## Commands

| Command | Description |
|---|---|
| `otssh -a -n <name> -h <host> -u <user> [-p <port>] [-i <keyfile>]` | Add a new SSH connection |
| `otssh -u -n <name> -h <host> -u <user> [-p <port>] [-i <keyfile>]` | Update an existing connection |
| `otssh ls` | List names of all saved connections |
| `otssh ls -d` | List all connections with full details |
| `otssh rm <name>` | Delete a saved connection |
| `otssh <name>` | Connect to a saved server by name |

### Flags (for `-a` / `-u`)

| Flag | Meaning | Default |
|---|---|---|
| `-n` | Connection name | *(required)* |
| `-h` | Hostname / IP | *(required)* |
| `-u` | SSH user | *(required)* |
| `-p` | SSH port | `22` |
| `-i` | Path to SSH key file | *(none)* |

## Examples

### Add connections
```bash
$ otssh -a -n server1 -h 192.168.21.30 -u kirti
Connection added successfully.

$ otssh -a -n server2 -h 192.168.42.34 -u kirti -p 2022
Connection added successfully.

$ otssh -a -n server3 -h 192.168.46.34 -u ubuntu -p 2022 -i ~/.ssh/server3.pem
Connection added successfully.
```

### List connections
```bash
$ otssh ls
server1
server2
server3

$ otssh ls -d
server1: ssh kirti@192.168.21.30
server2: ssh -p 2022 kirti@192.168.42.34
server3: ssh -i ~/.ssh/server3.pem -p 2022 ubuntu@192.168.46.34
```

### Update connections
```bash
$ otssh -u -n server1 -h server1 -u user1
Connection updated successfully.

$ otssh -u -n server2 -h server2 -u user2 -p 2022
Connection updated successfully.

$ otssh ls -d
server1: ssh user1@server1
server2: ssh -p 2022 user2@server2
server3: ssh -i ~/.ssh/server3.pem -p 2022 ubuntu@192.168.46.34
```

### Delete connections
```bash
$ otssh rm server1
Server 'server1' deleted successfully.

$ otssh rm server2
Server 'server2' deleted successfully.

$ otssh ls -d
server3: ssh -i ~/.ssh/server3.pem -p 2022 ubuntu@192.168.46.34
```

### Connect to a server
```bash
$ otssh server1
[ERROR]: Server information is not available.

$ otssh server3
Connecting to server3...
Connecting to server3 on 2022 port as ubuntu via ~/.ssh/server3.pem key
```

## Logic Notes

- Connections are stored one per line as `name|host|user|port|key` in `~/.otssh/servers.db`.
- **Add (`-a`)** always appends a new record.
- **Update (`-u`)** checks the record exists (`grep -q "^$name|"`), then rebuilds the DB file in a temp file with the old record filtered out and the new one appended, before replacing the original (`mv`) — a safe pattern for in-place edits without `sed`.
- **`ls`** without `-d` just extracts the name field (`cut -d'|' -f1`); **`ls -d`** reads every field and reconstructs the equivalent `ssh` command, adjusting for whether a key file and/or non-default port is set.
- **`rm`** follows the same filter-and-replace pattern as update, removing the matching line from the DB.
- **Connect** (default case, any other argument) looks up the name, and if found, echoes the connection details it would use; if not found, prints an error instead of blindly attempting to connect.

## Screenshots

<!-- Add your terminal/output screenshots below -->

### Adding connections (server1, server2, server3)
<img width="1091" height="145" alt="image" src="https://github.com/user-attachments/assets/9f88067b-48ef-4b42-8a2b-3c8d5016153d" />

### Listing connections (`ls` and `ls -d`)
<img width="855" height="137" alt="image" src="https://github.com/user-attachments/assets/ff1e0a60-295f-47c2-8160-200d6e1dd811" />
<img width="1092" height="126" alt="image" src="https://github.com/user-attachments/assets/b332a882-7ef4-40f6-87b1-5450a5bdc36d" />

### Updating connections
<img width="1093" height="117" alt="image" src="https://github.com/user-attachments/assets/04265b25-47cc-48b8-98bf-624240505790" />

### Deleting connections and verify
<img width="1092" height="487" alt="image" src="https://github.com/user-attachments/assets/094726bd-a4bd-466f-a369-d765a2f1116a" />
