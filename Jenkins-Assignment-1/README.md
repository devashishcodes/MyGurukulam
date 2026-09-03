# CI/CD Assignment 1 – Jenkins Git Operations + Ninja File Pipeline

Submitted by Devashish Sathawane

Two Jenkins pipelines with Slack and Email notifications on every build.

**Part 1:** A parameterized job to perform Git branch operations (create, list, merge, rebase, delete).
**Part 2:** A two-job chain - first job creates a file with content, second job (auto-triggered) publishes it via a web server.

## Setup

### Install Jenkins

```bash
jenkins --version
```
<img width="679" height="59" alt="image" src="https://github.com/user-attachments/assets/634d7808-0e17-42fd-bc2f-2153e3a39a8c" />

```bash
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
```
<img width="975" height="304" alt="image" src="https://github.com/user-attachments/assets/b5da1928-4c33-437d-b82a-c7c854b212a0" />

### Create the assignment repo

Created `jenkins-assignment-repo` on GitHub.
<img width="975" height="494" alt="image" src="https://github.com/user-attachments/assets/5fbb10fc-782d-4f7b-9e1e-9023d43b316b" />

### Add GitHub credential to Jenkins

```
Manage Jenkins → Credentials → System → Global → Add Credentials
```
<img width="975" height="192" alt="image" src="https://github.com/user-attachments/assets/51ddd9e5-b10c-45b3-9f5b-20d402a234cd" />

## Slack Integration

### Create a Slack App

```
api.slack.com/apps → Create an App
```
<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/3aab4bd4-07de-459f-a5fc-9c5c0bcaf4fa" />

### Get the Bot OAuth Token

```
xoxb-************-************-********************
```
> ⚠️ Token value redacted here for security - never commit real Slack/API tokens to a public repo. Store it as a Jenkins credential (Secret text) instead, as done below.
<img width="975" height="527" alt="image" src="https://github.com/user-attachments/assets/3e977626-8a9d-4bab-9129-c6910426d9e6" />

### Add the Jenkins bot to Slack

Invited the "Jenkins CI" app to the `#jenkins-notifications` channel.
<img width="975" height="402" alt="image" src="https://github.com/user-attachments/assets/6d9fc808-7a82-49d2-bdb0-ea7bd53df596" />

### Add Slack credential in Jenkins

```
Manage Jenkins → Credentials → Add Credentials → Secret text (Slack token)
```
<img width="975" height="243" alt="image" src="https://github.com/user-attachments/assets/64c9f146-7982-40bc-aed8-ddb7561fdd55" />

### Configure Slack notifications and test connection

```
Manage Jenkins → System → Slack → Workspace, credential, default channel #jenkins-notifications
```
<img width="975" height="186" alt="image" src="https://github.com/user-attachments/assets/35f3123d-3630-4664-84ac-cc6d258afca3" />

Test message received in Slack:
<img width="975" height="102" alt="image" src="https://github.com/user-attachments/assets/7347a1d6-b83b-4021-9711-450a6e2ecf73" />

## Email Integration

### Add Gmail credential (App Password)

```
Google App Password used: piqqgmmgrjaqaffg
```
<img width="975" height="255" alt="image" src="https://github.com/user-attachments/assets/c7f9aa17-55bc-4b44-9d35-189e62f8317e" />

### Test email configuration

```
Manage Jenkins → System → Extended E-mail Notification → Test configuration by sending test e-mail
```
Email was sent successfully.
<img width="975" height="182" alt="image" src="https://github.com/user-attachments/assets/268c206c-37e4-4678-bb0f-93c17fabd413" />

## Part 1: Git-Branch-Operations Job

### Job configuration - Choice parameter for the 5 operations

```
ACTION (Choice Parameter): CREATE_BRANCH, LIST_BRANCHES, MERGE_BRANCH, REBASE_BRANCH, DELETE_BRANCH
BRANCH_NAME (String Parameter)
TARGET_BRANCH (String Parameter)
```
<img width="975" height="739" alt="image" src="https://github.com/user-attachments/assets/e714bfcf-541a-4c5d-aa6c-d4e8858db04f" />

### SCM configuration

Points to `jenkins-assignment-repo`, branch `*/main`, using the `github-creds` credential.
<img width="975" height="518" alt="image" src="https://github.com/user-attachments/assets/977a93af-3d83-48ec-9978-90fb08460611" />

