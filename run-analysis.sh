#!/bin/bash

# Local SonarQube analysis script
# This script runs the tests and SonarQube analysis locally

echo "Running Python tests with coverage..."
pytest --cov=. --cov-report=xml:coverage.xml --cov-report=html:htmlcov --junitxml=test-results.xml -v

echo "Test execution completed. Check test-results.xml and coverage.xml for results."

# Check if SonarQube server URL is provided
if [ -z "$SONAR_HOST_URL" ]; then
    echo "SONAR_HOST_URL not set. Using default: http://localhost:9000"
    export SONAR_HOST_URL="http://localhost:9000"
fi

# Check if SonarQube token is provided
if [ -z "$SONAR_TOKEN" ]; then
    echo "SONAR_TOKEN not set. Using default: admin"
    export SONAR_TOKEN="admin"
fi

# Check if project key is provided
if [ -z "$SONAR_PROJECT_KEY" ]; then
    echo "SONAR_PROJECT_KEY not set. Using default: python-demo-project"
    export SONAR_PROJECT_KEY="python-demo-project"
fi

echo "Running SonarQube analysis..."
echo "Project Key: $SONAR_PROJECT_KEY"
echo "SonarQube URL: $SONAR_HOST_URL"

sonar-scanner \
  -Dsonar.projectKey=$SONAR_PROJECT_KEY \
  -Dsonar.host.url=$SONAR_HOST_URL \
  -Dsonar.login=$SONAR_TOKEN

echo "SonarQube analysis completed!"
echo "Visit $SONAR_HOST_URL to view the results."