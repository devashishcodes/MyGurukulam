# CI/CD Assignment 2 – Jenkins User Authentication & Authorization

Submitted by Devashish Sathawane

**Part 1:** Role-based access control for 3 teams (Developer, Testing, DevOps) across 9 jobs and 3 views, using Jenkins' Role-Based Authorization Strategy.
**Part 2:** Google SSO login for the admin user.

## Part 1: Role-Based Authorization

### Install required plugins

```
Manage Jenkins → Plugins → Available plugins
```
Installed: **Role-based Authorization Strategy** and **Google Login**.
![Install plugins](screenshots/cicd2-01-install-plugins.png)

```
Download progress - all success
```
![Plugins installed](screenshots/cicd2-02-plugins-installed.png)

### Create the 9 jobs

Each is a Freestyle project with an Execute shell build step:
```bash
echo "Job Name: $JOB_NAME"
echo "Build Number: $BUILD_NUMBER"
```
Repeated for: `dev-1/2/3`, `test-1/2/3`, `devops-1/2/3`.
![Jobs list - dev and devops](screenshots/cicd2-03-jobs-list-dev-devops.png)
![Jobs list - test](screenshots/cicd2-04-jobs-list-test.png)

### Create 3 views

List View, filtered by job name pattern for each team:
- **Developer View** → dev-1, dev-2, dev-3
- **Testing View** → test-1, test-2, test-3
- **DevOps View** → devops-1, devops-2, devops-3
![Three views on dashboard](screenshots/cicd2-05-three-views.png)

### Create the users

```
Manage Jenkins → Users → Create User
```
Created: developer-1, developer-2, testing-1, testing-2, devops-1, devops-2, admin-1.
![Users created](screenshots/cicd2-06-users-created.png)

### Enable Role-Based Strategy

```
Manage Jenkins → Security → Authorization → Role-Based Strategy → Save
```
This strategy was chosen (over Legacy, Project-based, or Matrix-based) because it lets permissions be assigned by **regex pattern on job names** (`dev-.*`, `test-.*`, `devops-.*`), which maps directly onto the team/job-prefix structure asked for here - Matrix-based would need per-job checkboxes for every user, and Project-based would need per-job role assignment one at a time.
![Role-Based Strategy selected](screenshots/cicd2-07-role-based-strategy-selected.png)

### Configure Global roles

```
Manage Jenkins → Manage Roles → Global roles
```
- `admin` → Overall/Administer (full access)
- `user-read` → Overall/Read (so logged-in users can at least see the dashboard shell)
![Global roles](screenshots/cicd2-08-global-roles.png)

### Configure Item roles (the core of the access control)

```
Manage Jenkins → Manage Roles → Item roles
```
| Role | Pattern | Permissions |
|---|---|---|
| dev-full | `dev-.*` | Build, Configure, Read, Workspace |
| dev-view | `dev-.*` | Read only |
| test-full | `test-.*` | Build, Configure, Read, Workspace |
| test-view | `test-.*` | Read only |
| devops-full | `devops-.*` | Build, Configure, Read, Workspace |
| devops-view | `devops-.*` | Read only |
![Item roles config](screenshots/cicd2-09-item-roles-config.png)

### Assign roles to users - Global roles

```
Manage and Assign Roles → Assign Roles
```
`admin-1` (and `admin`) → `admin`. All other users → `user-read` (basic dashboard access).
![Assign global roles](screenshots/cicd2-10-assign-global-roles.png)

### Assign roles to users - Item roles

| User | Roles assigned |
|---|---|
| developer-1, developer-2 | `dev-full` |
| testing-1, testing-2 | `dev-view` + `test-full` |
| devops-1, devops-2 | `dev-view` + `devops-full` + `test-view` |

This matches the requirement exactly: developers only touch dev jobs; testers get full control of test jobs and can view dev jobs; devops gets full control of devops jobs and can view both dev and test jobs.
![Assign item roles](screenshots/cicd2-11-assign-item-roles.png)

## Verify using every user login

### developer-1

Only sees `dev-1/2/3`, only the "Developer View" tab.
![Developer 1 view](screenshots/cicd2-12-verify-developer1.png)

### developer-2

Same as developer-1.
![Developer 2 view](screenshots/cicd2-13-verify-developer2.png)

### devops-1

Sees all 9 jobs (dev, devops, test) across all 3 view tabs, but build (▶) buttons only appear on devops jobs.
![Devops 1 view](screenshots/cicd2-14-verify-devops1.png)

### devops-2

Same as devops-1.
![Devops 2 view](screenshots/cicd2-15-verify-devops2.png)

### testing-1

Sees dev + test jobs only (no devops), build buttons only on test jobs.
![Testing 1 view](screenshots/cicd2-16-verify-testing1.png)

### testing-2

Same as testing-1.
![Testing 2 view](screenshots/cicd2-17-verify-testing2.png)

## Part 2: Enable Google SSO for Admin

### Create a new Google Cloud project

```
console.cloud.google.com → New Project: "Jenkins-SSO"
```
![GCP new project](screenshots/cicd2-18-gcp-new-project.png)

### Configure OAuth consent screen

App name "Jenkins SSO", support email set.
![OAuth consent - app info](screenshots/cicd2-19-oauth-consent-app-info.png)

Scopes requested: `userinfo.email`, `userinfo.profile`, `openid`.
![OAuth scopes](screenshots/cicd2-20-oauth-scopes.png)

### Create credentials (OAuth client ID)

```
APIs & Services → Credentials → Create Credentials → OAuth client ID
Application type: Web application
```
![Create OAuth client](screenshots/cicd2-21-create-oauth-client.png)

Client ID and secret generated:
```
Client ID:     291001868834-7b71ft3pfvs885mspunoj7br7i7j5dbf.apps.googleusercontent.com
Client Secret: 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
```
![OAuth client created](screenshots/cicd2-22-oauth-client-created.png)

### Configure Jenkins Security Realm

```
Manage Jenkins → Security → Authentication → Security Realm → Login with Google
```
Client ID and Client Secret pasted in.
![Jenkins Security Realm - Login with Google](screenshots/cicd2-23-jenkins-security-realm-google.png)

### Grant the admin's Google email the admin role

Added `devashish5848@gmail.com` (admin's Google account) to Global roles and checked `admin`.
![Admin email granted admin role](screenshots/cicd2-24-admin-email-role.png)

### Login flow via Google

"Sign in with Google" prompt, continuing to "Jenkins SSO".
![Google sign-in screen](screenshots/cicd2-25-google-signin-screen.png)

### Successfully logged into Jenkins via Google

Logged in as "Devashish Sathawane" (`devashish5848@gmail.com`) with full profile access - confirming Google SSO works end to end for the admin user.
![Logged in via Google SSO](screenshots/cicd2-26-logged-in-via-google.png)

## Note on Authorization Strategies

Went through all four before picking one:

| Strategy | Why not used here |
|---|---|
| **Legacy mode** | No per-user control at all - any logged-in user gets full access. Not usable for team separation. |
| **Project-based Matrix** | Per-job permission grids, but each job needs its own manual setup - doesn't scale to "all jobs starting with dev-" cleanly. |
| **Matrix-based** | Global grid only, no per-job or per-pattern granularity - can't restrict a user to just the `devops-*` jobs. |
| **Role-Based Strategy** ✅ | Supports regex-pattern item roles (`dev-.*`, `test-.*`, `devops-.*`), so one role definition covers a whole team's jobs and new jobs matching the pattern are automatically covered. |
