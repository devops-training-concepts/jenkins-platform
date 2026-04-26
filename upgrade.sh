#!/bin/bash
set -e

JENKINS_URL="http://localhost:8080"

USER=$(yq '.jenkins.securityRealm.local.users[0].id' casc/security.yaml)
PASS=$(yq '.jenkins.securityRealm.local.users[0].password' casc/security.yaml)

AUTH="$USER:$PASS"

echo "Entering quiet mode..."
curl -s -X POST $JENKINS_URL/quietDown --user $AUTH

echo "Waiting for running builds to finish..."
while true; do
  BUSY=$(curl -s $JENKINS_URL/computer/api/json --user $AUTH | jq '.busyExecutors')
  [ "$BUSY" -eq 0 ] && break
  sleep 10
done

echo "Backing up JENKINS_HOME volume..."
VOLUME=$(docker volume ls -q | grep jenkins_home)
mkdir -p backup
docker run --rm -v ${VOLUME}:/data -v $(pwd)/backup:/backup alpine \
  sh -c "cd /data && tar czf /backup/jenkins_home_$(date +%F).tar.gz ."

echo "Rebuilding Jenkins..."
./jenkins.sh build

echo "Cancel quiet mode..."
curl -s -X POST $JENKINS_URL/cancelQuietDown --user $AUTH

echo "Upgrade completed safely."