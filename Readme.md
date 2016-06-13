# Password cracking demo/notes

## Password cracking estimator
This script makes an estimation of how long it will take to crack a given password.

### Online cracking
The online password cracking is based on an nginx http server doing http basic auth. The test was done on a 100 mbit line, maxing out the line speed. The gigabit and 10 gigabit speeds have been extrapolated from this figure, but take note that such an attack also requires significant resources on the server side. During this test the server used about the equivilent of 12 GHz of CPU power, distributed over serveral cores.
Tests were done over plain http, with the target host being on the internet. Both the usage of SSL/TLS cause overhead, resulting in less login attempts per second.
This test simulates looking for a password for a specific user. Other forms of brute force attacks may use a public or leaked list of usernames, searching for those that have weak passwords set.

### Offline cracking
The offline hash cracking figures are based off hashcat benchmarks available on https://gist.github.com/epixoip.
The 'Casual attacker' level is assumed to have an nvidia GTX 970 at their disposal, the 'Funded attacker' is based on a purpose built rig containing eight nvidia GTX 1080 cards.
The 'Large corporation' and 'Nation state' are extrapolated from this rig with a factor of 10 and 1000, respectively.
