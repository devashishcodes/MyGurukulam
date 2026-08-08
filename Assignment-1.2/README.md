# Assignment 1.2 – FileManager.sh

**Submitted by:** Devashish Sathawane

A Bash utility script for performing basic Linux file and directory operations, built using only core Linux commands (no `sed`).

## Overview

`FileManager.sh` is a command-line tool that wraps common directory and file management tasks — creating, deleting, listing, moving, copying, and editing content — into a single script driven by simple sub-commands.

## Setup

```bash
touch FileManager.sh
chmod +x FileManager.sh
```

## Part 1: Directory Operations

| Command | Description |
|---|---|
| `addDir <path> <dirname>` | Create a directory |
| `deleteDir <path> <dirname>` | Delete a directory |
| `listContent <path>` | List all content of a directory |
| `listFiles <path>` | List only files in a directory |
| `listDirs <path>` | List only sub-directories in a directory |
| `listAll <path>` | List all files and directories (detailed) |

**Examples**
```bash
./FileManager.sh addDir /tmp dir1
./FileManager.sh addDir /tmp dir2
./FileManager.sh addDir /tmp dir3
./FileManager.sh listFiles /tmp
./FileManager.sh listDirs /tmp
./FileManager.sh listAll /tmp
./FileManager.sh deleteDir /tmp dir3
```

## Part 2: File Operations

| Command | Description |
|---|---|
| `addFile <path> <filename> [content]` | Create a file, optionally with initial content |
| `addContentToFile <path> <filename> <content>` | Append content to the end of a file |
| `addContentToFileBegining <path> <filename> <content>` | Insert content at the beginning of a file |
| `showFileBeginingContent <path> <filename> <n>` | Show the first `n` lines of a file |
| `showFileEndContent <path> <filename> <n>` | Show the last `n` lines of a file |
| `showFileContentAtLine <path> <filename> <line>` | Show content of a specific line number |
| `showFileContentForLineRange <path> <filename> <start> <end>` | Show content within a line range |
| `moveFile <source> <destination>` | Move or rename a file |
| `copyFile <source> <destination>` | Copy a file |
| `clearFileContent <path> <filename>` | Clear all content of a file |
| `deleteFile <path> <filename>` | Delete a file |

**Examples**
```bash
./FileManager.sh addFile /tmp/dir1 file1.txt
./FileManager.sh addFile /tmp/dir1 file1.txt "Initial Content"
./FileManager.sh addContentToFile /tmp/dir1 file1.txt "Additional Content"
./FileManager.sh addContentToFileBegining /tmp/dir1 file1.txt "Additional Content"
./FileManager.sh showFileBeginingContent /tmp/dir1 file1.txt 5
./FileManager.sh showFileEndContent /tmp/dir1 file1.txt 5
./FileManager.sh showFileContentAtLine /tmp/dir1 file1.txt 10
./FileManager.sh showFileContentForLineRange /tmp/dir1 file1.txt 5 10
./FileManager.sh moveFile /tmp/dir1/file1.txt /tmp/dir1/file2.txt
./FileManager.sh moveFile /tmp/dir1/file2.txt /tmp/dir2/
./FileManager.sh copyFile /tmp/dir2/file2.txt /tmp/dir1/
./FileManager.sh copyFile /tmp/dir1/file2.txt /tmp/dir1/file3.txt
./FileManager.sh clearFileContent /tmp/dir1 file3.txt
./FileManager.sh deleteFile /tmp/dir1 file2.txt
```

## Constraints

- Implemented using only basic Linux commands (`mkdir`, `rmdir`, `ls`, `find`, `touch`, `echo`, `cat`, `head`, `tail`, `mv`, `cp`, `rm`, etc.)
- **`sed` is not used** anywhere in the script, as required by the assignment.

## Screenshots

<!-- Add your terminal/output screenshots below -->

### Creating the script and setting permissions
<img width="791" height="145" alt="image" src="https://github.com/user-attachments/assets/774fd88f-329d-45c2-80ca-763b6ab0bc80" />
<img width="790" height="117" alt="image" src="https://github.com/user-attachments/assets/7e743bb6-e3d8-418b-a2b9-5a32c0ab6d20" />
<img width="760" height="215" alt="image" src="https://github.com/user-attachments/assets/043adf59-c1ec-4e53-8432-6813f9814969" />

### Running Part 1 commands (directory operations)
<img width="792" height="832" alt="image" src="https://github.com/user-attachments/assets/309077f5-5ddf-4799-a784-0e91fec65251" />

### Running Part 2 commands (file operations)
<img width="788" height="812" alt="image" src="https://github.com/user-attachments/assets/1a6f4e1b-0aaa-4646-8e8d-de020a83fd58" />
