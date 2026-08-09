# Assignment 6 – Process Management Utilities

**Submitted by:** Devashish Sathawane

Three parts: a read-only process inspection tool (`otProcessManager`), a daemon-style service manager (`ProcessManager.sh`), and a hands-on exploration of what happens to a running process when its log file is cleared, deleted, or reprioritized.

## Part A: otProcessManager

A utility to inspect and manage running processes — top consumers by memory/CPU, orphaned and zombie processes, processes waiting on I/O, and killing processes by name/PID.

### Setup
```bash
touch otProcessManager
chmod +x otProcessManager
```

### Commands

| Command | Description |
|---|---|
| `otProcessManager topProcess <n> memory` | Top `n` processes by memory usage |
| `otProcessManager topProcess <n> cpu` | Top `n` processes by CPU usage |
| `otProcessManager killLeastPriorityProcess` | Kill the process with the least scheduling priority (highest nice value) |
| `otProcessManager RunningDurationProcess <name/pid>` | Show how long a process (by name or PID) has been running |
| `otProcessManager listOrphanProcess` | List orphan processes (parent PID = 1) |
| `otProcessManager listZoombieProcess` | List zombie processes (state `Z`) |
| `otProcessManager killProcess <name/pid>` | Kill a process by name or PID |
| `otProcessManager ListWaitingProcess` | List processes in uninterruptible sleep / waiting on I/O (state `D`) |

### Examples
```bash
./otProcessManager topProcess 5 memory
./otProcessManager topProcess 10 cpu
./otProcessManager killLeastPriorityProcess
./otProcessManager RunningDurationProcess nginx
./otProcessManager listOrphanProcess
./otProcessManager listZoombieProcess
./otProcessManager killProcess 1234
./otProcessManager ListWaitingProcess
```

### How it works

- **`topProcess`** uses `ps -eo pid,comm,%mem --sort=-%mem` (or `%cpu`), piped through `head -n $((n+1))` to include the header row.
- **`killLeastPriorityProcess`** sorts by nice value (`ps -eo pid,ni --sort=-ni`) and kills the process with the highest nice value (i.e. lowest scheduling priority).
- **`RunningDurationProcess`** uses `ps -eo pid,comm,etime` filtered with `grep -w` for the given name or PID, showing elapsed time.
- **`listOrphanProcess`** filters `ps -eo pid,ppid,stat,comm` for entries where the parent PID (`$2`) is `1`.
- **`listZoombieProcess`** filters for `STAT` beginning with `Z`.
- **`killProcess`** checks if the argument is numeric (a PID, `kill`) or a name (`pkill -x`).
- **`ListWaitingProcess`** filters for `STAT` beginning with `D` (uninterruptible sleep — typically waiting on I/O).
- Any unrecognized command prints a usage summary.

## Part B: ProcessManager.sh

A service-manager utility that registers scripts as background "services" under an alias, then lets you start, stop, monitor, reprioritize, and list them — similar in spirit to a lightweight `systemctl`.

### Setup
```bash
touch ProcessManager.sh
chmod +x ProcessManager.sh
```

Registered services are tracked in `~/.processmanager/registry.txt` (format: `alias|path|priority`), and each running service's PID is stored in `~/.processmanager/<alias>.pid`.

### Commands

| Command | Description |
|---|---|
| `ProcessManager.sh -o register -s <path> -a <alias>` | Register a script under an alias |
| `ProcessManager.sh -o start -a <alias>` | Start the registered service as a background daemon |
| `ProcessManager.sh -o status -a <alias>` | Show whether the service is running |
| `ProcessManager.sh -o kill -a <alias>` | Stop the service |
| `ProcessManager.sh -o priority -p <low/med/high> -a <alias>` | Change the service's scheduling priority |
| `ProcessManager.sh -o list` | List all registered service aliases |
| `ProcessManager.sh -o top [-a <alias>]` | Show details (PID, state, priority, script) for one or all services |

