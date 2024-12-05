# Password cracking demo/notes
This repository contains several demonstrations that could be used in security awareness trainings on the topic of password security.

## Demos

The password-cracking demo contains the following demonstrations:

1. **Estimator** <br>
This script makes a rough estimate of how long it would take to crack a given password on different hardware, based on the length and complexity of the password.

1. **Generator** <br>
This script will generate a hash for a password you specify along with the command required to crack it.

<!-- 1. **Offline** <br>
Demos and examples dealing with offline hash cracking using John the Ripper and Hashcat.

1. **Online** <br>
Demos and examples dealing with online brute forcing using Hydra.

1. **Rainbow** <br>
Demos and examples dealing with offline hash cracking using rainbow tables. -->

## Run the demos
### Start and enter the demo container

We will run the demos from the docker container. To start the docker container, use the convenience `start` script. For Linux and MacOS `./start.sh`, on Windows `./start.bat`.

This should start the demo container present you with the following prompt:
```
Welcome to the password cracking container. Run ./estimator for the estimator demo, and ./generator for the generator demo.
┌──(root㉿[RANDOM_HOSTNAME])-[~]
└─# 
```

### Password cracking demos
Inside the docker container, we find the demos. 

#### Starting the estimator demo
```
./estimator
```

#### Starting the generator demo
```
./generator
```

