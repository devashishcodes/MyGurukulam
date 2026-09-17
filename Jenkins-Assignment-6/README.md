# CI/CD Assignment 6 – Ansible Jenkins Shared Library

Submitted by Devashish Sathawane

Built a reusable Jenkins Shared Library that wraps an entire Ansible deployment flow - **Clone → Load Configuration → SonarQube Analysis → Quality Gate → User Approval → Playbook Execution → Notification** - so any project's Jenkinsfile can just call one function instead of repeating the same pipeline logic everywhere. All the inputs (Slack channel, environment, playbook path, approval message, whether to keep the approval gate) are driven entirely by a config file living in the *consumer* repo, not hardcoded in the library.

## Building the Shared Library

### Created the library repository

Started a dedicated repo, `ansible-jenkins-shared-library`, separate from any actual application code - this is standard practice for Jenkins Shared Libraries so the same library can be reused across many projects.
![Create library repo](screenshots/cicd6-01-create-library-repo.png)

### Added the global variable file

Jenkins Shared Libraries expose reusable pipeline steps through files under `vars/`, where the filename becomes the callable step name. Created `vars/ansibleDeploy.groovy` - so any Jenkinsfile can later just call `ansibleDeploy()`.
![vars/ansibleDeploy.groovy created](screenshots/cicd6-02-vars-ansibledeploy-groovy.png)

### Registered the library globally in Jenkins

```
Manage Jenkins → System → Global Trusted Pipeline Libraries
Name: ansible-shared-library
Default version: main
Retrieval: Modern SCM
```
This makes the library available to every pipeline on this Jenkins instance without each job needing to re-declare where to fetch it from.
![Library name and version config](screenshots/cicd6-03-global-trusted-lib-name.png)

Pointed the SCM at the library repo itself, using the existing `github-creds` credential.
![Library SCM source config](screenshots/cicd6-04-global-trusted-lib-scm.png)

### Created a throwaway test job to confirm the library loads correctly

Before wiring up a real project, made a quick `assignment-6-test` Pipeline job just to sanity-check that Jenkins could resolve and load the shared library without errors.
![Test job created](screenshots/cicd6-05-test-job-created.png)

## Building the Consumer Project

### Created a separate "app" repository

This repo represents an actual project that would use the shared library - it holds the Jenkinsfile, the config file, and (eventually) a sample app and Ansible playbook, but none of the actual pipeline logic, which all lives in the library.
![Create app repo](screenshots/cicd6-06-create-app-repo.png)

### Added the required config file

This is the core of the assignment - all pipeline behavior is driven by `config/deployment.conf`, matching the exact format given in the requirements:
```
SLACK_CHANNEL_NAME = build-status
ENVIRONMENT        = prod
CODE_BASE_PATH     = env/prod
ACTION_MESSAGE     = <channel message>
KEEP_APPROVAL_STAGE = true
```
The shared library's `ansibleDeploy()` step reads this file at runtime, so changing the deployment target or the approval behavior never requires touching the library code - only this config.
![deployment.conf created](screenshots/cicd6-07-deployment-conf-created.png)

### Repo now has everything the pipeline needs

`config/deployment.conf`, a `Jenkinsfile` (which just calls into the shared library), a `README.md`, and `site.yml` (the actual Ansible playbook the library will run).
![App repo files](screenshots/cicd6-08-app-repo-files.png)

### Configured the Jenkins job to pull the Jenkinsfile from this repo

```
Definition: Pipeline script from SCM
Repository URL: https://github.com/devashishcodes/assignment-6-ansible-app.git
```
![Main job SCM config](screenshots/cicd6-09-main-job-scm-config.png)

### Updated the config once the real notification setup was ready

Adjusted `SLACK_CHANNEL_NAME` to match the actual channel already wired up in Jenkins (`jenkins-ci-alerts`) and kept `KEEP_APPROVAL_STAGE=true` so the manual gate stays active.
![deployment.conf updated](screenshots/cicd6-10-deployment-conf-updated.png)

Branch set to `*/main`, script path `Jenkinsfile`, lightweight checkout enabled for faster pulls.
![Branch and script path](screenshots/cicd6-11-job-branch-script-path.png)

