# Assignment 1.2 Submitted by Devashish Sathawane

## Project Name

File Manager Utility using Bash Shell Script

## Description

This assignment focuses on creating a command-line based File Manager utility using Bash Shell Script.

The utility is created using basic Linux commands and allows the user to perform different operations on directories and files.

The assignment is divided into two parts.

### Part A - Directory Management

The File Manager provides operations to:

- Create a directory
- Delete a directory
- List the contents of a directory
- List only files
- List only directories
- List all files and directories

### Part B - File Management

The File Manager is extended to perform operations on files such as:

- Create a file
- Add content to a file
- Add content at the beginning of a file
- Display the first N lines of a file
- Display the last N lines of a file
- Display content of a specific line
- Display content within a specific line range
- Move a file
- Copy a file
- Clear file content
- Delete a file

The assignment is implemented using basic Linux commands without using the sed command.

---

# Requirements

The following are required to execute this assignment:

- Ubuntu/Linux
- Bash Shell
- Basic Linux commands
- chmod
- mkdir
- rmdir
- ls
- find
- touch
- echo
- head
- tail
- cat
- mv
- cp
- rm
- nano

---

# Files

Assignment1.2/
│── FileManager.sh
│── README.md

---

# Part A - Directory Management

## 1. Create FileManager.sh

First, create the FileManager.sh file using the touch command.

### Command

touch FileManager.sh

Check whether the file has been created:

ls

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the creation of FileManager.sh using touch and checking it using ls.

---

## 2. Give Executable Permission

Before executing the shell script, executable permission is given using the chmod command.

### Command

chmod +x FileManager.sh

Check the permissions:

ls -l FileManager.sh

The x permission indicates that the file can be executed.

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing ls -l FileManager.sh before and after using chmod +x.

---

## 3. Write and Test the Script

The script can be created or edited using the nano editor.

### Command

nano FileManager.sh

A basic Bash script can be written inside the file.

Example:

#!/bin/bash

echo "Welcome to File Manager"

Run the script using:

./FileManager.sh

### Output

Welcome to File Manager

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the script opened in nano and the output after executing ./FileManager.sh.

---

# Directory Operations

## 4. Create a Directory

The addDir operation is used to create a new directory inside the specified path.

### Commands

./FileManager.sh addDir /tmp dir1

./FileManager.sh addDir /tmp dir2

./FileManager.sh addDir /tmp dir3

### Output

Directory 'dir1' created in '/tmp'
Directory 'dir2' created in '/tmp'
Directory 'dir3' created in '/tmp'

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the creation of dir1, dir2, and dir3.

---

## 5. Delete a Directory

The deleteDir operation is used to delete a directory.

### Command

./FileManager.sh deleteDir /tmp dir3

### Output

Directory 'dir3' deleted from '/tmp'

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the deletion of dir3.

---

## 6. List Content of a Directory

The listContent operation displays the contents present inside a directory.

### Command

./FileManager.sh listContent /tmp

### Output

dir1
dir2
dir3
...

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the contents of /tmp.

---

## 7. List Only Files

The listFiles operation displays only files present inside the specified directory.

### Command

./FileManager.sh listFiles /tmp

This operation uses the Linux find command to identify files.

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing only files from /tmp.

---

## 8. List Only Directories

The listDirs operation displays only directories present inside the specified location.

### Command

./FileManager.sh listDirs /tmp

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing only directories from /tmp.

---

## 9. List All Files and Directories

The listAll operation displays both files and directories.

### Command

./FileManager.sh listAll /tmp

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing all files and directories inside /tmp.

---

# Part B - File Management

The second part of the assignment extends the File Manager to support different file operations.

---

## 10. Create a File

The addFile operation creates a new file in the specified directory.

### Command

./FileManager.sh addFile /tmp/dir1 file1.txt

### Output

File Created

Check the file:

ls /tmp/dir1

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing creation of file1.txt and checking it using ls.

---

## 11. Create a File with Initial Content

A file can also be created with initial content.

### Command

./FileManager.sh addFile /tmp/dir1 file2.txt "Initial Content"

Check the contents:

cat /tmp/dir1/file2.txt

### Output

Initial Content

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing file creation with initial content and the output of cat.

---

## 12. Add Content to a File

The addContentToFile operation adds new content to the end of an existing file.

### Command

./FileManager.sh addContentToFile /tmp/dir1 file2.txt "Second Line"

Check the file:

cat /tmp/dir1/file2.txt

### Output

Initial Content
Second Line

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing content being added to the end of the file.

---

## 13. Add Content at the Beginning of a File

The addContentToFileBegining operation adds content before the existing content of a file.

### Command

./FileManager.sh addContentToFileBegining /tmp/dir1 file2.txt "First Line"

Check the file:

cat /tmp/dir1/file2.txt

### Output

First Line
Initial Content
Second Line

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing content added at the beginning of the file.

---

## 14. Show Beginning Content of a File

The showFileBeginingContent operation displays the first N lines of a file.

### Command

./FileManager.sh showFileBeginingContent /tmp/dir1 file2.txt 2

