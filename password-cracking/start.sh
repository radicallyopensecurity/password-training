#!/bin/bash
# echo "pulling the password cracking container. This
DOCKER_CLI_HINTS=false docker pull ghcr.io/radicallyopensecurity/training-password:latest  #1>/dev/null
echo ""
echo "" 
docker run -t -i ghcr.io/radicallyopensecurity/training-password:latest /bin/bash -l