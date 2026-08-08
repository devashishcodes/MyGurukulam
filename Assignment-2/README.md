# Assignment 2 – UserManager.sh (iUserManager Utility)

**Submitted by:** Devashish Sathawane

A Bash utility that simulates a team/user management system on Linux, using real Linux groups, users, and permissions to enforce team-based access control on home directories.

## Overview

`UserManager.sh` lets you create "Ninja Teams" (simulated as Linux groups) and add users to them, while automatically setting up correct home directory permissions and two shared sub-directories per user (`team` and `ninja`) for controlled cross-user access.

## Setup

```bash
vim UserManager.sh      # write the script
chmod 777 UserManager.sh
```

## Access Control Rules

- A user has **read, write, execute** access to their own home directory.
- Fellow team members have **read + execute** access to each other's home directories.
- Everyone else (**others**) only has **execute** access to a user's home directory.
- Every user's home directory contains two shared sub-directories:
  - **`team`** — full access for members of the same team.
  - **`ninja`** — full access for all ninjas (every user on the system).

This is implemented via:
- `chmod 751` on the home directory (owner: rwx, group/team: r-x, others: --x)
- `chmod 770` on the `team` sub-directory, owned by group `<teamname>`
- `chmod 770` on the `ninja` sub-directory, owned by group `ninjas`

## Commands

| Command | Description |
|---|---|
| `addTeam <teamname>` | Create a new team (Linux group) |
| `addUser <username> <teamname>` | Create a user, add to the team, set up home dir permissions and `team`/`ninja` shared folders, and set a password |
| `delTeam <teamname>` | Delete a team (only if no users still belong to it) |
| `delUser <username>` | Delete a user (`userdel -r`, removing their home directory) |
| `changePasswd <username>` | Change a user's password |
| `changeShell <username> <shell>` | Change a user's login shell |
| `ls User` | List all users with their team and shell |
| `ls Team` | List all teams with their members |

**Examples**
```bash
./UserManager.sh addTeam amigo
./UserManager.sh addTeam unixkings
./UserManager.sh addUser Rakesh amigo
./UserManager.sh addUser Sandeep unixkings

./UserManager.sh delTeam amigo
./UserManager.sh delUser Rakesh
./UserManager.sh changePasswd Rakesh
./UserManager.sh changeShell Rakesh /bin/bash
./UserManager.sh ls User
./UserManager.sh ls Team
```

**Resultant structure**
```
/home
  - Rakesh
    - team
    - ninja
  - Sandeep
    - team
    - ninja
```

## Notes

- Requires `sudo`/root privileges, since it uses `useradd`, `usermod`, `userdel`, `groupadd`, and `groupdel`.
- A fixed group `ninjas` is used for the shared `ninja` directories across all users.
- Team membership and metadata is tracked in a `TEAMS_FILE` so teams can be listed and validated even without walking every group on the system.
- Deleting a team is blocked if it still has members, to avoid orphaning users.

## Screenshots

<!-- Add your terminal/output screenshots below -->

### Writing the script and setting permissions
<img width="882" height="42" alt="image" src="https://github.com/user-attachments/assets/c11629ac-9d4c-4645-824a-cf4e23699666" />
<img width="997" height="52" alt="image" src="https://github.com/user-attachments/assets/959b25f0-b236-460d-9471-053863384b28" />

### Creating teams (team1, team2)
<img width="1212" height="163" alt="image" src="https://github.com/user-attachments/assets/7c44a59c-3b3a-4c60-88e9-3d0beb8fc611" />

### Adding users to teams
<img width="1240" height="350" alt="image" src="https://github.com/user-attachments/assets/8d647827-6e2a-4466-8070-c35ea1609706" />

### Verifying home directory structure (`tree /home`)
<img width="846" height="357" alt="image" src="https://github.com/user-attachments/assets/fd3702aa-bec8-45cd-908b-f03b71cebc67" />

### Listing users and teams
<img width="1106" height="201" alt="image" src="https://github.com/user-attachments/assets/5279f1e2-6a19-4e8f-8d04-54de8c7640a5" />
<img width="1105" height="167" alt="image" src="https://github.com/user-attachments/assets/48aa2278-a7e6-4139-b6bb-3598ca84e699" />

### Changing password and shell
<img width="1238" height="152" alt="image" src="https://github.com/user-attachments/assets/92f303c6-7f6b-42d2-b9cd-19665c9e5b6f" />
<img width="1235" height="102" alt="image" src="https://github.com/user-attachments/assets/d1365cc5-2cb8-4609-b958-15554bdfb2be" />

### User and team deleted
<img width="1235" height="182" alt="image" src="https://github.com/user-attachments/assets/fb570cb3-f9a8-4fa2-8ab6-fcb6d091a2f0" />

### Verify user1 and team1 deleted or not
<img width="1135" height="256" alt="image" src="https://github.com/user-attachments/assets/0cdb7d0f-2fa5-43aa-9ee6-c30d1755169c" />
######
### Deleting user and team, and verifying deletion
_(screenshot here)_