For example, if the file contains:

First Line
Initial Content
Second Line

The output will be:

First Line
Initial Content

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the first 2 lines of the file.

---

## 15. Show Ending Content of a File

The showFileEndContent operation displays the last N lines of a file.

### Command

./FileManager.sh showFileEndContent /tmp/dir1 file2.txt 2

### Output

Initial Content
Second Line

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the last 2 lines of the file.

---

## 16. Show Content at a Specific Line

The showFileContentAtLine operation displays the content of a particular line number.

### Command

./FileManager.sh showFileContentAtLine /tmp/dir1 file2.txt 2

If line 2 contains:

Initial Content

the output will be:

Initial Content

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the content of a specific line number.

---

## 17. Show Content for a Line Range

The showFileContentForLineRange operation displays the content between two specified line numbers.

### Command

./FileManager.sh showFileContentForLineRange /tmp/dir1 file2.txt 1 3

### Output

First Line
Initial Content
Second Line

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the output for the selected line range.

---

## 18. Move a File

The moveFile operation moves a file from one location to another.

### Command

./FileManager.sh moveFile /tmp/dir1/file2.txt /tmp/dir1/file3.txt

### Output

File Moved

The file can also be moved to another directory:

./FileManager.sh moveFile /tmp/dir1/file3.txt /tmp/dir2/

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the file being moved from one location to another.

---

## 19. Copy a File

The copyFile operation creates a copy of an existing file.

### Command

./FileManager.sh copyFile /tmp/dir2/file3.txt /tmp/dir1/

A file can also be copied with a new filename:

./FileManager.sh copyFile /tmp/dir1/file3.txt /tmp/dir1/file4.txt

### Output

File Copied

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the file being copied to another directory or filename.

---

## 20. Clear File Content

The clearFileContent operation removes all content from a file while keeping the file itself.

### Command

./FileManager.sh clearFileContent /tmp/dir1 file4.txt

### Output

File Content Cleared

Check the file:

cat /tmp/dir1/file4.txt

The file will be empty.

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the file before and after clearing its content.

---

## 21. Delete a File

The deleteFile operation removes a file from the specified directory.

### Command

./FileManager.sh deleteFile /tmp/dir1 file4.txt

### Output

File Deleted

Check the directory:

ls /tmp/dir1

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing deletion of the file and checking the directory afterward.

---

# Important Linux Commands Used

Command        Purpose

touch          Create an empty file
mkdir          Create a directory
rmdir          Delete an empty directory
ls             List files and directories
find           Find files and directories
echo           Display or add text
cat            Display file contents
head           Display beginning lines
tail           Display ending lines
mv             Move or rename files
cp             Copy files
rm             Delete files
chmod          Change file permissions
nano           Edit the shell script

---

# Script Execution

The complete FileManager.sh script is executed from the terminal using the following format:

./FileManager.sh <operation> <arguments>

For example:

./FileManager.sh addDir /tmp dir1

or:

./FileManager.sh addFile /tmp/dir1 file1.txt

---

# Screenshots

## 1. FileManager.sh Creation

[ADD SCREENSHOT HERE]

Screenshot showing touch FileManager.sh and the file created successfully.

---

## 2. Executable Permission

[ADD SCREENSHOT HERE]

Screenshot showing chmod +x FileManager.sh and executable permissions using ls -l.

---

## 3. Script Creation Using Nano

[ADD SCREENSHOT HERE]

Screenshot showing the Bash script written inside nano.

---

## 4. Script Testing

[ADD SCREENSHOT HERE]

Screenshot showing ./FileManager.sh execution and successful output.

---

## 5. Directory Operations

[ADD SCREENSHOT HERE]

Screenshot showing addDir, listContent, listFiles, listDirs, listAll, and deleteDir operations.

---

## 6. File Creation and Content Operations

[ADD SCREENSHOT HERE]

Screenshot showing addFile, addContentToFile, and addContentToFileBegining.

---

## 7. File Content Display Operations

[ADD SCREENSHOT HERE]

Screenshot showing beginning lines, ending lines, specific line, and line range operations.

---

## 8. Move and Copy Operations

[ADD SCREENSHOT HERE]

Screenshot showing moveFile and copyFile operations.

---

## 9. Clear and Delete File Operations

[ADD SCREENSHOT HERE]

Screenshot showing clearFileContent and deleteFile.

---

# Result

The File Manager utility was successfully created using Bash Shell Script.

The utility can perform directory and file management operations directly from the Linux terminal. The assignment demonstrates the use of basic Linux commands such as mkdir, ls, find, touch, cat, head, tail, mv, cp, rm, and chmod.

The assignment was completed without using the sed command, as required.

---

# Conclusion

This assignment provided practical knowledge of Linux file and directory management using Bash scripting.

By creating FileManager.sh, different Linux commands were combined into a single utility. The project demonstrates how command-line arguments and the case statement can be used to perform different operations based on the command given by the user.

The assignment also helped in understanding file permissions, script execution, directory management, file manipulation, and basic shell scripting.

---

# Author

Devashish Sathawane

Assignment 1.2 - Basic Linux Commands