# CI/CD Assignment 3 – Multi-Language CI Pipelines in Jenkins

Submitted by Devashish Sathawane

Set up CI checks for three repositories (Python, Go, Java), each with its own Jenkins Freestyle job - running linting, unit tests, coverage, security/dependency scans, publishing the reports inside Jenkins, archiving artifacts, and sending Slack + Email alerts whenever a build fails.

**Repositories:**
- Python – `attendance-api` (OT-Microservices)
- Go – `employee-api` (OT-Microservices)
- Java – `spring3hibernate` (Opstree)

## Setup

### Installed the Jenkins plugins needed for reporting and notifications

Installed HTML Publisher (to view coverage/scan reports inside Jenkins), Email Extension Template, Slack Notification, and Config File Provider.
![Plugins installed](screenshots/cicd3-01-plugins-installed.png)

### Verified all CLI tools are available on the Jenkins agent

Before building the jobs, confirmed every tool each stack needs is actually installed and working on the node - Python (flake8, pytest, bandit, pip-audit), Go (staticcheck, gosec, govulncheck), and Java (Maven, JDK) - since a missing tool would fail every build regardless of the Jenkins config.
![Tools verified on the node](screenshots/cicd3-02-tools-verified.png)

### Added the GitHub credential

Added a `github-creds` credential in Jenkins so all three jobs can pull from GitHub using the same reusable credential ID.
![GitHub credential added](screenshots/cicd3-03-github-creds.png)

## Slack Integration

### Added the Jenkins CI app to Slack

Installed the Jenkins CI app from the Slack App Directory and pointed it at the `#jenkins-ci-alerts` channel, where all three jobs' notifications will land.
![Slack app added](screenshots/cicd3-04-slack-app-added.png)

### Added the Slack token as a Jenkins credential

Stored the Slack bot token as a `slack-token` secret text credential so Jenkins can authenticate to Slack without the token sitting in plain job config.
![Slack token credential](screenshots/cicd3-05-slack-token-credential.png)

### Configured Slack in Jenkins global settings and tested the connection

Set the workspace, credential, and default channel, then ran "Test Connection" - came back Success.
![Slack config test success](screenshots/cicd3-06-slack-config-test-success.png)

Confirmed the test message actually landed in Slack.
![Slack test message received](screenshots/cicd3-07-slack-test-message.png)

## Email Integration

### Added the Gmail SMTP credential

Added a `gmail-smtp` credential (Gmail App Password) so Jenkins can send mail through Gmail's SMTP server.
![Gmail SMTP credential](screenshots/cicd3-08-gmail-smtp-credential.png)

### Configured Extended E-mail Notification

Set SMTP server to `smtp.gmail.com`, port 465 with SSL, using the Gmail SMTP credential.
![Email-ext config](screenshots/cicd3-09-email-ext-config.png)

### Sent a test email to confirm it works end to end

Test email landed in the inbox, confirming the SMTP setup is good before wiring it into the jobs.
![Test email received](screenshots/cicd3-10-test-email-received.png)

## Built the Three Freestyle Jobs

Created one job per repo, all pointed at their GitHub repo via the shared `github-creds` credential, each with build steps for linting/testing/coverage/security scanning specific to its language, HTML Publisher steps to expose the reports in the Jenkins UI, archived artifacts, JUnit result publishing, and both Email and Slack post-build notifications set to fire on failure (and on "back to normal").

All three jobs created and visible on the dashboard: `ci-attendance-api-python`, `ci-employee-api-golang`, `ci-spring3hibernate-java`.
![Three jobs created](screenshots/cicd3-11-three-jobs-created.png)

## Python Job – ci-attendance-api-python

### Verified the failure notification pipeline works

Deliberately let several early builds fail so I could confirm the alerting actually fires correctly, not just on a lucky first pass. Inbox shows builds #11 through #14 as "Still Failing", then #15 as "Fixed" - confirming Jenkins correctly distinguishes a repeat failure from a recovery.
![Python email failure sequence](screenshots/cicd3-12-python-email-failures.png)

The same sequence shows up in Slack in real time - matching what the email notifications reported.
![Python Slack failure sequence](screenshots/cicd3-13-python-slack-failures.png)

### Job dashboard - reports, artifacts, and trend

Once green, the job page shows the published HTML reports (linting + security scan), the last successful artifacts, and a test result trend graph - visibly going from mostly-failing (red) in early builds to fully passing (green) once the fixes landed.
![Python job dashboard](screenshots/cicd3-14-python-job-dashboard.png)

## Go Job – ci-employee-api-golang

### Failure and fix notifications by email

Build #6 failed, and the email came through immediately.
![Golang email failure](screenshots/cicd3-15-golang-email-failure.png)

Build #7 then fixed it, and Jenkins sent the "Fixed" email automatically.
![Golang email fixed](screenshots/cicd3-16-golang-email-fixed.png)

### Same failure/recovery confirmed in Slack

Slack shows "#6 Still Failing" followed by "#7 Back to normal" - Jenkins' Slack plugin phrases a recovery as "back to normal" rather than "fixed", which is worth noting since the email plugin uses different wording for the same event.
![Golang Slack notifications](screenshots/cicd3-17-golang-slack-notifications.png)

### Job dashboard - coverage, security, and full artifact set

The Go job publishes both a Go Coverage Report and a GoSec Security Report as HTML, and archives everything: `coverage-summary.txt`, `coverage.html`, `coverage.out`, `go-test-report.json`, `gosec-report.html`, `govulncheck.txt`, `junit.xml`, `staticcheck.txt`, and `test-output.txt` - giving full visibility into test results, coverage, static analysis, and vulnerability scanning for every build.
![Golang job dashboard](screenshots/cicd3-18-golang-job-dashboard.png)

## Java Job – ci-spring3hibernate-java

### Failure and fix notifications by email

Build #8 failed and triggered the failure email.
![Java email failure](screenshots/cicd3-19-java-email-failure.png)

Build #9 fixed it.
![Java email fixed](screenshots/cicd3-20-java-email-fixed.png)

### Same sequence confirmed in Slack

"#7 Still Failing", "#8 Still Failing", then "#9 Success" - consistent with the emails.
![Java Slack notifications](screenshots/cicd3-21-java-slack-notifications.png)

### Job dashboard - unit test artifacts and trend

The Java job archives the Maven unit test outputs (`EmployeeBeanTest`, `EmployeeServiceImplTest` and their XML results) and shows a clean test result trend once stable - flat green across the last few builds with zero failures.
![Java job dashboard](screenshots/cicd3-22-java-job-dashboard.png)

## Summary

| Job | Language | Checks run | Reports/Artifacts |
|---|---|---|---|
| ci-attendance-api-python | Python | flake8, pytest, pytest-cov, bandit, pip-audit | HTML reports, test trend |
| ci-employee-api-golang | Go | staticcheck, gosec, govulncheck, go test + coverage | Coverage HTML, GoSec HTML, JUnit XML, raw scan outputs |
| ci-spring3hibernate-java | Java | Maven unit tests | JUnit test artifacts, test trend |

All three jobs are configured with Slack and Email notifications that fire on every failure and on recovery, verified by intentionally letting early builds fail and confirming both channels reported it correctly and consistently.
