# Password cracking demo/notes

## Password cracking estimator
This script provides an estimate of how long it will take to crack a given password. For online attacks it is assumed the network up-link will be the bottleneck. For offline cracking it assumes the available processing power is limiting factor.

### Online cracking
The online password cracking is based on an nginx http server doing http basic auth. The test was performed on a 100 mbit line, maxing out the line speed. The gigabit and 10 gigabit speeds have been extrapolated from this figure, but take note that such an attack also requires significant resources on the server side.

During this test the server used the equivalent of 12 GHz of CPU power, distributed over several cores. This is mostly because of the hashing that needs to be done server-side. The default htpasswd option was used, which means the server will need to do 1000 rounds of MD5 for each login attempt.
Significantly less server resources are needed when less secure password storage is used. A password stored plain-text in a database will require far less server resources per request, making it more likely an attacker is able to max out the line speed on a lower end server.

Tests were done over plain http, the usage of SSL/TLS will cause overhead, resulting in less login attempts per second.

This test simulates looking for a password for a specific user. Other forms of brute force attacks may use a public or leaked list of user names, searching for those that have weak passwords set.

### Offline cracking
The offline hash cracking figures are based off hashcat benchmarks available on https://gist.github.com/epixoip.
The 'Casual attacker' level is assumed to have an nvidia GTX 970 at their disposal, the 'Funded attacker' is based on a purpose built rig containing eight nvidia GTX 1080 cards.
The 'Large corporation' and 'Nation state' are extrapolated from this rig with a factor of 10 and 1000, respectively.

**note on LM hashes**
The LM hash type is a strange hash in many ways. The hashing algorithm splits the password up in two chucks of 7 characters and hashes those. This means that we only ever have to brute force passwords of 7 characters long, albeit that we sometimes have to brute force two of them. This also means that LM hashed passwords are always truncated at 14 characters.
In addition, the hashing algorithm makes the password entirely uppercase before hashing, which means we can usually reduce our character set for brute forcing by 26 characters.

**note on scrypt hashes**
Scrypt has a strong demand for memory in addition to processing power for its algorithm. This is why the performance benchmarks for scrypt do not scale with compute power as linearly as most algorithms. The memory available on the GPU running the benchmark also strongly influences the results.

---

## Offline hash cracking
This demo uses John the Ripper and oclHashCat to do brute force attacks on different types of password hashes. John the Ripper uses a regular CPU to carry out the brute force attack where oclHashCat utilizes any available GPUs as well. (John the Ripper can also be built with GPU support, but by default it is not.)

### Benchmark
Both John the Ripper and oclHashCat come with a built-in benchmark feature which allows you to test the number of hashes per second it will be able to do on the current system. By default these benchmarks test all available hash types.

Benchmarks for John the ripper:
```
john --test
```

Benchmarks for oclHashCat:
```
hashcat -b
```

### Cracking hashes with John the Ripper
John expects a file with password hashes which may be either a single hash on each line or a **username:hash** combination on each line. The exact format for the hash depends on the type of hash being cracked. In many cases john can figure out the type of hash automatically but you can also specify the type of hash with the **--format** parameter. Running john without any arguments shows the help, which lists all available hash types and character sets.


John will use 'incremental' mode by default. This is basically the 'brute force' mode where it tries all possible character combinations. You can specify this mode, and the character set you want by using the **--incremental** flag. The other common option is to specify a list of passwords to try with the **--wordlist** option. There is a third option which can be very useful when trying a long list of hashes which have additional account information associated with it, this is the **--single** option. It will try a small set of passwords based on the information associated with the account. For example the username being used as the password etc. This can be a very quick way of looking for weak passwords in a long list of accounts.

```
john --format=md5crypt --incremental=alpha hashes.txt
```

Example hashes.txt line using a format commonly found on Unix-like systems. Additional account information may be placed behind the hash using more : separators.
```
username:$1$uOM6WNc4$r3ZGeSB11q6UUSILqek3J1
^         ^ ^        ^
|         | |        |
|         | |        `- Start of hash
|         | `- Salt
|         `- Hash type (type 1 is FreeBSD MD5)
`- Accounts corresponding username (optional)
```