### Build step (Execute shell) with a `case` block for each action, plus Email post-build action

```bash
case "$ACTION" in
  CREATE_BRANCH) ... ;;
  LIST_BRANCHES) ... ;;
  MERGE_BRANCH)  ... ;;
  REBASE_BRANCH) ... ;;
  DELETE_BRANCH) git push origin --delete "$BRANCH_NAME" ;;
  *) echo "Invalid action"; exit 1 ;;
esac
```
<img width="975" height="538" alt="image" src="https://github.com/user-attachments/assets/b5745edc-1d45-4e73-86f8-6513972e6b56" />

### Slack notification post-build action

"Notify Every Failure" checked, so a Slack message goes out whenever a step fails.
<img width="975" height="384" alt="image" src="https://github.com/user-attachments/assets/0c08f6e3-5539-4bcc-9322-addaabd8806e" />

### Job overview

`Git-Branch-Operations` job with build history showing multiple successful and failed runs.
<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/67778648-e6c6-4cd3-8ac4-08b40b9f15e1" />

### List all branches

```
ACTION = LIST_BRANCHES
```
Console shows local and remote branches.
<img width="975" height="523" alt="image" src="https://github.com/user-attachments/assets/269ce549-371a-4b02-a01c-610279c98cfd" />

### Merge one branch into another

```
ACTION = MERGE_BRANCH, BRANCH_NAME = Deva, TARGET_BRANCH = main
```
```
SUCCESS: Merged 'Deva' into 'main'.
```
<img width="975" height="525" alt="image" src="https://github.com/user-attachments/assets/20fcbb4e-5178-4e2a-b0cf-081b767f2ac3" />

### Delete a branch that doesn't exist (to trigger the failure path)

```
ACTION = DELETE_BRANCH, BRANCH_NAME = Raj, TARGET_BRANCH = main
```
<img width="975" height="524" alt="image" src="https://github.com/user-attachments/assets/524d690e-1b27-481a-a1eb-b7fe8f65ec52" />

### Slack failure notification received

```
Git-Branch-Operations - #16 Failure after 0.64 sec
```
<img width="975" height="181" alt="image" src="https://github.com/user-attachments/assets/57dfdfe2-cde0-45a5-a894-f9c5f9d7e496" />

### Email failure notification received

```
Git-Branch-Operations - Build # 16 - Failure!
```
<img width="975" height="260" alt="image" src="https://github.com/user-attachments/assets/3220ae77-0b28-4ddd-9d14-42d8bc1ca6bf" />

## Part 2: Create-Ninja-File → Publish-Ninja-File

### Job 1: Create-Ninja-File

Takes `Ninja_Name` as a string parameter, writes `"<Ninja Name> from DevOps Ninja"` to a file, and archives it as an artifact (`ninja_output.txt`). `Publish-Ninja-File` is configured as a downstream project so it triggers automatically after this job succeeds.
<img width="975" height="523" alt="image" src="https://github.com/user-attachments/assets/7ae191bb-f583-4f23-8719-ac1c7b7d2e27" />

### Run: Build with Parameters → Ninja_Name = Arjun → Build

Slack shows the chain of notifications - Git-Branch-Operations failures earlier, then `Publish-Ninja-File - #1 Success` firing automatically right after `Create-Ninja-File` completed.
<img width="975" height="523" alt="image" src="https://github.com/user-attachments/assets/1956a66d-fa49-45f2-893d-7702fc62619a" />

### Email success notification for the downstream job

```
Publish-Ninja-File - Build # 1 - Successful!
```
<img width="975" height="449" alt="image" src="https://github.com/user-attachments/assets/4cb1274c-bb0b-406b-8fd6-8a13e4df646c" />

### Verify the file is being served by the web server

```
http://54.87.2.175/ninja_output.txt
```
```
Arjun from DevOps Ninja
```
<img width="975" height="524" alt="image" src="https://github.com/user-attachments/assets/db8ce302-87df-4011-97d0-08ae80455f2f" />

## Final Dashboard

All three jobs (`Create-Ninja-File`, `Git-Branch-Operations`, `Publish-Ninja-File`) green and healthy.
<img width="975" height="524" alt="image" src="https://github.com/user-attachments/assets/c50059a1-ce34-42ea-b95f-30ebd32e8381" />
