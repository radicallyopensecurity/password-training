#!/bin/bash
DOCKER_CLI_HINTS=false docker pull ghcr.io/radicallyopensecurity/training-password:latest
echo 
echo  
docker run -t -i ghcr.io/radicallyopensecurity/training-password:latest /bin/bash -l