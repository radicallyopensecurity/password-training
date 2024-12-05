#!/bin/bash

# Stop all containers of this demo
./stop.sh

# check if none are left running (e.g., from previous versions)
# Array of container names to check
container_names=("beef" "juice" "caddy")

# Get the list of running container names
running_containers=$(docker ps --format '{{.Names}}')

# Loop through each container name substring
for name in "${container_names[@]}"; do
    # Check if any running container name contains the given substring
    matching_containers=$(echo "$running_containers" | grep "$name")
    if [ -n "$matching_containers" ]; then
        echo "There is still a container running with the name '$matching_containers', probably from an earlier run."
        echo "Remove this container to prevent issues, by running 'docker rm -f $matching_containers'"
        exit -1
    fi
done


# Pull the latest images
docker compose -f build-resources/docker-compose.yml pull

# Attempt to bring up the services
docker compose -f build-resources/docker-compose.yml up -d --remove-orphans 2>&1
