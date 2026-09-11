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
<img width="975" height="378" alt="image" src="https://github.com/user-attachments/assets/103ee966-b6e1-443b-9976-3c81b7585891" />

### Verified all CLI tools are available on the Jenkins agent

Before building the jobs, confirmed every tool each stack needs is actually installed and working on the node - Python (flake8, pytest, bandit, pip-audit), Go (staticcheck, gosec, govulncheck), and Java (Maven, JDK) - since a missing tool would fail every build regardless of the Jenkins config.
<img width="975" height="778" alt="image" src="https://github.com/user-attachments/assets/eb904413-17ea-472d-a7d2-4d3ecb8d9381" />

### Added the GitHub credential

Added a `github-creds` credential in Jenkins so all three jobs can pull from GitHub using the same reusable credential ID.
<img width="975" height="219" alt="image" src="https://github.com/user-attachments/assets/f7a1a526-cb39-4a56-abd6-e6bdc5323829" />

## Slack Integration

### Added the Jenkins CI app to Slack

Installed the Jenkins CI app from the Slack App Directory and pointed it at the `#jenkins-ci-alerts` channel, where all three jobs' notifications will land.
<img width="975" height="520" alt="image" src="https://github.com/user-attachments/assets/e59cd46e-9cf2-4b58-8218-3025fcd40997" />

### Added the Slack token as a Jenkins credential

Stored the Slack bot token as a `slack-token` secret text credential so Jenkins can authenticate to Slack without the token sitting in plain job config.
<img width="975" height="203" alt="image" src="https://github.com/user-attachments/assets/52b28cc5-620e-4ce4-8216-1882360669a9" />

### Configured Slack in Jenkins global settings and tested the connection

Set the workspace, credential, and default channel, then ran "Test Connection" - came back Success.
<img width="975" height="417" alt="image" src="https://github.com/user-attachments/assets/6983be51-59f2-4e0d-82b5-8e4ba315d76b" />

Confirmed the test message actually landed in Slack.
<img width="941" height="103" alt="image" src="https://github.com/user-attachments/assets/25f38ffd-aba2-4d18-9cee-c1824fbc99df" />

## Email Integration

### Added the Gmail SMTP credential

Added a `gmail-smtp` credential (Gmail App Password) so Jenkins can send mail through Gmail's SMTP server.
<img width="975" height="253" alt="image" src="https://github.com/user-attachments/assets/4dcc007c-ca21-4da9-9b61-eaa6beaed405" />

### Configured Extended E-mail Notification

Set SMTP server to `smtp.gmail.com`, port 465 with SSL, using the Gmail SMTP credential.
<img width="975" height="306" alt="image" src="https://github.com/user-attachments/assets/b5ad1450-33fd-4f0f-a4a8-f31412afbe58" />

### Sent a test email to confirm it works end to end

Test email landed in the inbox, confirming the SMTP setup is good before wiring it into the jobs.
<img width="975" height="230" alt="image" src="https://github.com/user-attachments/assets/08b0d534-fa81-4caf-aed1-1b88a72f1ba7" />

## Built the Three Freestyle Jobs

Created one job per repo, all pointed at their GitHub repo via the shared `github-creds` credential, each with build steps for linting/testing/coverage/security scanning specific to its language, HTML Publisher steps to expose the reports in the Jenkins UI, archived artifacts, JUnit result publishing, and both Email and Slack post-build notifications set to fire on failure (and on "back to normal").

All three jobs created and visible on the dashboard: `ci-attendance-api-python`, `ci-employee-api-golang`, `ci-spring3hibernate-java`.
<img width="975" height="226" alt="image" src="https://github.com/user-attachments/assets/1d805713-08b0-45cc-9959-db5f0a4f0345" />

## Python Job – ci-attendance-api-python

### Verified the failure notification pipeline works

Deliberately let several early builds fail so I could confirm the alerting actually fires correctly, not just on a lucky first pass. Inbox shows builds #11 through #14 as "Still Failing", then #15 as "Fixed" - confirming Jenkins correctly distinguishes a repeat failure from a recovery.
<img width="975" height="159" alt="image" src="https://github.com/user-attachments/assets/03108604-c736-4da3-a8d7-4664b0cbcd4c" />

