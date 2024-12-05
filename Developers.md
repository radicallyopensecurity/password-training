# Developer instructions

## cloning the repo

Make sure to include submodules when cloning this repo, otherwise beef won't build.
```
git clone --recurse-submodules <repository-url>
``` 

## Build docker image
(from REPO_DIR)

On Linux and Mac:
```
./build.sh
```
For Windows hosts:
```
./build.bat
```

* Builds docker images
* Uses the current working directory as build context (.)
* Uses the dockerfile ./Dockerfile
* Tags the resulting image with "training-XXX:latest" (-t)
* pushes the build files to the GitHub repository's package registry
  
## Troubleshoot

### MacOS build error

When getting an `failed to resolve source metadata for docker.io/library/` error, Try the following fix (found [here](https://forums.docker.com/t/error-failed-to-solve-error-getting-credentials-err-exit-status-1-out/136124/6)). `sudo nano ~/.docker/config.json` and change `desktop` into `osxkeychain`. This may resolve the issue.


## Extra information
The following section contains additional information on working with the docker image. These steps are **NOT**  required for setting up the demo environment.

### Exporting and importing
The following commands should be ran on the host system, and _not_ in the docker container.

#### Exporting a docker container to a tar file
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
#### Importing a docker container
When you're ready to import your docker container again you can do so using the `docker import` command. Don't forget to decompress it first if you compressed it after exporting. You can use `gzip -d my_container.tar.gz` if you followed the above export instructions. When you have your .tar file ready you can import it and give it a name.

```
cat my_container.tar | docker import - my_container:latest
```
The image will now show up in your image listing when you use the `docker images` command. You can now use the image and launch command similar to when you are using the original image.
```
docker run -t -i my_container /bin/bash
```

#### Note on exported containers
Exporting and importing a docker container loses all of it's history in docker. If you want to retain you docker image layers use the `docker save` command instead.
