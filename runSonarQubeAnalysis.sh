#!/bin/sh
# Exit on failure
set -e

# This assumes that the 2 following variables are defined:
# - SONAR_HOST_URL => should point to the public URL of the SQ server (e.g. for Nemo: https://nemo.sonarqube.org)
# - SONAR_TOKEN    => token of a user who has the "Execute Analysis" permission on the SQ server

# And run the analysis
# It assumes that the project uses Maven and has a POM at the root of the repo
echo "CIRCLE_BRANCH: ${CIRCLE_BRANCH}"
echo "CIRCLE_PR_NUMBER: ${CIRCLE_PR_NUMBER}"
echo "GITHUB_TOKEN: ${GITHUB_TOKEN}"
echo "SONAR_TOKEN: ${SONAR_TOKEN}"
echo ""
cat /usr/local/Cellar/sonar-scanner/2.8/libexec/conf/sonar-scanner.properties

if [ "${CIRCLE_PR_NUMBER}" = "" ]; then
    # => This will run a full analysis of the project and push results to the SonarQube server.
    #
    # Analysis is done only on master so that build of branches don't push analyses to the same project and therefore "pollute" the results
    echo "Starting analysis by SonarQube..."
    sonar-scanner -X \
        -Dsonar.login=$SONAR_TOKEN \
        -Dsonar.github.oauth=$GITHUB_TOKEN \
        -Dsonar.projectVersion=$CIRCLE_BRANCH
    
elif [ "$CIRCLE_PR_NUMBER" != "" ] && [ -n "${GITHUB_TOKEN}" ]; then
    # => This will analyse the PR and display found issues as comments in the PR, but it won't push results to the SonarQube server
    #
    # For security reasons environment variables are not available on the pull requests
    # coming from outside repositories
    # http://docs.travis-ci.com/user/pull-requests/#Security-Restrictions-when-testing-Pull-Requests
    # That's why the analysis does not need to be executed if the variable GITHUB_TOKEN is not defined.
    echo "Starting Pull Request analysis by SonarQube..."
    sonar-scanner -X \
        -Dsonar.login=$SONAR_TOKEN \
        -Dsonar.analysis.mode=preview \
        -Dsonar.github.oauth=$GITHUB_TOKEN \
        -Dsonar.github.pullRequest=$CIRCLE_PR_NUMBER
fi
# When neither on master branch nor on a non-external pull request => nothing to do