The same sequence shows up in Slack in real time - matching what the email notifications reported.
<img width="528" height="187" alt="image" src="https://github.com/user-attachments/assets/1669669e-363a-4cc2-a510-a611c0dfcc55" />

### Job dashboard - reports, artifacts, and trend

Once green, the job page shows the published HTML reports (linting + security scan), the last successful artifacts, and a test result trend graph - visibly going from mostly-failing (red) in early builds to fully passing (green) once the fixes landed.
<img width="975" height="523" alt="image" src="https://github.com/user-attachments/assets/e2988057-ef18-4a54-b28a-db7f6479660a" />

## Go Job – ci-employee-api-golang

### Failure and fix notifications by email

Build #6 failed, and the email came through immediately.
<img width="508" height="213" alt="image" src="https://github.com/user-attachments/assets/d57db81d-1f9e-4844-91bf-1513c18cc1d4" />

Build #7 then fixed it, and Jenkins sent the "Fixed" email automatically.
<img width="506" height="218" alt="image" src="https://github.com/user-attachments/assets/d30610b0-83f1-4428-b597-e5f4edcee302" />

### Same failure/recovery confirmed in Slack

Slack shows "#6 Still Failing" followed by "#7 Back to normal" - Jenkins' Slack plugin phrases a recovery as "back to normal" rather than "fixed", which is worth noting since the email plugin uses different wording for the same event.
<img width="671" height="127" alt="image" src="https://github.com/user-attachments/assets/bd5a8f46-7c09-41e7-8a27-bddb767fc217" />

### Job dashboard - coverage, security, and full artifact set

The Go job publishes both a Go Coverage Report and a GoSec Security Report as HTML, and archives everything: `coverage-summary.txt`, `coverage.html`, `coverage.out`, `go-test-report.json`, `gosec-report.html`, `govulncheck.txt`, `junit.xml`, `staticcheck.txt`, and `test-output.txt` - giving full visibility into test results, coverage, static analysis, and vulnerability scanning for every build.
<img width="975" height="526" alt="image" src="https://github.com/user-attachments/assets/7578b01d-50f0-4bfa-aa32-718e0bb8bd1e" />

## Java Job – ci-spring3hibernate-java

### Failure and fix notifications by email

Build #8 failed and triggered the failure email.
<img width="530" height="163" alt="image" src="https://github.com/user-attachments/assets/3b17a74d-b74e-4b93-8e10-1824dbb08160" />

Build #9 fixed it.
<img width="534" height="163" alt="image" src="https://github.com/user-attachments/assets/d27276e1-6c04-4716-b739-4450b9cf4c70" />

### Same sequence confirmed in Slack

"#7 Still Failing", "#8 Still Failing", then "#9 Success" - consistent with the emails.
<img width="550" height="159" alt="image" src="https://github.com/user-attachments/assets/4084515a-23d5-450e-a166-0acedeea54c1" />

### Job dashboard - unit test artifacts and trend

The Java job archives the Maven unit test outputs (`EmployeeBeanTest`, `EmployeeServiceImplTest` and their XML results) and shows a clean test result trend once stable - flat green across the last few builds with zero failures.
<img width="975" height="526" alt="image" src="https://github.com/user-attachments/assets/161be4ef-79df-4bc1-9ef7-2d3a28b63002" />

## Summary

| Job | Language | Checks run | Reports/Artifacts |
|---|---|---|---|
| ci-attendance-api-python | Python | flake8, pytest, pytest-cov, bandit, pip-audit | HTML reports, test trend |
| ci-employee-api-golang | Go | staticcheck, gosec, govulncheck, go test + coverage | Coverage HTML, GoSec HTML, JUnit XML, raw scan outputs |
| ci-spring3hibernate-java | Java | Maven unit tests | JUnit test artifacts, test trend |

All three jobs are configured with Slack and Email notifications that fire on every failure and on recovery, verified by intentionally letting early builds fail and confirming both channels reported it correctly and consistently.
