# Assignment 6 – Process Management Utilities

Submitted by Devashish Sathawane

## Part A: otProcessManager

Utility to inspect and manage running processes.

```bash
nano otProcessManager
chmod +x otProcessManager
```
<img width="898" height="63" alt="image" src="https://github.com/user-attachments/assets/530671df-0b39-46dc-9c36-5d0f31ce635e" />

### Top n process by memory

```bash
./otProcessManager topProcess 5 memory
```
<img width="975" height="180" alt="image" src="https://github.com/user-attachments/assets/15787397-02de-4a20-b509-03471bf15d6d" />

### Top n process by cpu

```bash
./otProcessManager topProcess 10 cpu
```
<img width="975" height="322" alt="image" src="https://github.com/user-attachments/assets/2f61e380-b15e-4c7b-8fe4-db6646870cc3" />

### Kill process having least priority

```bash
sudo ./otProcessManager killLeastPriorityProcess
```
<img width="975" height="120" alt="image" src="https://github.com/user-attachments/assets/4303c171-9d1b-410f-a030-f20231f8beab" />

```bash
ps
```
<img width="563" height="119" alt="image" src="https://github.com/user-attachments/assets/66799b2b-3ed1-41e7-aabf-fde4b9e1f25f" />

### Running duration of a process by name or pid

```bash
./otProcessManager RunningDurationProcess 3957
./otProcessManager RunningDurationProcess bash
```
<img width="975" height="91" alt="image" src="https://github.com/user-attachments/assets/aa7b39f7-3483-4cea-9c59-3ccb4168409a" />

### List orphan process

```bash
./otProcessManager listOrphanProcess
```
<img width="975" height="425" alt="image" src="https://github.com/user-attachments/assets/d1e237c0-a38e-43b7-b120-180d50157160" />

### List zombie process

```bash
./otProcessManager listZoombieProcess
```
<img width="975" height="58" alt="image" src="https://github.com/user-attachments/assets/e5bcd389-316d-4dac-a62e-7b150683abbf" />

### Kill process by name or pid, list waiting process

```bash
./otProcessManager killProcess sleep
./otProcessManager ListWaitingProcess
```
<img width="975" height="82" alt="image" src="https://github.com/user-attachments/assets/6da69fc1-211c-416b-ae7a-41f91617f7a8" />

## Part B: ProcessManager.sh

Utility to register, start, stop and monitor services (like a mini daemon manager).

```bash
nano ProcessManager.sh
chmod +x ProcessManager.sh
```
<img width="904" height="59" alt="image" src="https://github.com/user-attachments/assets/27695040-c2d0-40e8-b076-a3078251b25f" />

### Setup a dummy service script to test

```bash
rm -rf ~/.processmanager
cat > dummy.sh << 'EOF'
#!/bin/bash
while true; do sleep 5; done
EOF
chmod +x dummy.sh
```
<img width="881" height="171" alt="image" src="https://github.com/user-attachments/assets/33b7e5c4-35db-41b3-9707-705bf3356e2b" />

### Register a service

```bash
./ProcessManager.sh -o register -s "$(pwd)/dummy.sh" -a myservice
```
<img width="975" height="41" alt="image" src="https://github.com/user-attachments/assets/89c5c2be-b0d7-437f-9528-871e5df51cbe" />

### Start and check status

```bash
./ProcessManager.sh -o start -a myservice
./ProcessManager.sh -o status -a myservice
```
<img width="975" height="101" alt="image" src="https://github.com/user-attachments/assets/3b57010a-080f-4a6c-b079-960c42fe284d" />

### Change priority

```bash
./ProcessManager.sh -o priority -p high -a myservice
```
<img width="975" height="42" alt="image" src="https://github.com/user-attachments/assets/a816d557-4a02-4473-9cd6-ed18fddfe066" />

### List services and top

```bash
./ProcessManager.sh -o list
./ProcessManager.sh -o top
./ProcessManager.sh -o top -a myservice
```
<img width="975" height="187" alt="image" src="https://github.com/user-attachments/assets/5cecfb89-e040-4b0d-a754-e3a529959722" />

### Kill service

```bash
./ProcessManager.sh -o kill -a myservice
```
<img width="975" height="51" alt="image" src="https://github.com/user-attachments/assets/4d3fa010-8d56-4412-90f0-ac9fd912c260" />

### Verify it's stopped

```bash
./ProcessManager.sh -o status -a myservice
./ProcessManager.sh -o top -a myservice
```
<img width="975" height="122" alt="image" src="https://github.com/user-attachments/assets/58828422-37d0-499b-b1b4-0ad54260c416" />

## Part C: Playing around with process and log file

### Start a background process writing to a log file

```bash
exec 3>> /tmp/test.log
while true; do echo "$(date): running" >&3; sleep 1; done &
echo "PID: $!"
```
<img width="975" height="99" alt="image" src="https://github.com/user-attachments/assets/f61d3cf7-5993-4762-ad26-8fbc6ddab557" />

```bash
cat /tmp/test.log
```
<img width="769" height="665" alt="image" src="https://github.com/user-attachments/assets/e4b0fa6e-8de5-41ee-9b12-14342db821ef" />

### Clear the log file of running process

```bash
> /tmp/test.log
ps -p $!
```
Process keeps running even after the file is cleared.
<img width="740" height="115" alt="image" src="https://github.com/user-attachments/assets/e7472010-3706-4414-a8d7-8aee2a53ac5b" />

```bash
cat /tmp/test.log
```
Log starts filling again since the process is still writing to it.
<img width="769" height="433" alt="image" src="https://github.com/user-attachments/assets/3d246164-da40-435c-b0b6-99e915049dcd" />

### Delete the log file and see what happens to process

```bash
rm /tmp/test.log
ps -p $!
```
Process still keeps running even after file is deleted.
<img width="765" height="115" alt="image" src="https://github.com/user-attachments/assets/afc6b94c-578a-4487-a872-c58d224a7b5b" />

```bash
ls -l /proc/$!/fd/ | grep deleted
ps -o pid,ni,comm -p $!
```
The process still holds the file open (shown as deleted in /proc/pid/fd), so it doesn't stop.
<img width="975" height="120" alt="image" src="https://github.com/user-attachments/assets/27d88fa9-537a-417f-9b87-879a08e074d5" />

### Elevate the priority of a process

```bash
sudo renice -n -10 -p $!
ps -o pid,ni,comm -p $!
```
<img width="889" height="145" alt="image" src="https://github.com/user-attachments/assets/901dfd51-7f8b-4a52-98e5-d0f876008a9f" />

### Cleanup

```bash
kill $!
exec 3>&-
rm -f /tmp/test.log
```
<img width="809" height="176" alt="image" src="https://github.com/user-attachments/assets/c4ec0977-1a60-416a-b298-49b29f71210a" />
