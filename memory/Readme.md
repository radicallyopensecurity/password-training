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