# Memory dump
This demo is a simple password manager which can be seen as a professional manager like Keepass etc.
The password is stored in plaintext as an example. Real password managers would use hashes.
However, those hashes are not secure, unless the user chooses a secure password!

## Usage
Import the docker instance.
```
cat memory-dump.tar | docker import - memory-dump:latest
```

Switch inside the docker instance and Navigate to the /home/ folder.
```
docker run -it --privileged memory-dump /bin/bash
cd /home/
./demo
```

Let the first window open. Create a second session to dump the active process.
```
docker exec -it --privileged "memory-dump" bash
```

Use ps to get the currend PID of the process and use gcore to dump it
```
pgrep -f demo | xargs gcore
```

Finally, use Strings and Grep to find the password in the dump.
```
strings demo | grep secret
```

You can now login to the password manager in the first window.






#Dump ftp credentials.
## Usage
Import the docker instance.
```
cat memory-dump.tar | docker import - memory-dump:latest
```

Switch inside the docker instance, enter the command but do not submit yet!
```
docker run -it --privileged memory-dump /bin/bash
pgrep -f ftp | xargs gcore
```

Open another docker session and open ftp.
```
docker exec -it --privileged "memory-dump" bash
ftp lima-ftp.de
```
Now enter username test and enter any password.
Right after you entered the password, switch to the other terminal and hit enter.
Finally, use Strings and Grep to find the password in the dump.
```
strings ftpdumpfile | grep PASS
```



#Dump truecrypt contents.
## Usage
Import the docker instance.
```
cat memory-dump.tar | docker import - memory-dump:latest
```

Switch inside the docker instance, enter the command but do not submit yet!
```
docker run -it --privileged memory-dump /bin/bash
pgrep -f ftp | xargs gcore
```

Open another docker session and open truecrypt.Use the password secretpassword and no Keyfile.
```
docker exec -it --privileged "memory-dump" bash
truecrypt -t -m=nokernelcrypto EncryptedVolume.jpg /media/truecrypt
```
Now switch to the other terminal and hit enter.
Finally, use Strings and Grep to find secret messages in the dump.
```
strings truecryptdumpfile | grep secret
```

#dependencies truecrypt
apt-get install software-properties-common
apt-get install libgtk2.0-0
