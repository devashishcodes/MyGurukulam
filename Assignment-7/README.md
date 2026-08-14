# Assignment 7 Maven Build Utility

A shell script to manage the build lifecycle of a Maven-based Java project.

## Submitted by Devashish Sathawane

Create a utility to manage build operations of a maven based java project such as:

**Mandatory**
- Generate the artifact of project
- Upload the artifact of project to local repo
- Perform static code analysis of project using any of the tool, which will be provided as an argument in commandline
  - checkstyle
  - findbugs
  - pmd
- Perform unit test case analysis of the project
  - Unit tests
  - code coverage
- Deploy the artifact to webserver (tomcat)

**Optional**
- Generate documentation of an application
- Update build definition to fail build if various thresholds are not met in
  - checkstyle
  - findbugs
  - pmd
  - code coverage

**Repo:** https://github.com/opstree/spring3hibernate.git

```
./buildMaven.sh -a
./buildMaven.sh -i
./buildMaven.sh -s checkstyle
./buildMaven.sh -s findbugs
./buildMaven.sh -s pmd
./buildMaven.sh -t <unit_test_plugin_name>
./buildMaven.sh -d
```

**Flags**
| Flag | Meaning |
|---|---|
| `-a` | Generate the artifact |
| `-i` | Install the artifact to the local repo |
| `-s` | Run static code analysis (checkstyle / findbugs / pmd) |
| `-t` | Run unit testing (surefire / jacoco) |
| `-d` | Deploy the artifact to Tomcat |
| `-c` | (optional) Generate documentation |
| `-q` | (optional) Quiet mode, shorter output |

---

## Setup

1. Clone the script and `pom.xml` plugins into place (script auto-clones the project repo on first run).
2. Make sure Maven, Java, and Tomcat are installed.
3. Give the script execute permission:
   ```bash
   chmod +x buildMaven.sh
   ```

---

## Step 1: Generate the artifact

```bash
./buildMaven.sh -a
```

Runs `mvn clean package`. Builds the `.war` file into `target/`.

*(screenshot: terminal output showing `BUILD SUCCESS` and the `.war` file created)*

---

## Step 2: Install artifact to local repo

```bash
./buildMaven.sh -i
```

Runs `mvn clean install`. Copies the artifact into `~/.m2/repository`.

*(screenshot: terminal output showing `BUILD SUCCESS`)*

---

## Step 3: Static code analysis

```bash
./buildMaven.sh -s checkstyle
./buildMaven.sh -s findbugs
./buildMaven.sh -s pmd
```

Each command runs the matching plugin and generates a report under `target/`.

*(screenshot: checkstyle output showing violations found)*

*(screenshot: findbugs/spotbugs output)*

*(screenshot: pmd output)*

---

## Step 4: Unit tests + code coverage

```bash
./buildMaven.sh -t jacoco
```

Runs the unit tests and generates a code coverage report.

*(screenshot: terminal output showing `Tests run: X, Failures: 0` and coverage report generated)*

Coverage report: `target/site/jacoco/index.html`

---

## Step 5: Deploy to Tomcat

```bash
./buildMaven.sh -d
```

Deploys the built `.war` file to the Tomcat server using the `tomcat6-maven-plugin`.

![Deploy success](screenshots/deploy-success.png)

Once deployed, the application is live and reachable in the browser:

![App running in browser](screenshots/app-running-browser.png)

---

## Step 6 (Optional): Generate documentation

```bash
./buildMaven.sh -c
```

Runs `mvn site`, generating the project documentation site at `target/site/index.html`.

*(screenshot: docs generated / site folder)*

---

## Optional: Fail build on quality thresholds

The `pom.xml` has commented-out threshold blocks for checkstyle, findbugs, pmd, and jacoco. Uncommenting them (and setting the desired minimum values) makes the build fail automatically if code quality or test coverage drops below the configured bar - useful for enforcing quality gates in CI.

---

## Full command sequence

```bash
./buildMaven.sh -s checkstyle
./buildMaven.sh -s findbugs
./buildMaven.sh -s pmd
./buildMaven.sh -t jacoco
./buildMaven.sh -c
./buildMaven.sh -a
./buildMaven.sh -i
./buildMaven.sh -d
```