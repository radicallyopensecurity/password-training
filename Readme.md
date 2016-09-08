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

# File locations
## Password cracking demos
Inside the docker container, the demos are located in the `/root/password-cracking/` directory.

## Wordlists
The rockyou.txt and a dutch wordlist are included by default and can be found in `/usr/share/wordlists/` inside the docker container. They can be used by various brute forcing applications to do dictionary and wordlist attacks.

# Extra information
The following section contains additional information on working with the docker image. These steps are **NOT**  required for setting up the demo environment.

## Exporting and importing
### Exporting a docker container to a tar file
The `docker ps -a` command will list all the docker containers that have been created. From this list you can select a container to export.
```
$ docker ps -a
CONTAINER ID   IMAGE                        COMMAND       CREATED          STATUS                        PORTS    NAMES
01197897717c   ros-demos/kali-linux-docker  "/bin/bash"   16 minutes ago   Exited (127) 4 minutes ago             naughty_volhard
4ba86d84d5b8   ros-demos/kali-linux-docker  "/bin/bash"   4 days ago       Exited (130) 4 days ago                amazing_williams
```
In this listing you will see an auto-generated name for every docker container. For this example we will export the lastest docker container named "naughty_volhard". We can export containers using the `docker export` command.
```
docker export --output="my_container.tar" naughty_volhard
```
Once the command completes, you can gzip the file to save some space if you so desire. For the sake of this example we'll use gzip to compress the exported container.
```
gzip my_container.tar
```
### Importing a docker container
When you're ready to import your docker container again you can do so using the `docker import` command. Don't forget to decompress it first if you compressed it after exporting. You can use `gzip -d my_container.tar.gz` if you followed the above export instructions. When you have your .tar file ready you can import it and give it a name.

```
cat my_container.tar | docker import - my_container:latest
```
The image will now show up in your image listing when you use the `docker images` command. You can now use the image and launch command similar to when you are using the original image.
```
docker run -t -i my_container /bin/bash
```

### Note on exported containers
Exporting and importing a docker container loses all of it's history in docker. If you want to retain you docker image layers use the `docker save` command instead.