### Examples
```bash
./ProcessManager.sh -o register -s /home/ubuntu/myscript.sh -a service1
./ProcessManager.sh -o start -a service1
./ProcessManager.sh -o status -a service1
./ProcessManager.sh -o kill -a service1
./ProcessManager.sh -o priority -p high -a service1

./ProcessManager.sh -o list
service2
service1
service3

./ProcessManager.sh -o top
ALIAS        PID      STATE      PRIORITY SCRIPT
service1     4903     S          high     /home/ubuntu/myscript.sh
```

### How it works

- **`register`** checks the alias isn't already taken, then appends `alias|path|med` (default priority) to the registry file.
- **`start`** looks up the script path for the alias, launches it detached with `nohup bash "$path" &`, and saves the resulting `$!` (background PID) to a per-alias `.pid` file.
- **`status`** and **`kill`** both check liveness with `kill -0 <pid>` (a no-op signal used purely to test whether the process exists) before reporting status or sending `kill -9`.
- **`priority`** maps `low/med/high` to nice values (`15 / 0 / -10`), applies them live with `renice`, and rewrites the registry entry's priority field using `sed` (`s/^$alias|\([^|]*\)|.*/$alias|\1|$level/`, preserving the path).
- **`list`** just prints the alias column (`cut -d'|' -f1`).
- **`top`** loops over the registry, and for each alias (or a single one if `-a` is given) resolves the live PID and process state via `ps -o stat=`, printing a formatted table.
- Argument parsing uses `getopts "o:s:a:p:"` for the `-o/-s/-a/-p` flag style.

## Part C: Exploring Process/Log File Behavior

A hands-on demonstration of how a running process behaves when its log file is manipulated, using a background loop writing to `/tmp/test.log` via file descriptor 3.

### Setup: start a background process logging to a file
```bash
exec 3>> /tmp/test.log
while true; do echo "$(date): running" >&3; sleep 1; done &
echo "PID: $!"
```
This opens `/tmp/test.log` on file descriptor 3 and starts a background loop appending a timestamped line every second, keeping the PID for later reference (`$!`).

### 1. Clearing the log file
```bash
> /tmp/test.log
ps -p $!
```
Truncating the file (`>`) empties its content, but the process keeps running — the shell already holds the file open via FD 3, so writes continue appending to the (now-empty) file at its existing inode.

### 2. Deleting the log file
```bash
rm /tmp/test.log
ps -p $!
ls -l /proc/$!/fd/ | grep deleted
ps -o pid,ni,comm -p $!
```
Deleting the file with `rm` removes its directory entry, but the process is unaffected and keeps writing — Linux doesn't reclaim the underlying inode until every open file descriptor referencing it is closed. `/proc/<pid>/fd/` shows the descriptor still pointing to the file, marked `(deleted)`.

### 3. Elevating the process's priority
```bash
sudo renice -n -10 -p $!
ps -o pid,ni,comm -p $!
```
`renice` changes the nice value live (here from `0` to `-10`, a higher scheduling priority), without needing to restart the process. Lowering the nice value requires elevated privileges (`sudo`).

### 4. Cleanup
```bash
kill $!
exec 3>&-
rm -f /tmp/test.log
```
Kills the background loop, closes file descriptor 3, and removes the log file (which by this point no longer exists on disk, only as a dangling reference until the process was killed).

### Key takeaway

A process holds an open file by its **inode**, not by its **path**. Clearing or deleting the file doesn't stop the process from writing — the data still goes to the (possibly now-unlinked) inode, which is only truly freed once the last file descriptor referencing it is closed (here, when the process is killed or the FD is explicitly closed).

## Screenshots

<!-- Add your terminal/output screenshots below -->

