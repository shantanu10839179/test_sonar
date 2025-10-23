#!/bin/bash

# Script to run Python analysis against external SonarQube server

# Default values
SONAR_URL="${SONAR_HOST_URL:-http://host.docker.internal:9000}"
SONAR_TOKEN="${SONAR_TOKEN:-admin}"
PROJECT_KEY="${SONAR_PROJECT_KEY:-python-demo-project}"

echo "=== Python SonarQube Analysis ==="
echo "SonarQube URL: $SONAR_URL"
echo "Project Key: $PROJECT_KEY"
echo "=================================="

# Build the image
echo "Building Docker image..."
docker build -t python-sonar-analysis .

# Run analysis with external SonarQube
echo "Running analysis..."
docker run --rm \
  -e SONAR_HOST_URL="$SONAR_URL" \
  -e SONAR_TOKEN="$SONAR_TOKEN" \
  -e SONAR_PROJECT_KEY="$PROJECT_KEY" \
  python-sonar-analysis

echo "Analysis completed!"
echo "View results at: $SONAR_URL"