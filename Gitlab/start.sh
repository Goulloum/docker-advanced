#!/bin/sh
sudo docker-compose up -d 
sleep 30

if [ "$1" = "init" ]; then
    echo "Initializing gitlab PAT"
    sudo docker exec gitlab-ce /bin/bash -c "gitlab-rails runner \"token = User.find_by_username('\${GITLAB_USER}').personal_access_tokens.create(scopes: ['read_user', 'read_repository', 'admin_mode', 'api'], name: 'Runner creation token', expires_at: 365.days.from_now); token.set_token('api_token'); token.save\!\""
fi


AUTH=$(curl --request POST --header "PRIVATE-TOKEN: api_token" --data "runner_type=instance_type" \
     "http://localhost:8080/api/v4/user/runners")


until $(echo $AUTH | grep -q '"token":"[^"]*'); do
    AUTH=$(curl --request POST --header "PRIVATE-TOKEN: api_token" --data "runner_type=instance_type" \
     "http://localhost:8080/api/v4/user/runners")
    echo $AUTH
    sleep 5
done


TOKEN=$(echo $AUTH |  grep -o '"token":"[^"]*' | grep -o '[^"]*$')
echo "${TOKEN} is OK"


sudo docker exec gitlab-runner /bin/bash -c "gitlab-runner register --non-interactive --name="d-in-d" --url="http://gitlab-ce:80" --token="${TOKEN}"  --executor="docker" --docker-image="docker:latest""
