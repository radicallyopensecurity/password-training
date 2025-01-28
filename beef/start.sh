#!/bin/bash

# Stop all containers of this demo
./stop.sh

# check if none are left running (e.g., from previous versions)

# Define the keywords to match in image names
KEYWORDS="beef|juice|caddy"

# List all running containers and filter by image name using grep with extended regex
CONTAINER_IDS=$(docker ps --format "{{.ID}} {{.Image}}" | grep -E "$KEYWORDS" | awk '{print $1}')

# Check if there are any containers to stop and remove
if [ -n "$CONTAINER_IDS" ]; then
  echo "There are still containers running that are based on an image matching '$KEYWORDS'. These are probably leftovers from an earlier version/run."
  echo "more details by 'docker ps' filtered to these ids:"
  echo 
  # Display the docker ps output for only the matched container IDs
  for CONTAINER_ID in $CONTAINER_IDS; do
    docker ps --filter "id=$CONTAINER_ID" --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}"
  done
  echo 
  echo "To prevent problems, please stop and remove these containers"
  echo "by running: 'docker rm -f $CONTAINER_IDS'"
  exit -1 
fi

# Pull the latest images
docker compose -f build-resources/docker-compose.yml pull

# Attempt to bring up the services
docker compose -f build-resources/docker-compose.yml up -d --remove-orphans 2>&1
