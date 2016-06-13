# Password cracking demo/notes

## Password cracking estimator
This script makes an estimation of how long it will take to crack a given password.

### Offline cracking
The offline hash cracking figures are based off hashcat benchmarks available on https://gist.github.com/epixoip.
The 'Casual attacker' level is assumed to have an nvidia GTX 970 at their disposal, the 'Funded attacker' is based on a purpose built rig containing eight nvidia GTX 1080 cards.
The 'Large corporation' and 'Nation state' are extrapolated from this rig with a factor of 10 and 1000, respectively.
