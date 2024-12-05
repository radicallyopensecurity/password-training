#!/bin/bash
docker pull ghcr.io/bakeromso/training-password:latest 1>/dev/null
echo ""
docker run -t -i ghcr.io/bakeromso/training-password:latest /bin/bash -l