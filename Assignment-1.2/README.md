# Assignment 1.2 – FileManager.sh

Submitted by Devashish Sathawane

A shell script to manage directories and files (create, delete, list, move, copy, edit content) without using `sed`.

## Make FileManager.sh file

```bash
pwd
whoami
touch FileManager.sh
ls
```
<img width="792" height="141" alt="image" src="https://github.com/user-attachments/assets/f3b39fbc-14a7-4b9d-844f-684133c7bd4b" />

## Give executable permission using chmod

```bash
ls -l FileManager.sh
chmod +x FileManager.sh
ls -l FileManager.sh
```
<img width="788" height="117" alt="image" src="https://github.com/user-attachments/assets/5d70af7a-4053-42dc-aee5-7bfcf79a1a30" />

## Write script using nano to check whether it runs or not

```bash
nano FileManager.sh
./FileManager.sh
```
<img width="760" height="212" alt="image" src="https://github.com/user-attachments/assets/c89cb14c-a510-49c9-878a-37fb5d2a1fd9" />

## Add script (Part 1 – Directory commands)

```bash
nano FileManager.sh
```
<img width="610" height="25" alt="image" src="https://github.com/user-attachments/assets/6a596eb7-6635-4759-b7e2-487a8d349824" />

## Run Script (Part 1)

```bash
./FileManager.sh addDir /tmp dir1
./FileManager.sh addDir /tmp dir2
./FileManager.sh addDir /tmp dir3
```
<img width="786" height="147" alt="image" src="https://github.com/user-attachments/assets/f7e829ba-72ad-4c9e-bce3-97cbf6b6f91b" />

```bash
./FileManager.sh listContent /tmp
./FileManager.sh listFiles /tmp
./FileManager.sh listDirs /tmp
```
<img width="787" height="446" alt="image" src="https://github.com/user-attachments/assets/2e9d77e7-e444-44d7-ab32-7d67f25de10b" />

```bash
./FileManager.sh listAll /tmp
./FileManager.sh deleteDir /tmp dir3
```
<img width="791" height="232" alt="image" src="https://github.com/user-attachments/assets/bee03337-289d-424e-812b-1a60e120c98c" />

## Add Part 2 script (File commands)

```bash
nano FileManager.sh
```
<img width="417" height="22" alt="image" src="https://github.com/user-attachments/assets/0f24d2df-09a5-4786-b48b-21e234f15567" />

Commands added: `addFile`, `addContentToFile`, `addContentToFileBegining`, `showFileBeginingContent`, `showFileEndContent`, `showFileContentAtLine`, `showFileContentForLineRange`, `moveFile`, `copyFile`, `clearFileContent`, `deleteFile`

## Run Part 2 commands

```bash
./FileManager.sh addFile /tmp/dir1 file1.txt
./FileManager.sh addFile /tmp/dir1 file2.txt "Initial Content"
./FileManager.sh addContentToFile /tmp/dir1 file2.txt "Second Line"
cat /tmp/dir1//file2.txt
```
<img width="790" height="142" alt="image" src="https://github.com/user-attachments/assets/b6b4a937-8d58-4ef0-8db3-f33d0d2c42c5" />
<img width="792" height="42" alt="image" src="https://github.com/user-attachments/assets/d09fc705-34b5-49b8-af52-c82d67c2faae" />

```bash
./FileManager.sh addContentToFileBegining /tmp/dir1 file2.txt "First Line"
cat /tmp/dir1/file2.txt
./FileManager.sh showFileBeginingContent /tmp/dir1 file2.txt 2
./FileManager.sh showFileEndContent /tmp/dir1 file2.txt 2
```
<img width="781" height="171" alt="image" src="https://github.com/user-attachments/assets/a2eb4eeb-7df1-4c86-b1fa-06ac91667c56" />

```bash
./FileManager.sh showFileContentAtLine /tmp/dir1 file2.txt 2
./FileManager.sh showFileContentForLineRange /tmp/dir1 file2.txt 1 3
```
<img width="1233" height="132" alt="image" src="https://github.com/user-attachments/assets/69cb96ef-efe2-4391-a9fd-b177383043f2" />

```bash
./FileManager.sh moveFile /tmp/dir1/file2.txt /tmp/dir1/file3.txt
ls /tmp/dir1
./FileManager.sh moveFile /tmp/dir1/file3.txt /tmp/dir2/
ls /tmp/dir2
```
<img width="1232" height="182" alt="image" src="https://github.com/user-attachments/assets/4aeae366-39e2-47d4-b183-1a5f8c0d1214" />

```bash
./FileManager.sh copyFile /tmp/dir2/file3.txt /tmp/dir1/
ls /tmp/dir1
./FileManager.sh copyFile /tmp/dir1/file3.txt /tmp/dir1/file4.txt
ls /tmp/dir1
```
<img width="1232" height="198" alt="image" src="https://github.com/user-attachments/assets/53dabee6-1811-47f8-b517-00c91a214ee0" />

```bash
./FileManager.sh clearFileContent /tmp/dir1 file4.txt
cat /tmp/dir1/file4.txt
./FileManager.sh deleteFile /tmp/dir1 file4.txt
ls /tmp/dir1
```
<img width="1232" height="171" alt="image" src="https://github.com/user-attachments/assets/d1b25c6c-eea8-4db8-a610-196c929abb4f" />
## Note

`sed` command is not used anywhere in this script, as required.
