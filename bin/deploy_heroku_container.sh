#!/usr/bin/env bash
set -e

heroku_app_name=$1
container_name='david-docker-staging'

image_id=$(docker inspect registry.heroku.com/$container_name/web --format={{.Id}})

curl -n -X PATCH https://api.heroku.com/apps/$heroku_app_name/formation \
  -H "Content-Type: application/json" \
  -H "Accept: application/vnd.heroku+json; version=3.docker-releases" \
  --data @<(cat <<EOF
{
  "updates": [
    {
      "type": "web",
      "docker_image": "$image_id"
    }
  ]
}
EOF
)