#!/bin/bash
docker build password-cracking/build-resources -t ghcr.io/radicallyopensecurity/training-password:latest && \
docker build beef/build-resources/beef-upstream -t ghcr.io/radicallyopensecurity/training-beef:latest && \
docker push ghcr.io/radicallyopensecurity/training-password:latest && \
docker push ghcr.io/radicallyopensecurity/training-beef:latest