**Speeding up cracking**
There are a few very simple ways we can optimize the john to crack passwords faster in any mode we happen to be using.
 - More hashes in a file *If you have many hashes to crack, putting them all in the same file and allowing john to manage them will enable it to carry out the costly hashing function only once and try the hash against all hashes in the list. If different salts are used for every hash, this will not help though.*
 - The --fork option *By default john will only run on one CPU core. To take full advantage of multi core machines you can use --fork=8 to spawn 8 instances of john which will divide the work up between them. Since john is almost entirely CPU bound, setting --fork to the number of cores in the system is usually a good bet. John automatically drops the priority of its cracking workload so it will not freeze up your system when running on all cores, but leaving one core free is a good idea if you want to do anything else on the system while the cracking process is running.*

**John-jumbo**
The default john comes with a 'stripped down' feature set which includes the things most commonly used, however there is a john-jumbo package which contains extra options which can help with large cracking jobs. For example the ability to spread a cracking job across a large scale computer cluster using the OpenMPI framework and the ability to utilize GPU accelerators. John-jumbo also supports many additional hash types.

[Possible further content: session management, rules and mutators]


### Cracking hashes with oclHashcat
Hashcat and oclHashcat are two versions of the same program. The main difference is that oclHashcat was built with CUDA/OpenCL support and hashcat was not. For brevity we will refer to both of these as 'hashcat' in this section. 

Hashcat does not support the augmented hash file format. The hashes file must be a single hash on a line by itself. You must usually tell hashcat what type of hash you are cracking by using the **-m** option, otherwise **-m 0** is assumed. You must tell hashcat what type of attack you want to do by specifying the **-a** option. If committed hashcat assumes you want to do a dictionary attack. Calling hashcat with the --help option will list all available hash types and attack modes.

This time the hashes.txt file will only contain *$1$uOM6WNc4$r3ZGeSB11q6UUSILqek3J1*. The **-m 500** option specifies we want to use hash type 500, which is again md5crypt.
```
hashcat -m 500 hashes.txt wordlist.txt
```

When doing a brute force attack we must specify this attack type with the option **-a 3**, however this is not all we need to specify for the brute force attack. We also need to specify a password generator. The generator specification follows a specific format. For each character of the password to generate you need a ? followed by one or more charset specifiers. This can be *u* for uppercase characters, *l* for lowercase, *d* for digits etc. You can find the complete list of available charsets in the hashcat --help output. So for example if we want to crack passwords of 4 characters long, only lowercase the generator string would be *?l?l?l?l*. If we wanted to do the same but include uppercase too it will become *?ul?ul?ul?ul*. However note that this will only generate passwords EXACTLY 4 characters long. If we also want hashcat to generate the combinations of 1-3 characters long we must pass it the **--increment** option too.

Example of a brute force command where we look for passwords 1-8 characters long, starting with 4 lowercase letters, followed by 4 numbers.
```
hashcat -m 500 -a 3 hashes.txt ?l?l?l?l?d?d?d?d --increment
```

[Possible further content: session management and rules]


### When to use John and when to use Hashcat?
This usually depends on the infrastructure you have available to perform password cracking on and the type of attack you want to perform. Hashcat is highly optimized for fast hashing and will usually generate more hashes per second than john, but it lacks much of the customization options in brute force generators and mutators and doesn't have the level of session management that john does. For running a distributed cracking job, john is a little more mature at this time, of course this may change in the future. Both hashcat and john are capable of supporting GPU accelerators, but hashcat has had a lot of time and effort put into optimization of the algorithms, which is part of the reason why hashcat lays claim to the title of "Worlds fastest password cracker".
In short, if you have a single machine to run your cracking task and you are using a wordlist or a simple brute force generator, hashcat is likely the faster option, especially if you have a CUDA or OpenCL capable GPU. For more complex rules or larger distributed systems, john is probably the better option.
---



## Rainbow table cracking
### What are rainbow tables
TODO: General info about how rainbow tables work and time/memory trade-offs

### Limits of rainbow tables
TODO: Info about salted hashes, large charsets and long passwords.

### Rainbowcrack
TODO: Info about the rainbowcrack tool, file formats and syntax.
```
rainbowcrack --table /foo/bar.rt --syntax
```
---

## Online cracking
TODO