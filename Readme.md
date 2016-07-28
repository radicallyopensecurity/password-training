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

# Extras
## Installing rockyou.txt wordlist
```
apt-get install wordlists
gzip -d /usr/share/wordlists/rockyou.txt.gz
```
The rockyou wordlist is now available for use by any cracking application under /usr/share/wordlists/rockyou.txt