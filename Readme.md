# Build docker image
```
docker build -t ros-demos/kali-linux-docker .
```

# Enter kali linux container shell
```
docker run -t -i ros-demos/kali-linux-docker /bin/bash
```

# Extras
## Installing rockyou.txt wordlist
```
apt-get install wordlists
gzip -d /usr/share/wordlists/rockyou.txt.gz
```
The rockyou wordlist is now available for use by any cracking application under /usr/share/wordlists/rockyou.txt