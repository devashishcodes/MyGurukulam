# Assignment 1.1 – Basic Linux Commands

**Submitted by:** Devashish Sathawane

An exploration of core Linux directory and file commands — creating nested directories in one shot, writing to files without an editor, viewing partial file content, and copying/moving/deleting files and directories.

## Overview

This assignment walks through fundamental Linux commands for working with the filesystem entirely from the shell, without using a text editor.

## Tasks & Commands

### 1. Directories

| Task | Command |
|---|---|
| Check current directory | `pwd` |
| Create `linux` directory in current dir | `mkdir linux` |
| Create `Assignment-01` inside `linux` | `cd linux && mkdir Assignment-01` |
| Create `dir1` inside `/tmp` (without changing cwd) | `mkdir /tmp/dir1` |
| Create nested `dir1/dir2/dir3` in one command | `mkdir -p /tmp/dir1/dir2/dir3` |
| Verify directory tree recursively | `ls -R /tmp/dir1` |
| Delete `dir3` | `rmdir /tmp/dir1/dir2/dir3` |

`-p` creates parent directories as needed if they don't already exist.

### 2. Creating & Writing Files (no text editor)

| Task | Command |
|---|---|
| Create empty file with first name | `touch /tmp/devashish` |
| Add first line to file | `echo "This is my first file" > /tmp/devashish` |
| Append another line (without overwriting) | `echo "this is a additional content" >> /tmp/devashish` |
| Create file with last name + initial content | `touch /tmp/sathawane` <br> `echo "sathawane is my last name" > /tmp/sathawane` |

### 3. Adding Content at the Beginning of a File

Since `sed` isn't allowed, this is done by writing the new line to a temp file, appending the original file's content to it, then replacing the original with the temp file:

```bash
echo "this is line at the beginning" > /tmp/temp
cat /tmp/sathawane >> /tmp/temp
mv /tmp/temp /tmp/sathawane
```

### 4. Adding Multiple Lines with Heredoc

Instead of repeated `echo` commands, a heredoc (`<< EOF`) is used to append several lines at once:

```bash
cat << EOF >> /tmp/sathawane
This is line 1
This is line 2
This is line 3
...
This is line 10
EOF
```

### 5. Viewing Partial File Content

| Task | Command |
|---|---|
| Top 5 lines | `head -5 /tmp/sathawane` |
| Bottom 2 lines | `tail -2 /tmp/sathawane` |
| Only line 6 | `head -6 /tmp/sathawane \| tail -1` |
| Lines 3–8 | `head -8 /tmp/sathawane \| tail -6` |

### 6. Listing Directory Content

| Task | Command |
|---|---|
| List all content, including hidden files | `ls -la /tmp` |
| List only files (one level deep) | `find /tmp -maxdepth 1 -type f` |
| List only directories (one level deep) | `find /tmp -maxdepth 1 -type d` |

`-maxdepth 1` limits the search to the given directory only; `-type f` matches files and `-type d` matches directories.

### 7. Copying, Moving, Renaming & Deleting

| Task | Command |
|---|---|
| Copy `last-name` file into `/tmp/dir1/dir2` | `cp /tmp/sathawane /tmp/dir1/dir2` |
| Copy again with a different name | `cp /tmp/sathawane /tmp/dir1/dir2/sathawane.copy` |
| Rename `first-name` file | `mv /tmp/devashish /tmp/kashish` |
| Move `last-name` file to `/tmp/dir1` | `mv /tmp/sathawane /tmp/dir1` |
| Clear content of a file (no trailing empty line) | `> /tmp/dir1/dir2/sathawane.copy` |
| Delete the file | `rm /tmp/dir1/dir2/sathawane.copy` |

## Constraints

- No text editor (e.g. `nano`, `vim`) used to write file content — only shell redirection (`>`, `>>`) and heredocs.
- **`sed` is not used** anywhere in the assignment, as required.

## Screenshots

<!-- Add your terminal/output screenshots below -->

### PWD & Directory creation
<img width="888" height="465" alt="image" src="https://github.com/user-attachments/assets/3249b6ff-b6e6-48ca-adb1-96b760a61c67" />

### Verify the Directories Recursively  
<img width="885" height="170" alt="image" src="https://github.com/user-attachments/assets/26d9a744-d893-459c-8700-c5f3a383904d" />

### Remove Dir3
<img width="890" height="125" alt="image" src="https://github.com/user-attachments/assets/8477290b-e2fe-4682-852d-8c5aa3a28e7f" />

### Create the first name file inside /tmp
<img width="886" height="240" alt="image" src="https://github.com/user-attachments/assets/c93da8da-2508-4853-9de5-63f1c5f80920" />

### Add first line without using any text editor
<img width="892" height="75" alt="image" src="https://github.com/user-attachments/assets/51682670-696b-49f7-9079-aaae6c9d510e" />

### Add additional line inside same file
<img width="888" height="86" alt="image" src="https://github.com/user-attachments/assets/3d06e631-393d-4081-9bd3-a050250a1ab4" />

### Create last name file inside /tmp and add fist line without using text editor
<img width="887" height="88" alt="image" src="https://github.com/user-attachments/assets/900aab6e-acca-47b4-9697-a6ed17534e6b" />

### here first created the temporary file then append it with the old file using then replace the original file with the temporary file
<img width="888" height="127" alt="image" src="https://github.com/user-attachments/assets/bec0bdc7-fc22-4948-aaf8-8d5a8988a003" />

### Here I learn the new command << EOF >> instead using the echo command for multiple lines EOF used to enter multiple lines
<img width="892" height="495" alt="image" src="https://github.com/user-attachments/assets/052320c0-df46-47e9-b34e-95f46c307186" />

### Head Tails Commands
<img width="866" height="372" alt="image" src="https://github.com/user-attachments/assets/c42044c0-7d0b-4634-b977-43cf130b1c2c" />

### Here -la used to display hidden files
<img width="887" height="247" alt="image" src="https://github.com/user-attachments/assets/5be0c032-3302-4ae5-a107-c10c35a61362" />

### Here find command used to search directory or files 
#### -maxdepth 1 search only in particular one directory
#### -type f represent files 
#### -type d represent directories
<img width="897" height="340" alt="image" src="https://github.com/user-attachments/assets/bae74a96-336b-4188-aff2-f00ebe6f2804" />
<img width="897" height="375" alt="image" src="https://github.com/user-attachments/assets/ffefc696-9339-447e-afb7-0666bb2b9cf6" />
<img width="900" height="350" alt="image" src="https://github.com/user-attachments/assets/7e03e8c2-338d-418e-a2d1-16b975420d76" />

