#!/bin/bash
# echo "Stopping beef demo containers if any"
docker compose -f build-resources/docker-compose.yml --project-name beef-compose down

