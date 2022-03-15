# Password cracking estimator
This script provides an estimate of how long it will take to crack a given password. For online attacks it is assumed the network up-link will be the bottleneck. For offline cracking it assumes the available processing power is limiting factor. Running the script can be done by issuing the following commands inside the docker container;
```
cd /root/password-cracking/estimator/ ; ./run/sh
```

## Online cracking
The online password cracking speed is based on a benchmark performed by running Hydra against an Apache http server performing HTTP basic auth. The test was performed on Amazon EC2 with a c3.xlarge instance type as the attacker and a c3.4xlarge instance as the web server. The Apache web server was configured with 500 worker threads to ensure bandwidth would be the constraining factor. We increased the number of workers on Hydra until we reached a network throughput of 100 mbit, measured at the server side. At this time Hydra was able to perform close to half a million authentication attempts per minute. The gigabit and 10 gigabit speeds have been extrapolated from this figure. Take note that this is an almost ideal situation with both machines having sufficient bandwidth and system resources to handle this volume of authentication attempts and that the attacker and target have a very low latency connection as they were hosted in the same Amazon EC2 availability zone. In less ideal conditions an attack may be significantly slower.

During this test the server used the equivalent of 12 GHz of CPU power, distributed over several cores. This is mostly because of the hashing that needs to be done server-side. The default htpasswd option was used, which means the server will need to do 1000 rounds of MD5 for each login attempt.
Significantly less server resources are needed when less secure password storage is used. A password stored plain-text in a database will require far less server resources per request, making it more likely an attacker is able to max out the line speed on a lower end server.

Tests were done over plain http, the usage of SSL/TLS will cause overhead, resulting in less login attempts per second.

This test simulates looking for a password for a specific user. Other forms of brute force attacks may use a public or leaked list of user names, searching for those that have weak passwords set.

## Offline cracking
The offline hash cracking figures are based off hashcat benchmarks we ran ourselves and those available on https://gist.github.com/epixoip. For details on our own benchmarks and how to reproduce them, see the Hashcat-benshmarks.md file.
The First two threat actor levels are based of an attacker running cracking software on Amazon EC2 instances.
The 'Casual attacker' level is assumed to have an nvidia GTX 970 at their disposal, the 'Funded attacker' is based on a purpose built rig containing eight nvidia GTX 1080 cards.
The 'Large corporation' and 'Nation state' are extrapolated from this rig with a factor of 10 and 1000, respectively.

**note on LM hashes**
The LM hash type is a strange hash in many ways. The hashing algorithm splits the password up in two chucks of 7 characters and hashes those. This means that we only ever have to brute force passwords of 7 characters long, albeit that we sometimes have to brute force two of them. This also means that LM hashed passwords are always truncated at 14 characters.
In addition, the hashing algorithm makes the password entirely uppercase before hashing, which means we can usually reduce our character set for brute forcing by 26 characters.

**note on scrypt hashes**
Scrypt has a strong demand for memory in addition to processing power for its algorithm. This is why the performance benchmarks for scrypt do not scale with compute power as linearly as most algorithms. The memory available on the GPU running the benchmark also strongly influences the results.
