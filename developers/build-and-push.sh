#!/bin/bash
if docker buildx ls | grep -q "desktop-linux"; then
    echo "Builder 'desktop-linux' exists. Using this builder."
    docker buildx use desktop-linux
else
    echo "Builder 'desktop-linux' does not exist. You are probably not using Docker Desktop. Install Docker Desktop to use this build script, or create a buildx builder with multi-arch cross compilation support. Name this builder `desktop-linux` to use this build script. Exiting.."
    exit -1
fi


docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t ghcr.io/radicallyopensecurity/training-password:latest \
  --label "org.opencontainers.image.source=https://github.com/radicallyopensecurity/password-training" \
  --push \
  password-cracking/build-resources

docker buildx build \
 --platform linux/amd64,linux/arm64 \
 -t ghcr.io/radicallyopensecurity/training-beef:latest \
 --label "org.opencontainers.image.source=https://github.com/radicallyopensecurity/password-training" \
 --push \
 beef/build-resources/beef-upstream



# docker build password-cracking/build-resources -t ghcr.io/radicallyopensecurity/training-password:latest && \
# docker build beef/build-resources/beef-upstream -t ghcr.io/radicallyopensecurity/training-beef:latest && \
# docker push ghcr.io/radicallyopensecurity/training-password:latest && \
# docker push ghcr.io/radicallyopensecurity/training-beef:latest