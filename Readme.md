# Password training
This repositoy contains several demonstrations that could be used in security awareness trainings on the topic of password security.

## Technical requirments
These demonstations use docker to setup a container, based off the kali linux distribution. Therefore it is necessary to set up docker before attempting to preform the demonstrations. Details for Ubuntu 20.04 and Windows 10 will be provided below.

---
**NOTE**

Perform the setup steps _before_ you start the training. Installation will take ~15 minutes and requires a stable internet connection.

---

# Setup docker instruction for Ubuntu 20.04 (Hirsute)
## Update apt cache and install base packages
```
 sudo apt-get update
```
```
 sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

## Add Docker’s official GPG key:
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

## Add docker's stable repository
```
 echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  ```

## Install docker engine
```
 sudo apt-get update
 sudo apt-get install docker-ce docker-ce-cli containerd.io
```

## Add user to docker group
```
sudo usermod -aG docker $(whoami)
```

## Logout of your session and log back in, or restart your system:
```
sudo shutdown -r now
```

## Confirm operation of docker daemon
```
sudo systemctl status docker
```
This output should be as follows:
```
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2022-03-14 19:06:57 EDT; 19h ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 835 (dockerd)
      Tasks: 11
     Memory: 2.1G
     CGroup: /system.slice/docker.service
             └─835 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
```
* Note the Active: active (running) line



# Build the docker image
Perform this step before the training. This step requires an internet connection.

## Change the working directory to the directory containing this file
```
cd <prefix>/password-training
```

## Build docker image
```
./build.sh
```
* Builds a docker image
* Uses the current working directory as build context (.)
* Uses the dockerfile ./Dockerfile
* Tags the resulting image with "training" (-t)
  


## Verify correct creation of image
```
docker image ls
```
Should yield:
```
REPOSITORY                    TAG       IMAGE ID       CREATED             SIZE
training                      latest    adac19102632   2 minutes ago       2.15GB
```

# Enter kali linux container shell
```
$ ./run.sh
```
This should present you with the following prompt:
```
┌──(root㉿2bc68ff2fe4b)-[/]
└─# 

```

# Setup instruction for Windows 10 (64-bit)
## Download and isntall binary
```
https://docs.docker.com/desktop/windows/install/
```

Locate the blue button that says "Docker Desktop for Windows" and click it
This will download the binary

## Install
Locate the downloads on your filesystem and open it. It will want to make changes to your system, click yes.

Note: Windows will need to be restarted as part of the installation process.

At one point, it will ask you to install WSL. Follow this instruction presented.
Upon completion, restart docker.

## Build docker image
# Build the docker image
Perform this step before the training. This step requires an internet connection.

## Change the working directory to the directory containing this file
Open a comand windows (cmd.exe)
```
cd <prefix>/password-training
```

## Build docker image
```
./build.bat
```
* Builds a docker image
* Uses the current working directory as build context (.)
* Uses the dockerfile ./Dockerfile
* Tags the resulting image with "training" (-t)
  
## Verify correct creation of image
```
docker image ls
```
Should yield:
```
REPOSITORY                    TAG       IMAGE ID       CREATED             SIZE
training                      latest    adac19102632   2 minutes ago       2.15GB
```

# Enter kali linux container shell
```
$ ./run.bat
```
This should present you with the following prompt:
```
┌──(root㉿2bc68ff2fe4b)-[/]
└─# 

```


# File locations
## Password cracking demos
Inside the docker container, the demos are located in the `/root/password-cracking/` directory.

Execute the following commands in the docker shell to start the respective demos.

### Starting the estimator demo
```
/estimator
```

### Starting the generator demo
```
/generator
```



## Wordlists
The rockyou.txt and a dutch wordlist are included by default and can be found in `/usr/share/wordlists/` inside the docker container. They can be used by various brute forcing applications to do dictionary and wordlist attacks.

# Extra information
The following section contains additional information on working with the docker image. These steps are **NOT**  required for setting up the demo environment.

## Exporting and importing
The following commands should be ran on the host system, and _not_ in the docker container.

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