### Part A: otProcessManager script and commands
<img width="898" height="63" alt="image" src="https://github.com/user-attachments/assets/3057afb6-0858-4664-aecc-fb9224750b26" />
<img width="975" height="180" alt="image" src="https://github.com/user-attachments/assets/56d98a3a-8cc3-46c3-98ac-6794ecd894eb" />
<img width="975" height="322" alt="image" src="https://github.com/user-attachments/assets/149678e0-3c6b-4a35-a3c9-376d4d4448bb" />
<img width="975" height="120" alt="image" src="https://github.com/user-attachments/assets/05241ea1-db2b-4b2e-97c2-fc0b114b3a13" />
<img width="563" height="119" alt="image" src="https://github.com/user-attachments/assets/6fd49fe9-e87f-4814-a199-e6e153e54413" />
<img width="975" height="91" alt="image" src="https://github.com/user-attachments/assets/0da4410c-4ae8-4e38-8e0b-4b6682fe09ca" />
<img width="975" height="425" alt="image" src="https://github.com/user-attachments/assets/6d43c05c-10e4-450f-8d6b-fe7bb273b47d" />
<img width="975" height="58" alt="image" src="https://github.com/user-attachments/assets/df80d956-1900-4da4-b3f5-fea2699f1698" />
<img width="975" height="82" alt="image" src="https://github.com/user-attachments/assets/3955c594-a024-490c-bd5f-855566b7539b" />

### Part B: ProcessManager.sh script
<img width="904" height="59" alt="image" src="https://github.com/user-attachments/assets/ce7a0bb0-f76c-43b0-8b80-66e0d01cff6b" />
<img width="881" height="171" alt="image" src="https://github.com/user-attachments/assets/371e0a1c-cffc-43ce-bf38-3ab9916e2f0e" />

### Part B: register, start, status, kill, priority, list, top
<img width="975" height="41" alt="image" src="https://github.com/user-attachments/assets/1b81bb35-8647-417e-a927-8d42196fe8c1" />
<img width="975" height="101" alt="image" src="https://github.com/user-attachments/assets/c18a1e40-9857-46ba-b740-689a39bdf84a" />
<img width="975" height="42" alt="image" src="https://github.com/user-attachments/assets/a5a766cd-72d8-4f18-a11e-cf3b189eeecc" />
<img width="975" height="187" alt="image" src="https://github.com/user-attachments/assets/f0891273-a029-4733-815e-ba5f784152a9" />
<img width="975" height="51" alt="image" src="https://github.com/user-attachments/assets/09b3fe7a-b184-41e0-afe6-9a424580d30a" />
<img width="975" height="122" alt="image" src="https://github.com/user-attachments/assets/e408b8de-130c-46c1-986e-d7eb0a994adf" />

### Part C: starting the background logger
<img width="975" height="99" alt="image" src="https://github.com/user-attachments/assets/f50a1300-60b3-4c79-9018-8405e1ae7855" />
<img width="769" height="665" alt="image" src="https://github.com/user-attachments/assets/4112fa35-617e-4c2a-bd98-f68ed6d439e8" />

### Part C: clearing the log file
<img width="740" height="115" alt="image" src="https://github.com/user-attachments/assets/ef617306-cf0d-43f1-89bf-a81823b7818b" />
<img width="769" height="433" alt="image" src="https://github.com/user-attachments/assets/c8ded293-253f-4fdd-9f58-1481933aea3c" />

### Part C: deleting the log file
<img width="765" height="115" alt="image" src="https://github.com/user-attachments/assets/50e958dc-e54d-4aa9-8729-8c2c676c68a1" />
<img width="975" height="120" alt="image" src="https://github.com/user-attachments/assets/1f78349d-bab1-409e-865c-49d4ac272af2" />

### Part C: elevating priority and cleanup
<img width="889" height="145" alt="image" src="https://github.com/user-attachments/assets/1dfd1416-3a17-4cb1-a29a-b6873610e11d" />
<img width="809" height="176" alt="image" src="https://github.com/user-attachments/assets/4db628a8-a0c0-473d-b62e-53fb52fccce4" />