## First Runs and Fixing the Environment

### Early builds - stages fail past Load Configuration

The pipeline structure was already correct - the stage view shows exactly the required steps (**Clone, Load Configuration, SonarQube Analysis, Quality Gate, User Approval, Playbook Execution, Notification**) - but builds failed from SonarQube Analysis onward because SonarQube itself wasn't set up in this fresh Jenkins/SonarQube environment yet.
![First run, partial failure](screenshots/cicd6-12-first-run-partial-failure.png)

### Configured the SonarQube server in Jenkins

```
Manage Jenkins → System → SonarQube servers
Name: SonarQube, Server URL: http://localhost:9000
```
![SonarQube server setup](screenshots/cicd6-13-sonarqube-server-setup.png)

### Confirmed all required credentials are present

`github-creds`, `slack-token`, `gmail-smtp`, and `sonar-token` - everything the shared library needs to clone, notify, and authenticate to SonarQube.
![All credentials](screenshots/cicd6-14-all-credentials.png)

### Created the matching project in SonarQube

Project key `assignment-6`, so the analysis triggered by the pipeline has somewhere to report to.
![SonarQube project created](screenshots/cicd6-15-sonarqube-project-create.png)

### Configured the SonarQube Scanner tool in Jenkins

```
Manage Jenkins → Tools → SonarQube Scanner installations
Name: sonar-scanner, Install automatically: SonarQube Scanner 8.1.0.6389
```
![Sonar scanner tool config](screenshots/cicd6-16-sonar-scanner-tool-config.png)

### Configured Maven

Pointed at the existing local Maven install (`/usr/share/maven`) so the Build stage can compile the Java app before SonarQube analyzes it.
![Maven tool config](screenshots/cicd6-17-maven-tool-config.png)

### Added a minimal sample Java app to the repo

SonarQube needs actual source code to analyze - added `src/main/java/App.java` and a `pom.xml` to the app repo so the pipeline has something real to build and scan.
![Sample Java app added](screenshots/cicd6-18-sample-java-app-added.png)

## The Pipeline Working End to End

### The User Approval stage in action

This is the manual gate the assignment specifically asked for. Mid-pipeline, the build pauses and shows a prompt - **"Deploy to prod?"** with Approve / Abort buttons - the message text pulled straight from `ACTION_MESSAGE` in the config file. Nothing downstream (Playbook Execution) runs until a human makes a decision here.
![User Approval prompt](screenshots/cicd6-19-user-approval-prompt.png)

### All stages passing consistently

With SonarQube and Maven properly wired up, subsequent builds (#5, #7, #8) run clean through every stage, including the approval pause and the final Playbook Execution and Notification stages.
![All stages passing](screenshots/cicd6-20-all-stages-passing.png)

### SonarQube confirms a clean Quality Gate

`assignment-6` project shows **Passed** with 0 bugs, 0 vulnerabilities, 0 security hotspots - all A ratings.
![SonarQube Quality Gate passed](screenshots/cicd6-21-sonarqube-quality-gate-passed.png)

### Final Slack notification, using the config's custom message

The last message in the channel - `"Deployment completed successfully"` - is exactly the `ACTION_MESSAGE` value from `deployment.conf`, proving the shared library reads its notification text from the consumer's config rather than a hardcoded string in the library itself.
![Final Slack notification](screenshots/cicd6-22-slack-final-notification.png)

## How the Shared Library Satisfies Each Requirement

| Requirement | Where it lives |
|---|---|
| Clone | `Clone` stage inside `vars/ansibleDeploy.groovy`, using `GIT_URL` / `GIT_BRANCH` from the config |
| User Approval | `User Approval` stage - an `input` step showing `ACTION_MESSAGE`, gated by `KEEP_APPROVAL_STAGE` |
| Playbook Execution | `Playbook Execution` stage runs `site.yml` against `CODE_BASE_PATH` for the given `ENVIRONMENT` |
| Notification | `Notification` stage sends both Slack (to `SLACK_CHANNEL_NAME`) and Email, reporting the approval decision and final outcome |
| Inputs via config file | Every stage reads from `config/deployment.conf` in the consumer repo - the library itself is generic and contains no project-specific values |
