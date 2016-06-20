# Password cracking demo/notes

## Password cracking estimator
This script provides an estimate of how long it will take to crack a given password. For online attacks it is assumed the network uplink will be the bottleneck. For offline cracking it assumes the available processing power is limiting factor.

### Online cracking
The online password cracking is based on an nginx http server doing http basic auth. The test was performed on a 100 mbit line, maxing out the line speed. The gigabit and 10 gigabit speeds have been extrapolated from this figure, but take note that such an attack also requires significant resources on the server side.

During this test the server used the equivilent of 12 GHz of CPU power, distributed over serveral cores. This is mostly because of the hashing that needs to be done server-side. The default htpasswd option was used, which means the server will need to do 1000 rounds of MD5 for each login attempt.
Significantly less server resources are needed when less secure password storage is used. A password stored plain-text in a database will require far less server resources per request, making it more likely an attacker is able to max out the line speed on a lower end server.

Tests were done over plain http, the usage of SSL/TLS will cause overhead, resulting in less login attempts per second.

This test simulates looking for a password for a specific user. Other forms of brute force attacks may use a public or leaked list of usernames, searching for those that have weak passwords set.

### Offline cracking
The offline hash cracking figures are based off hashcat benchmarks available on https://gist.github.com/epixoip.
The 'Casual attacker' level is assumed to have an nvidia GTX 970 at their disposal, the 'Funded attacker' is based on a purpose built rig containing eight nvidia GTX 1080 cards.
The 'Large corporation' and 'Nation state' are extrapolated from this rig with a factor of 10 and 1000, respectively.

**note on LM hashes**
The LM hash type is a strange hash in many ways. The hashing algorith splits the password up in two chucks of 7 characters and hashes those. This means that we only ever have to brute force passwords of 7 characters long, albeit that we sometimes have to brute force two of them. This also means that LM hashed passwords are always truncated at 14 charaters.
In addition, the hashing algorithm makes the password entirely uppercase before hashing, which means we can usually recuce our character set for brute forcing by 26 characters.

**note on scrypt hashes**
Scrypt has a strong demand for memory in addition to processing power for its algorithm. This is why the performnce benchmarks for scrypt do not scale with compute power as linearly as most algorithms. The memory available on the GPU running the benchmark also strongly influences the results.