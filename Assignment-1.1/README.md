# Assignment 1.1 – Basic Linux Commands

**Submitted by:** Devashish Sathawane

An exploration of core Linux directory and file commands — creating nested directories in one shot, writing to files without an editor, viewing partial file content, and copying/moving/deleting files and directories.

## Overview

This assignment walks through fundamental Linux commands for working with the filesystem entirely from the shell, without using a text editor.

## 1. Directories

### Check current directory, create `linux` and `Assignment-01`
```bash
pwd
mkdir linux
cd linux
mkdir Assignment-01
```
<img width="890" height="236" alt="image" src="https://github.com/user-attachments/assets/3b6110ce-434c-4fcd-98f6-866eab1eddbc" />

### Create `dir1` inside `/tmp` (without changing cwd)
```bash
mkdir /tmp/dir1
```
<img width="882" height="205" alt="image" src="https://github.com/user-attachments/assets/6ebf352e-5def-4e9d-a9f2-63a1d6fdba8c" />

### Create nested `dir1/dir2/dir3` in one command
```bash
mkdir -p /tmp/dir1/dir2/dir3
```
`-p` creates parent directories as needed if they don't already exist.
<img width="888" height="20" alt="image" src="https://github.com/user-attachments/assets/a83b2575-f340-498f-8dbd-b696286d24d8" />

### Verify the directory tree recursively
```bash
ls -R /tmp/dir1
```
<img width="888" height="170" alt="image" src="https://github.com/user-attachments/assets/ee07926b-cd61-4675-a701-23158f2e6d50" />

### Delete `dir3`
```bash
rmdir /tmp/dir1/dir2/dir3
```
<img width="887" height="130" alt="image" src="https://github.com/user-attachments/assets/101fd3d1-9e4a-4592-97ea-80bb0974d38e" />

## 2. Creating & Writing Files (no text editor)

### Create empty file with first name, add first line
```bash
touch /tmp/devashish
echo "This is my first file" > /tmp/devashish
cat /tmp/devashish
```
<img width="887" height="238" alt="image" src="https://github.com/user-attachments/assets/858889f0-7f70-45d7-a4a2-15307d6113bf" />
<img width="885" height="71" alt="image" src="https://github.com/user-attachments/assets/f7146335-fbb1-4f52-a7ca-d63673db29dd" />

### Append another line (without overwriting)
```bash
echo "this is a additional content" >> /tmp/devashish
cat /tmp/devashish
```
<img width="891" height="83" alt="image" src="https://github.com/user-attachments/assets/196af5ac-4db4-4dbb-b89d-9c304a5eca2d" />

### Create file with last name and initial content
```bash
touch /tmp/sathawane
echo "sathawane is my last name" > /tmp/sathawane
cat /tmp/sathawane
```
<img width="890" height="87" alt="image" src="https://github.com/user-attachments/assets/489600b1-94e8-435f-b301-bbf8c8fd60d6" />

## 3. Adding Content at the Beginning of a File

Since `sed` isn't allowed, this is done by writing the new line to a temp file, appending the original file's content to it, then replacing the original with the temp file:

```bash
echo "this is line at the beginning" > /tmp/temp
cat /tmp/sathawane >> /tmp/temp
mv /tmp/temp /tmp/sathawane
cat /tmp/sathawane
```
<img width="882" height="122" alt="image" src="https://github.com/user-attachments/assets/28f3df35-167f-470c-a39e-d6f77ae738c1" />

## 4. Adding Multiple Lines with Heredoc

Instead of repeated `echo` commands, a heredoc (`<< EOF`) is used to append several lines at once:

```bash
cat << EOF >> /tmp/sathawane
This is line 1
This is line 2
This is line 3
...
This is line 10
EOF
cat /tmp/sathawane
```
<img width="883" height="492" alt="image" src="https://github.com/user-attachments/assets/813bc49f-b451-4cfe-9ab8-310a9d1d390b" />

## 5. Viewing Partial File Content

```bash
head -5 /tmp/sathawane      # top 5 lines
tail -2 /tmp/sathawane      # bottom 2 lines
head -6 /tmp/sathawane | tail -1     # only line 6
head -8 /tmp/sathawane | tail -6     # lines 3-8
```
<img width="867" height="376" alt="image" src="https://github.com/user-attachments/assets/76b9709f-83a6-4b6d-a833-a86ce0df8850" />

## 6. Listing Directory Content

```bash
ls -la /tmp                          # all content, including hidden files
find /tmp -maxdepth 1 -type f        # only files
find /tmp -maxdepth 1 -type d        # only directories
```
`-maxdepth 1` limits the search to the given directory only; `-type f` matches files and `-type d` matches directories.
<img width="886" height="247" alt="image" src="https://github.com/user-attachments/assets/1058c112-2168-4746-a20b-17ebc57fa870" />
<img width="886" height="331" alt="image" src="https://github.com/user-attachments/assets/00965f22-e9dd-453b-8002-62303c0152f1" />

## 7. Copying, Moving, Renaming & Deleting

### Copy `last-name` file into `/tmp/dir1/dir2`
```bash
cp /tmp/sathawane /tmp/dir1/dir2
ls /tmp/dir1/dir2
```
<img width="882" height="77" alt="image" src="https://github.com/user-attachments/assets/1be13f2e-7119-4433-a65f-68bfa536e899" />

### Copy again with a different name
```bash
cp /tmp/sathawane /tmp/dir1/dir2/sathawane.copy
ls /tmp/dir1/dir2
```
<img width="882" height="70" alt="image" src="https://github.com/user-attachments/assets/11ef997b-f60a-4702-a032-fbca60fbec6a" />

### Rename `first-name` file
```bash
mv /tmp/devashish /tmp/kashish
ls /tmp | grep kashish
```
<img width="885" height="72" alt="image" src="https://github.com/user-attachments/assets/3a9cb6c8-d75e-4acf-beca-00801ac2d304" />

### Move `last-name` file to `/tmp/dir1`
```bash
mv /tmp/sathawane /tmp/dir1
ls /tmp/dir1
```
<img width="887" height="88" alt="image" src="https://github.com/user-attachments/assets/28d53b41-82f6-408b-97dd-d7a59f94f925" />

### Clear content of a file (no trailing empty line), then delete it
```bash
> /tmp/dir1/dir2/sathawane.copy
cat /tmp/dir1/dir2/sathawane.copy
rm /tmp/dir1/dir2/sathawane.copy
ls /tmp/dir1/dir2
```
<img width="887" height="125" alt="image" src="https://github.com/user-attachments/assets/5a59ec20-3773-4328-a03e-a2a9dbf2d706" />

## Constraints

- No text editor (e.g. `nano`, `vim`) used to write file content — only shell redirection (`>`, `>>`) and heredocs.
- **`sed` is not used** anywhere in the assignment, as required.
