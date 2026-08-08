# Assignment 1.1 – Basic Linux Commands

Submitted by: Devashish Sathawane

============================================================

OVERVIEW
============================================================

This assignment focuses on practicing basic Linux commands for
managing directories, files, and file contents.

The assignment was completed using the Linux terminal without using
the sed command.

============================================================

1. DIRECTORY MANAGEMENT
============================================================

First, I checked my current working directory using the pwd command
and created the required directories using the mkdir command.

The following directory structure was created:

/tmp
└── dir1
    └── dir2
        └── dir3

The complete nested structure was created using:

mkdir -p /tmp/dir1/dir2/dir3

I verified the directory structure using:

ls -R /tmp/dir1

After verification, I removed dir3 using:

rmdir /tmp/dir1/dir2/dir3


SCREENSHOT:
[ADD SCREENSHOT HERE – Directory Creation and Removal]


============================================================

2. CREATING AND WRITING TO A FILE
============================================================

I created an empty file using the touch command:

touch /tmp/Devashish

Then I added the first line to the file using:

echo "This is my first line" > /tmp/Devashish

The > operator is used to write content into a file.

To add another line without overwriting the existing content, I used:

echo "this is a additional content" >> /tmp/Devashish

The >> operator appends new content to the existing file.

I used the cat command to check the contents of the file:

cat /tmp/Devashish


SCREENSHOT:
[ADD SCREENSHOT HERE – File Creation and Content]


============================================================

3. CREATING THE LAST NAME FILE
============================================================

I created another file using my last name:

touch /tmp/Sathawane

Then I added content to the file:

echo "Sathawane is my last name" > /tmp/Sathawane

The content was verified using:

cat /tmp/Sathawane


SCREENSHOT:
[ADD SCREENSHOT HERE – Last Name File]


============================================================

4. ADDING A LINE AT THE BEGINNING
============================================================

The requirement was to add a new line at the beginning of the file
without using a text editor.

I used a temporary file to achieve this:

echo "this is line at the beginning" > /tmp/temp
cat /tmp/Sathawane >> /tmp/temp
mv /tmp/temp /tmp/Sathawane

The temporary file was created with the new first line, the existing
file content was appended to it, and finally the temporary file was
renamed to the original filename.

The final file was checked using:

cat /tmp/Sathawane


SCREENSHOT:
[ADD SCREENSHOT HERE – Adding Line at Beginning]


============================================================

5. ADDING MULTIPLE LINES
============================================================

I added multiple lines to the same file without using a text editor.

I used the cat << EOF method:

cat << EOF >> /tmp/Sathawane
This is line 1
This is line 2
This is line 3
This is line 4
This is line 5
This is line 6
This is line 7
This is line 8
This is line 9
This is line 10
EOF

This method allows multiple lines to be entered directly from the
terminal.

I verified the complete file using:

cat /tmp/Sathawane


SCREENSHOT:
[ADD SCREENSHOT HERE – Multiple Lines]


============================================================

6. VIEWING SPECIFIC LINES OF A FILE
============================================================

I used the head and tail commands to display specific portions
of the file.

Top 5 Lines:

head -5 /tmp/Sathawane

Bottom 2 Lines:

tail -2 /tmp/Sathawane

Only the 6th Line:

head -6 /tmp/Sathawane | tail -1

Lines 3 to 8:

head -8 /tmp/Sathawane | tail -6

These commands helped me understand how to display only the required
lines from a file.


SCREENSHOT:
[ADD SCREENSHOT HERE – Head and Tail Commands]


============================================================

7. LISTING FILES AND DIRECTORIES
============================================================

I used the ls and find commands to list the contents of /tmp.

To list all content including hidden files:

ls -la /tmp

The -a option displays hidden files and the -l option displays
detailed information.

To list only files:

find /tmp -maxdepth 1 -type f

Here:

-maxdepth 1 limits the search to /tmp.
-type f represents regular files.

To list only directories:

find /tmp -maxdepth 1 -type d

Here -type d represents directories.


SCREENSHOT:
[ADD SCREENSHOT HERE – Listing Files and Directories]


============================================================

8. COPYING FILES
============================================================

I copied the last-name file into the dir2 directory using the cp
command:

cp /tmp/Sathawane /tmp/dir1/dir2/

This created a copy with the same filename.

I then created another copy with a different name:

cp /tmp/Sathawane /tmp/dir1/dir2/Sathawane.copy

After this, the directory contained:

Sathawane
Sathawane.copy


SCREENSHOT:
[ADD SCREENSHOT HERE – Copying Files]


============================================================

9. RENAMING A FILE
============================================================

I used the mv command to rename the first-name file:

mv /tmp/Devashish /tmp/Kashish

The mv command can be used to rename a file when the source and
destination are in the same directory.

I verified the renamed file using:

ls /tmp


SCREENSHOT:
[ADD SCREENSHOT HERE – Renaming File]


============================================================

10. MOVING A FILE
============================================================

I moved the last-name file from /tmp to /tmp/dir1 using:

mv /tmp/Sathawane /tmp/dir1/

I verified the file using:

ls /tmp/dir1

The mv command is used for both moving and renaming files.


SCREENSHOT:
[ADD SCREENSHOT HERE – Moving File]


============================================================

11. CLEARING FILE CONTENT
============================================================

I cleared the content of the copied file without deleting the file.

I used:

> /tmp/dir1/dir2/Sathawane.copy

This removed all the content from the file while keeping the file
itself.

I verified the file using:

cat /tmp/dir1/dir2/Sathawane.copy

The file was empty.


SCREENSHOT:
[ADD SCREENSHOT HERE – Clearing File Content]


============================================================

12. DELETING THE FILE
============================================================

After clearing the file content, I deleted the same file using:

rm /tmp/dir1/dir2/Sathawane.copy

I verified the deletion using:

ls /tmp/dir1/dir2


SCREENSHOT:
[ADD SCREENSHOT HERE – Deleting File]


============================================================

COMMANDS LEARNED
============================================================

pwd       - Shows the current working directory
mkdir     - Creates a directory
mkdir -p  - Creates nested directories
ls        - Lists files and directories
ls -la    - Lists all files including hidden files
ls -R     - Lists directories recursively
rmdir     - Removes an empty directory
touch     - Creates an empty file
echo      - Writes content to a file
cat       - Displays file content
head      - Displays beginning lines of a file
tail      - Displays ending lines of a file
find      - Finds files and directories
cp        - Copies files
mv        - Moves or renames files
rm        - Deletes files
>         - Writes or clears file content
>>        - Appends content to a file
|         - Passes output of one command to another command


============================================================

KEY LEARNINGS
============================================================

Through this assignment, I learned how to:

- Check the current working directory.
- Create directories and nested directory structures.
- Create empty files.
- Write and append content to files.
- Add multiple lines without using a text editor.
- Display specific lines from a file.
- Find files and directories using the find command.
- List hidden files and directories.
- Copy files with the same and different names.
- Rename files using mv.
- Move files between directories.
- Clear file content without deleting the file.
- Delete files and empty directories.


============================================================

CONCLUSION
============================================================

This assignment gave me hands-on practice with basic Linux file and
directory management commands.

I learned how to perform common file operations directly from the
Linux terminal, including creating, viewing, modifying, copying,
moving, renaming, clearing, and deleting files and directories.

This assignment helped me build a strong foundation for working with
Linux commands and the terminal.


============================================================

NOTE
============================================================

The sed command was not used in this assignment, as instructed.