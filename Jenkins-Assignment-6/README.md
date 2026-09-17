# CI/CD Assignment 6 – Ansible Jenkins Shared Library

Submitted by Devashish Sathawane

Built a reusable Jenkins Shared Library that wraps an entire Ansible deployment flow - **Clone → Load Configuration → SonarQube Analysis → Quality Gate → User Approval → Playbook Execution → Notification** - so any project's Jenkinsfile can just call one function instead of repeating the same pipeline logic everywhere. All the inputs (Slack channel, environment, playbook path, approval message, whether to keep the approval gate) are driven entirely by a config file living in the *consumer* repo, not hardcoded in the library.

## Building the Shared Library

### Created the library repository

Started a dedicated repo, `ansible-jenkins-shared-library`, separate from any actual application code - this is standard practice for Jenkins Shared Libraries so the same library can be reused across many projects.
<img width="975" height="521" alt="image" src="https://github.com/user-attachments/assets/fe139ee4-f460-4d91-8874-0afed95bf470" />

### Added the global variable file

Jenkins Shared Libraries expose reusable pipeline steps through files under `vars/`, where the filename becomes the callable step name. Created `vars/ansibleDeploy.groovy` - so any Jenkinsfile can later just call `ansibleDeploy()`.
<img width="975" height="274" alt="image" src="https://github.com/user-attachments/assets/d4137ea2-ad29-46c7-840b-86d229b952fd" />

### Registered the library globally in Jenkins

```
Manage Jenkins → System → Global Trusted Pipeline Libraries
Name: ansible-shared-library
Default version: main
Retrieval: Modern SCM
```
This makes the library available to every pipeline on this Jenkins instance without each job needing to re-declare where to fetch it from.
<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/d7362503-39f2-4473-b84e-0e87c98d2599" />

Pointed the SCM at the library repo itself, using the existing `github-creds` credential.
<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/e5f56b58-6541-4962-a11c-c216fa327c69" />

### Created a throwaway test job to confirm the library loads correctly

Before wiring up a real project, made a quick `assignment-6-test` Pipeline job just to sanity-check that Jenkins could resolve and load the shared library without errors.
<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/4ac2a352-9a9b-4705-9959-4ed3848bb51c" />

## Building the Consumer Project

### Created a separate "app" repository

This repo represents an actual project that would use the shared library - it holds the Jenkinsfile, the config file, and (eventually) a sample app and Ansible playbook, but none of the actual pipeline logic, which all lives in the library.
<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/48e73112-a62a-41dc-8219-d6961bb1cb06" />

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
<img width="975" height="337" alt="image" src="https://github.com/user-attachments/assets/ca2a5f53-5af0-4321-8786-8434a9f7effd" />

### Repo now has everything the pipeline needs

`config/deployment.conf`, a `Jenkinsfile` (which just calls into the shared library), a `README.md`, and `site.yml` (the actual Ansible playbook the library will run).
<img width="975" height="329" alt="image" src="https://github.com/user-attachments/assets/70b5dfff-fbe4-4be6-bd49-abab69f93092" />

### Configured the Jenkins job to pull the Jenkinsfile from this repo

```
Definition: Pipeline script from SCM
Repository URL: https://github.com/devashishcodes/assignment-6-ansible-app.git
```
<img width="975" height="525" alt="image" src="https://github.com/user-attachments/assets/0fd64a90-fb33-4663-b7ca-c69b811bcc63" />

### Updated the config once the real notification setup was ready

Adjusted `SLACK_CHANNEL_NAME` to match the actual channel already wired up in Jenkins (`jenkins-ci-alerts`) and kept `KEEP_APPROVAL_STAGE=true` so the manual gate stays active.
<img width="975" height="363" alt="image" src="https://github.com/user-attachments/assets/5502e77c-4552-40e0-adc5-762573b65cee" />

Branch set to `*/main`, script path `Jenkinsfile`, lightweight checkout enabled for faster pulls.
<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/c6c34c2c-6371-47a5-a25c-fabffc05473f" />

## First Runs and Fixing the Environment

### Early builds - stages fail past Load Configuration

The pipeline structure was already correct - the stage view shows exactly the required steps (**Clone, Load Configuration, SonarQube Analysis, Quality Gate, User Approval, Playbook Execution, Notification**) - but builds failed from SonarQube Analysis onward because SonarQube itself wasn't set up in this fresh Jenkins/SonarQube environment yet.
<img width="975" height="524" alt="image" src="https://github.com/user-attachments/assets/0bdebec7-2d9b-4b15-b524-ed35236a00ce" />

