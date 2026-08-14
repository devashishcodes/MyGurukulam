# Assignment 8 – Git Branching, Merge, Rebase, Tags & Commit Report

Submitted by Devashish Sathawane

## Part A: Merge and Rebase

### Clone repo

```bash
git clone https://github.com/devashishcodes/Assignment-8.git
```
<img width="975" height="69" alt="image" src="https://github.com/user-attachments/assets/f1b5e0e6-aa45-4fb6-aae6-e464af0cd2e1" />

### Create ninja folder, README.md, and ninja branch

```bash
cd Assignment-8/
git checkout -b ninja
mkdir -p ninja
echo "Trying fast forward merge" > ninja/README.md
git status
```
<img width="975" height="334" alt="image" src="https://github.com/user-attachments/assets/62e6b842-61dc-4b23-ad84-1b03c0b972c2" />

### Commit changes on ninja branch

```bash
git add ninja/README.md
git commit -m "Add README to ninja folder"
```
<img width="975" height="123" alt="image" src="https://github.com/user-attachments/assets/55b16a8d-2530-4cd1-899a-67f7f4d6f0f4" />

### Merge ninja into main (force merge commit)

```bash
git checkout main
git merge --no-ff ninja -m "Merge branch 'ninja' into main"
git log --oneline --graph
```
<img width="975" height="165" alt="image" src="https://github.com/user-attachments/assets/f505ff86-c50c-4dbf-88a1-4770e6f99ae9" />

### Modify README.md on main and commit

```bash
echo "Changes in main branch" > ninja/README.md
git add ninja/README.md
git commit -m "Update README in main branch"
```
<img width="975" height="117" alt="image" src="https://github.com/user-attachments/assets/1b524fc9-f831-44ce-ab64-634f85e6d227" />

### Switch to ninja, modify README.md, commit

```bash
git checkout ninja
echo "Changes in ninja branch" > ninja/README.md
git add ninja/README.md
git commit -m "Update README in ninja branch"
```
<img width="975" height="161" alt="image" src="https://github.com/user-attachments/assets/474ad71e-b1aa-4fe6-a3c5-05d53dd791d5" />

### Merge ninja into main - generate conflict

```bash
git checkout main
git merge ninja; echo "---STATUS---"; git status
```
<img width="975" height="501" alt="image" src="https://github.com/user-attachments/assets/cfe03ab0-3209-481c-a31f-6a2b1f3ba4cb" />

### Resolve conflict using theirs (ninja overrides main)

```bash
cat ninja/README.md
git checkout --theirs ninja/README.md
cat ninja/README.md
git add ninja/README.md
git commit -m "Merge ninja into main, resolved conflict using theirs (ninja override)"
```
During merge, `--ours` = branch you're on (main), `--theirs` = branch being merged in (ninja). Since we want ninja to win, we use `--theirs`.
<img width="975" height="234" alt="image" src="https://github.com/user-attachments/assets/ed728311-9f5d-44f9-b30b-72618a21604b" />

### Verify final log and content

```bash
git log
cat ninja/README.md
```
<img width="975" height="739" alt="image" src="https://github.com/user-attachments/assets/c5d08553-1eb9-4ec0-ac05-8c8b2dae3f33" />

## Good To Do: Simulate using rebase

### Setup a copy of the repo to rebase

```bash
cp -r /home/devashish/Assignment-8 /home/devashish/Assignment-8-rebase
cd Assignment-8-rebase
git log --oneline --all
git reset --hard 74682bd -q
git checkout ninja -q
git log --oneline
```
<img width="975" height="236" alt="image" src="https://github.com/user-attachments/assets/48b2548b-78f3-4c27-8c30-92d14b8c9a88" />

### Rebase ninja on main, resolve conflict

```bash
git rebase main
git checkout --theirs ninja/README.md
cat ninja/README.md
git add ninja/README.md
GIT_EDITOR=true git rebase --continue
git log --oneline --graph --all
```
<img width="975" height="463" alt="image" src="https://github.com/user-attachments/assets/346e0e60-947a-467e-a3ed-c5d0862b1c89" />

## Part B: gitBranches.sh

Script to manage branches - list, create, delete, merge, rebase.

```bash
cd Assignment-8
nano gitBranches.sh
chmod +x gitBranches.sh
```
<img width="975" height="105" alt="image" src="https://github.com/user-attachments/assets/d5591045-b1ee-494a-b129-3d0cec96440b" />

### List, create, delete branch

```bash
./gitBranches.sh -l
./gitBranches.sh -b test-branch
./gitBranches.sh -l
./gitBranches.sh -d test-branch
./gitBranches.sh -l
```
<img width="975" height="355" alt="image" src="https://github.com/user-attachments/assets/613e5c0c-699d-49f6-a073-17624ec9b847" />

### Merge two branches (-m -1 branchA -2 branchB)

```bash
./gitBranches.sh -b branchA
git checkout branchA
echo "change from A" >> ninja/README.md
git add ninja/README.md
git commit -m "A commit"
git checkout main
```
<img width="975" height="317" alt="image" src="https://github.com/user-attachments/assets/b002421e-80da-45ff-bce1-b4be480a4774" />

```bash
./gitBranches.sh -b branchB
git checkout branchB
echo "change from B" > testfile.txt
git add testfile.txt
git commit -m "B commit"
git checkout main
./gitBranches.sh -m -1 branchA -2 branchB
git log --oneline --graph -5
```
<img width="975" height="513" alt="image" src="https://github.com/user-attachments/assets/5ada5c25-72d9-4ace-b6ed-49dcc3c123d8" />

### Rebase two branches (-r -1 branchC -2 branchD)

```bash
./gitBranches.sh -b branchC
git checkout branchC
echo "change from C" >> ninja/README.md
git add ninja/README.md
git commit -m "C commit"
git checkout main
```
<img width="975" height="304" alt="image" src="https://github.com/user-attachments/assets/fd1b2607-d944-4ef9-b66e-1221f7498b60" />

```bash
./gitBranches.sh -b branchD
git checkout branchD
echo "change from D" > dfile.txt
git add dfile.txt
git commit -m "D commit"
git checkout main
./gitBranches.sh -r -1 branchC -2 branchD
git log --oneline --graph -5
```
<img width="975" height="554" alt="image" src="https://github.com/user-attachments/assets/02ff3e02-6d01-41d4-9841-716c342954ea" />

## Part C: gitTags.sh

Script to manage tags - create, list, delete.

```bash
nano gitTags.sh
chmod +x gitTags.sh
./gitTags.sh -t ninja_1.0
./gitTags.sh -t ninja_1.1
./gitTags.sh -l
./gitTags.sh -d ninja_1.0
./gitTags.sh -l
```
<img width="975" height="387" alt="image" src="https://github.com/user-attachments/assets/7a95d02b-e3a9-40ba-b5c7-06a797849320" />

## Part D: gitCommitReport.sh

Script to generate commit report of a repo (input: repo url, days; output: commit id, author, email, message, changed files, in csv/html).

```bash
nano gitCommitReport.sh
chmod +x gitCommitReport.sh
```
<img width="975" height="62" alt="image" src="https://github.com/user-attachments/assets/abdd1673-7200-46ce-8e82-2bc2840e6a81" />

### Run and check report

```bash
./gitCommitReport.sh -u https://github.com/opstree/spring3hibernate.git -d 1400
cat commit_report.csv
```
<img width="975" height="433" alt="image" src="https://github.com/user-attachments/assets/f53ca13c-eae1-48dd-b7f0-e81ad130889a" />
