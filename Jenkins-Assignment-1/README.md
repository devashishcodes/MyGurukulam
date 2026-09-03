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
![Jenkins version](screenshots/cicd1-01-jenkins-version.png)

```bash
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
```
![Jenkins running](screenshots/cicd1-02-jenkins-service-running.png)

### Create the assignment repo

Created `jenkins-assignment-repo` on GitHub.
![GitHub repo](screenshots/cicd1-03-github-repo.png)

### Add GitHub credential to Jenkins

```
Manage Jenkins → Credentials → System → Global → Add Credentials
```
![GitHub credential in Jenkins](screenshots/cicd1-04-github-credential-jenkins.png)

## Slack Integration

### Create a Slack App

```
api.slack.com/apps → Create an App
```
![Create Slack app](screenshots/cicd1-05-slack-create-app.png)

### Get the Bot OAuth Token

![Slack bot token](screenshots/token.png)

### Add the Jenkins bot to Slack

Invited the "Jenkins CI" app to the `#jenkins-notifications` channel.
![Jenkins bot added to Slack](screenshots/cicd1-07-jenkins-bot-added-slack.png)

### Add Slack credential in Jenkins

```
Manage Jenkins → Credentials → Add Credentials → Secret text (Slack token)
```
![Slack credential in Jenkins](screenshots/jenkins.png)

### Configure Slack notifications and test connection

```
Manage Jenkins → System → Slack → Workspace, credential, default channel #jenkins-notifications
```
![Slack test connection success](screenshots/cicd1-09-slack-test-connection.png)

Test message received in Slack:
![Slack test message received](screenshots/cicd1-10-slack-test-message.png)

## Email Integration

### Add Gmail credential (App Password)

```
Google App Password used: piqqgmmgrjaqaffg
```
![Gmail credential added](screenshots/cicd1-11-gmail-credential.png)

### Test email configuration

```
Manage Jenkins → System → Extended E-mail Notification → Test configuration by sending test e-mail
```
Email was sent successfully.
![Email test configuration success](screenshots/cicd1-12-email-test-config.png)

## Part 1: Git-Branch-Operations Job

### Job configuration - Choice parameter for the 5 operations

```
ACTION (Choice Parameter): CREATE_BRANCH, LIST_BRANCHES, MERGE_BRANCH, REBASE_BRANCH, DELETE_BRANCH
BRANCH_NAME (String Parameter)
TARGET_BRANCH (String Parameter)
```
![Job parameters](screenshots/cicd1-13-job1-parameters.png)

### SCM configuration

Points to `jenkins-assignment-repo`, branch `*/main`, using the `github-creds` credential.
![SCM config](screenshots/cicd1-14-job1-scm-config.png)

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
![Build step and email post-build action](screenshots/cicd1-15-job1-build-step-email.png)

### Slack notification post-build action

"Notify Every Failure" checked, so a Slack message goes out whenever a step fails.
![Slack notification config](screenshots/cicd1-16-job1-slack-notification-config.png)

### Job overview

`Git-Branch-Operations` job with build history showing multiple successful and failed runs.
![Git-Branch-Operations job](screenshots/cicd1-17-git-branch-operations-job.png)

### List all branches

```
ACTION = LIST_BRANCHES
```
Console shows local and remote branches.
![List branches output](screenshots/cicd1-18-list-branch-output.png)

### Merge one branch into another

```
ACTION = MERGE_BRANCH, BRANCH_NAME = Deva, TARGET_BRANCH = main
```
```
SUCCESS: Merged 'Deva' into 'main'.
```
![Merge branch output](screenshots/cicd1-19-merge-branch-output.png)

### Delete a branch that doesn't exist (to trigger the failure path)

```
ACTION = DELETE_BRANCH, BRANCH_NAME = Raj, TARGET_BRANCH = main
```
![Delete non-existent branch](screenshots/cicd1-20-delete-nonexistent-branch.png)

### Slack failure notification received

```
Git-Branch-Operations - #16 Failure after 0.64 sec
```
![Slack failure notification](screenshots/cicd1-21-slack-failure-notification.png)

### Email failure notification received

```
Git-Branch-Operations - Build # 16 - Failure!
```
![Email failure notification](screenshots/cicd1-22-email-failure-notification.png)

## Part 2: Create-Ninja-File → Publish-Ninja-File

### Job 1: Create-Ninja-File

Takes `Ninja_Name` as a string parameter, writes `"<Ninja Name> from DevOps Ninja"` to a file, and archives it as an artifact (`ninja_output.txt`). `Publish-Ninja-File` is configured as a downstream project so it triggers automatically after this job succeeds.
![Create-Ninja-File job](screenshots/cicd1-23-create-ninja-file-job.png)

### Run: Build with Parameters → Ninja_Name = Arjun → Build

Slack shows the chain of notifications - Git-Branch-Operations failures earlier, then `Publish-Ninja-File - #1 Success` firing automatically right after `Create-Ninja-File` completed.
![Slack chain of notifications](screenshots/cicd1-24-slack-chain-notifications.png)

### Email success notification for the downstream job

```
Publish-Ninja-File - Build # 1 - Successful!
```
![Email success for Publish-Ninja-File](screenshots/cicd1-25-email-success-publish.png)

### Verify the file is being served by the web server

```
http://54.87.2.175/ninja_output.txt
```
```
Arjun from DevOps Ninja
```
![File served via web server](screenshots/cicd1-26-ninja-output-webserver.png)

## Final Dashboard

All three jobs (`Create-Ninja-File`, `Git-Branch-Operations`, `Publish-Ninja-File`) green and healthy.
![Jenkins dashboard, all jobs](screenshots/cicd1-27-jenkins-dashboard-all-jobs.png)