### Configured the SonarQube server in Jenkins

```
Manage Jenkins → System → SonarQube servers
Name: SonarQube, Server URL: http://localhost:9000
```
<img width="975" height="489" alt="image" src="https://github.com/user-attachments/assets/9b923eaf-5af9-4eea-a6d8-6948b403087d" />

### Confirmed all required credentials are present

`github-creds`, `slack-token`, `gmail-smtp`, and `sonar-token` - everything the shared library needs to clone, notify, and authenticate to SonarQube.
<img width="975" height="268" alt="image" src="https://github.com/user-attachments/assets/8cdf0fce-815d-4597-bc8d-4849103d0a63" />

### Created the matching project in SonarQube

Project key `assignment-6`, so the analysis triggered by the pipeline has somewhere to report to.
<img width="975" height="524" alt="image" src="https://github.com/user-attachments/assets/7024ac4b-6b75-4dbb-8e53-204293e58711" />

### Configured the SonarQube Scanner tool in Jenkins

```
Manage Jenkins → Tools → SonarQube Scanner installations
Name: sonar-scanner, Install automatically: SonarQube Scanner 8.1.0.6389
```
<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/d071df0b-e62e-4806-bc3c-4e804050df82" />

### Configured Maven

Pointed at the existing local Maven install (`/usr/share/maven`) so the Build stage can compile the Java app before SonarQube analyzes it.
<img width="975" height="525" alt="image" src="https://github.com/user-attachments/assets/ee1177ed-df09-4f02-bd1f-f7650fcfe064" />

### Added a minimal sample Java app to the repo

SonarQube needs actual source code to analyze - added `src/main/java/App.java` and a `pom.xml` to the app repo so the pipeline has something real to build and scan.
<img width="975" height="352" alt="image" src="https://github.com/user-attachments/assets/6e429340-062d-4594-9189-cc1cc21dbbfa" />

## The Pipeline Working End to End

### The User Approval stage in action

This is the manual gate the assignment specifically asked for. Mid-pipeline, the build pauses and shows a prompt - **"Deploy to prod?"** with Approve / Abort buttons - the message text pulled straight from `ACTION_MESSAGE` in the config file. Nothing downstream (Playbook Execution) runs until a human makes a decision here.
<img width="975" height="271" alt="image" src="https://github.com/user-attachments/assets/35575996-318c-419d-a083-0fe2bd0b2286" />

### All stages passing consistently

With SonarQube and Maven properly wired up, subsequent builds (#5, #7, #8) run clean through every stage, including the approval pause and the final Playbook Execution and Notification stages.
<img width="975" height="526" alt="image" src="https://github.com/user-attachments/assets/7c65ad48-0e10-4439-8f8b-29fedf289887" />

### SonarQube confirms a clean Quality Gate

`assignment-6` project shows **Passed** with 0 bugs, 0 vulnerabilities, 0 security hotspots - all A ratings.
<img width="975" height="525" alt="image" src="https://github.com/user-attachments/assets/41ec409c-02de-4062-855d-784d13812371" />

### Final Slack notification, using the config's custom message

The last message in the channel - `"Deployment completed successfully"` - is exactly the `ACTION_MESSAGE` value from `deployment.conf`, proving the shared library reads its notification text from the consumer's config rather than a hardcoded string in the library itself.
<img width="975" height="347" alt="image" src="https://github.com/user-attachments/assets/53afd8a8-78e8-461b-af33-c4e9b1e8b607" />

## How the Shared Library Satisfies Each Requirement

| Requirement | Where it lives |
|---|---|
| Clone | `Clone` stage inside `vars/ansibleDeploy.groovy`, using `GIT_URL` / `GIT_BRANCH` from the config |
| User Approval | `User Approval` stage - an `input` step showing `ACTION_MESSAGE`, gated by `KEEP_APPROVAL_STAGE` |
| Playbook Execution | `Playbook Execution` stage runs `site.yml` against `CODE_BASE_PATH` for the given `ENVIRONMENT` |
| Notification | `Notification` stage sends both Slack (to `SLACK_CHANNEL_NAME`) and Email, reporting the approval decision and final outcome |
| Inputs via config file | Every stage reads from `config/deployment.conf` in the consumer repo - the library itself is generic and contains no project-specific values |
