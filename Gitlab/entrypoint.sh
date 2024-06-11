#!/bin/sh
# entrypoint.sh

#Get auth token
AUTH=$(curl --request POST --header "PRIVATE-TOKEN: glpat-wYygxBiD3rfwcbLZ_ma-" --data "runner_type=instance_type" \
     "${CI_SERVER_URL}/api/v4/user/runners")

TOKEN=$(echo $AUTH |  grep -o '"token":"[^"]*' | grep -o '[^"]*$')
echo "${TOKEN} is OK"

gitlab-runner register --non-interactive --name="d-in-d" --url="http://gitlab-ce:80" --token="${TOKEN}"  --executor="docker" --docker-image="docker:latest"

exec /usr/bin/dumb-init /entrypoint run --user=gitlab-runner --working-directory=/home/gitlab-runner

# gitlab-runner register --non-interactive --name="d-in-d" --url="http://localhost:8080" --token="$RUNNER_TOKEN"  --executor="docker" --docker-image="docker:latest"