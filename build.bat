docker build password-cracking/build-resources -t ghcr.io/bakeromso/training-password:latest
docker build beef/build-resources -t ghcr.io/bakeromso/training-beef:latest

docker push ghcr.io/bakeromso/training-password:latest
docker push ghcr.io/bakeromso/training-beef:latest