# Assignment 8 – Git Branching, Merge, Rebase, Tags & Commit Report

Submitted by Devashish Sathawane

## Part A: Merge and Rebase

### Clone repo

```bash
git clone https://github.com/devashishcodes/Assignment-8.git
```
![Clone repo](screenshots/a8-01-clone-repo.png)

### Create ninja folder, README.md, and ninja branch

```bash
cd Assignment-8/
git checkout -b ninja
mkdir -p ninja
echo "Trying fast forward merge" > ninja/README.md
git status
```
![Ninja branch, README, status](screenshots/a8-02-ninja-branch-readme-status.png)

### Commit changes on ninja branch

```bash
git add ninja/README.md
git commit -m "Add README to ninja folder"
```
![Commit on ninja](screenshots/a8-03-commit-ninja.png)

### Merge ninja into main (force merge commit)

```bash
git checkout main
git merge --no-ff ninja -m "Merge branch 'ninja' into main"
git log --oneline --graph
```
![Merge ninja into main](screenshots/a8-04-merge-ninja-main.png)

### Modify README.md on main and commit

```bash
echo "Changes in main branch" > ninja/README.md
git add ninja/README.md
git commit -m "Update README in main branch"
```
![Modify on main and commit](screenshots/a8-05-modify-main-commit.png)

### Switch to ninja, modify README.md, commit

```bash
git checkout ninja
echo "Changes in ninja branch" > ninja/README.md
git add ninja/README.md
git commit -m "Update README in ninja branch"
```
![Modify on ninja and commit](screenshots/a8-06-modify-ninja-commit.png)

### Merge ninja into main - generate conflict

```bash
git checkout main
git merge ninja; echo "---STATUS---"; git status
```
![Merge conflict](screenshots/a8-07-merge-conflict.png)

### Resolve conflict using theirs (ninja overrides main)

```bash
cat ninja/README.md
git checkout --theirs ninja/README.md
cat ninja/README.md
git add ninja/README.md
git commit -m "Merge ninja into main, resolved conflict using theirs (ninja override)"
```
During merge, `--ours` = branch you're on (main), `--theirs` = branch being merged in (ninja). Since we want ninja to win, we use `--theirs`.
![Resolve using theirs](screenshots/a8-08-resolve-theirs.png)

### Verify final log and content

```bash
git log
cat ninja/README.md
```
![Final git log](screenshots/a8-09-git-log-final.png)

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
![Rebase setup](screenshots/a8-10-rebase-setup.png)

### Rebase ninja on main, resolve conflict

```bash
git rebase main
git checkout --theirs ninja/README.md
cat ninja/README.md
git add ninja/README.md
GIT_EDITOR=true git rebase --continue
git log --oneline --graph --all
```
![Rebase conflict resolve](screenshots/a8-11-rebase-conflict-resolve.png)

## Part B: gitBranches.sh

Script to manage branches - list, create, delete, merge, rebase.

```bash
cd Assignment-8
nano gitBranches.sh
chmod +x gitBranches.sh
```
![Write script and chmod](screenshots/a8-12-write-gitbranches-chmod.png)

### List, create, delete branch

```bash
./gitBranches.sh -l
./gitBranches.sh -b test-branch
./gitBranches.sh -l
./gitBranches.sh -d test-branch
./gitBranches.sh -l
```
![List, create, delete branch](screenshots/a8-13-list-create-delete-branch.png)

### Merge two branches (-m -1 branchA -2 branchB)

```bash
./gitBranches.sh -b branchA
git checkout branchA
echo "change from A" >> ninja/README.md
git add ninja/README.md
git commit -m "A commit"
git checkout main
```
![Create branchA, commit](screenshots/a8-14-branchA-commit.png)

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
![Merge branchA into branchB](screenshots/a8-15-branchB-merge.png)

### Rebase two branches (-r -1 branchC -2 branchD)

```bash
./gitBranches.sh -b branchC
git checkout branchC
echo "change from C" >> ninja/README.md
git add ninja/README.md
git commit -m "C commit"
git checkout main
```
![Create branchC, commit](screenshots/a8-16-branchC-commit.png)

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
![Rebase branchC onto branchD](screenshots/a8-17-branchD-rebase.png)

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
![gitTags create/list/delete](screenshots/a8-18-gittags.png)

## Part D: gitCommitReport.sh

Script to generate commit report of a repo (input: repo url, days; output: commit id, author, email, message, changed files, in csv/html).

```bash
nano gitCommitReport.sh
chmod +x gitCommitReport.sh
```
![Write script and chmod](screenshots/a8-19-write-commitreport-chmod.png)

### Run and check report

```bash
./gitCommitReport.sh -u https://github.com/opstree/spring3hibernate.git -d 1400
cat commit_report.csv
```
![Commit report output](screenshots/a8-20-commit-report-output.png)
