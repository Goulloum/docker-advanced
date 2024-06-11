#!/bin/sh
gitlab-ctl reconfigure
gitlab-rails runner "token = User.find_by_username('${GITLAB_USER}').personal_access_tokens.create(scopes: ['read_user', 'read_repository'], name: 'Runner creation token', expires_at: 365.days.from_now); token.set_token('${PAT_TOKEN}'); token.save!"
