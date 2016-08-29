# Set up build environment
## Clone Docker image repo and sub repos
```
git clone ssh://git@gitlabs.radicallyopensecurity.com:7722/ros-demos/docker-image.git
cd docker-image
git clone ssh://git@gitlabs.radicallyopensecurity.com:7722/ros-demos/password-cracking.git
```

# Build docker image
```
docker build -t ros-demos/kali-linux-docker .
```

# Enter kali linux container shell
```
docker run -t -i ros-demos/kali-linux-docker /bin/bash
```

# Exporting
Something about
```
docker export
```
and
```
docker import
```

# Wordlists
The rockyou.txt and a dutch wordlist are included by default and can be found under /usr/share/wordlists/ in the docker container.