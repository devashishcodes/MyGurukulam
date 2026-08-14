#!/bin/bash
#
set -euo pipefail

# ---------------------------------------------------------------------------
# Configuration - change these to match your environment
# ---------------------------------------------------------------------------
REPO_URL="https://github.com/opstree/spring3hibernate.git"
PROJECT_DIR="spring3hibernate"

# Tomcat deployment settings (used only by -d)
TOMCAT_WEBAPPS="/opt/tomcat/webapps"          # tomcat webapps folder
TOMCAT_MANAGER_URL="http://localhost:8080/manager/text"

# ---------------------------------------------------------------------------
# Helper: usage/help
# ---------------------------------------------------------------------------
usage() {
    cat <<EOF
Usage: $0 [-a] [-i] [-s <checkstyle|findbugs|pmd>] [-t <surefire|jacoco>] [-d] [-c] [-h]

  -a   Generate the artifact of the project (mvn package)
  -i   Install the artifact to the local repo (mvn install)
  -s   Run static code analysis (checkstyle | findbugs | pmd)
  -t   Run unit tests / code coverage (surefire | jacoco)
  -d   Deploy the artifact to Tomcat webserver
  -c   Generate project documentation (optional, mvn site)
  -h   Show this help message
EOF
    exit 1
}

# ---------------------------------------------------------------------------
# Helper: make sure the repo is cloned and cd into it
# ---------------------------------------------------------------------------
clone_repo() {
    if [ ! -d "$PROJECT_DIR" ]; then
        echo ">> Cloning $REPO_URL"
        git clone "$REPO_URL" "$PROJECT_DIR"
    fi
    cd "$PROJECT_DIR"
}

# ---------------------------------------------------------------------------
# -a : Generate artifact
# ---------------------------------------------------------------------------
generate_artifact() {
    echo ">> Generating artifact (mvn clean package)"
    mvn clean package
    echo ">> Artifact created under target/"
}

# ---------------------------------------------------------------------------
# -i : Install artifact to local repo (~/.m2/repository)
# ---------------------------------------------------------------------------
install_artifact() {
    echo ">> Installing artifact to local repo (mvn clean install)"
    mvn clean install
}

# ---------------------------------------------------------------------------
# -s : Static code analysis
# ---------------------------------------------------------------------------
static_analysis() {
    local tool="$1"
    case "$tool" in
        checkstyle)
            echo ">> Running Checkstyle"
            mvn checkstyle:checkstyle
            echo ">> Report: target/site/checkstyle.html (or checkstyle-result.xml)"
            ;;
        findbugs)
            echo ">> Running FindBugs (SpotBugs)"
            mvn com.github.spotbugs:spotbugs-maven-plugin:check
            echo ">> Report: target/spotbugsXml.xml"
            ;;
        pmd)
            echo ">> Running PMD"
            mvn pmd:pmd
            echo ">> Report: target/site/pmd.html (or pmd.xml)"
            ;;
        *)
            echo "Unknown static analysis tool: $tool"
            echo "Valid options: checkstyle | findbugs | pmd"
            exit 1
            ;;
    esac
}

# ---------------------------------------------------------------------------
# -t : Unit tests + code coverage
# ---------------------------------------------------------------------------
unit_test() {
    local plugin="$1"
    case "$plugin" in
        surefire)
            echo ">> Running unit tests (Surefire)"
            mvn test
            echo ">> Report: target/surefire-reports/"
            ;;
        jacoco)
            echo ">> Running unit tests with JaCoCo code coverage"
            mvn clean test jacoco:report
            echo ">> Coverage report: target/site/jacoco/index.html"
            ;;
        *)
            echo "Unknown unit test plugin: $plugin"
            echo "Valid options: surefire | jacoco"
            exit 1
            ;;
    esac
}

# ---------------------------------------------------------------------------
# -d : Deploy artifact to Tomcat
# ---------------------------------------------------------------------------
deploy_artifact() {
    echo ">> Deploying artifact to Tomcat"
    local war_file
    war_file=$(find target -maxdepth 1 -name "*.war" | head -n 1)

    if [ -z "$war_file" ]; then
        echo "No .war file found in target/. Run '$0 -a' first."
        exit 1
    fi

    if [ -d "$TOMCAT_WEBAPPS" ]; then
        # Simple option: copy the WAR straight into Tomcat's webapps folder
        echo ">> Copying $war_file to $TOMCAT_WEBAPPS"
        cp "$war_file" "$TOMCAT_WEBAPPS"
        echo ">> Deployed. Tomcat will auto-explode/deploy the WAR."
    else
        # Alternative: use the tomcat6-maven-plugin already configured in this
        # project's pom.xml (port 11011, context path "/")
        echo ">> Tomcat webapps dir not found locally, trying mvn tomcat6:deploy"
        mvn tomcat6:deploy
    fi
}

# ---------------------------------------------------------------------------
# -c : Generate documentation (optional)
# ---------------------------------------------------------------------------
generate_docs() {
    echo ">> Generating project documentation (mvn site)"
    mvn site
    echo ">> Docs available at target/site/index.html"
}

# ---------------------------------------------------------------------------
# Main - parse flags
# ---------------------------------------------------------------------------
if [ $# -eq 0 ]; then
    usage
fi

clone_repo

while getopts ":ais:t:dch" opt; do
    case "$opt" in
        a) generate_artifact ;;
        i) install_artifact ;;
        s) static_analysis "$OPTARG" ;;
        t) unit_test "$OPTARG" ;;
        d) deploy_artifact ;;
        c) generate_docs ;;
        h) usage ;;
        \?) echo "Invalid option: -$OPTARG"; usage ;;
        :)  echo "Option -$OPTARG requires an argument"; usage ;;
    esac
done
