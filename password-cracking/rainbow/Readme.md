# Rainbow table cracking
## What are rainbow tables
Rainbow tables are precomputed lists of passwords and their corresponding hashes stored in a special format which makes it possible to search this list very efficiently as well as reducing the overall file size of the list. There is a trade off between memory and storage requirements and the time required to crack the hash for all hash brute forcing, practically this means you can speed up your hash cracking by increasing the amount of memory and storage you need to do so. Historically the memory and storage requirements were too great for this to be viable but technological improvements over the years have made it a favorable trade off in many cases. Essentially the trade off is to only have to do the heavy computation of the hashes once, and then storing the results for later use rather than having to regenerate the hash every time you are cracking a hash. So you are trading the time required to compute the hashes for the memory required to store these hash tables.

The rainbow table format itself can go further into this time/memory trade off by optimizing the rainbow table for either smaller file sizes of faster lookups. This is why you will sometimes see rainbow tables labeled as "small" or "fast". This indication is given so the user knows what the table is optimized for.

## Limits of rainbow tables
Rainbow tables do have some limits which are useful to be aware of. These limits are a result of the memory and storage requirements of these tables. Since all hashes for a given character set and password length are contained in the table, these tables grow very quickly when generating them for long passwords and/or large character sets. This is why you will usually not find rainbow tables for passwords longer than 7 or 8 characters unless they have a very small character set. The tables for XP hashes are an exception to this because of the way LM hashes work. Since all passwords stored in LM hashes are uppercase only and at most 14 characters as well as being split in the middle, the table really only needs a maximum password length of 7 characters and can omit lowercase letters from the character set.

## Rainbowcrack
Rainbowcrack is a small suite of tools to work with rainbow tables. For this demo we will focus on "rcrack" which uses rainbow tables to crack password hashes. The other tools available in the rainbowcrack suite can be used to utilize GPUs to perform even faster cracking and to generate new rainbow tables yourself.

For this demo a small rainbow table has been generated for windows LM hashes. It only contains alphanumeric passwords.

### Rainbowcrack command syntax
You may specify one or more rainbow table files to use in the cracking process, followed by the -h option to specify a hash directly or the -m option to specify a hash. Older versions of rcrack had support for the -l flag, with which you could specify hashes in a contained in a file. However, in v1.8 this functionality seems to be broken. The -f and -n options are available for pwdump files but we will not be using those here.

```
./run.sh
```

This script iterates over the hashes in `hashes_lm.txt` and cracks the separately using rcrack.

The output should look like this:"

```
1 rainbow tables found
memory available: 22589820108 bytes
memory for rainbow chain traverse: 60800 bytes per hash, 60800 bytes for 1 hashes
memory for rainbow table buffer: 2 x 536870928 bytes
disk: /usr/share/rainbowcrack//lm_alpha-numeric#1-7_1_3800x33554432_0.rt: 536870912 bytes read
disk: finished reading all files
plaintext of 36caf2ac869e59e2 is HASH234

statistics
----------------------------------------------------------------
plaintext found:                             1 of 1
total time:                                  0.52 s
time of chain traverse:                      0.36 s
time of alarm check:                         0.15 s
time of disk read:                           0.25 s
hash & reduce calculation of chain traverse: 7216200
hash & reduce calculation of alarm check:    3893631
number of alarm:                             3074
performance of chain traverse:               19.88 million/s
performance of alarm check:                  26.49 million/s

result
----------------------------------------------------------------
36caf2ac869e59e2  HASH234  hex:48415348323334
1 rainbow tables found
memory available: 22590819532 bytes
memory for rainbow chain traverse: 60800 bytes per hash, 60800 bytes for 1 hashes
memory for rainbow table buffer: 2 x 536870928 bytes
disk: /usr/share/rainbowcrack//lm_alpha-numeric#1-7_1_3800x33554432_0.rt: 536870912 bytes read
disk: finished reading all files

statistics
----------------------------------------------------------------
plaintext found:                             0 of 1
total time:                                  0.52 s
time of chain traverse:                      0.36 s
time of alarm check:                         0.16 s
time of disk read:                           0.21 s
hash & reduce calculation of chain traverse: 7216200
hash & reduce calculation of alarm check:    4074101
number of alarm:                             3118
performance of chain traverse:               20.16 million/s
performance of alarm check:                  25.95 million/s

result
----------------------------------------------------------------
aad3b435b51404ee  <not found>  hex:<not found>
```

The above output shows that the retrieved password is 
```
HASH234
```
And cracked in under a second.

### Note on cracking LM hashes
Rcrack expects you to manually separate the two hashes that make up a full ML hash. In the "hashes_lm.txt" file included with this demo that has already been done for you so you can pass it directly to rcrack as is.
If you are using the **generator.rb** script to generate your LM hash to crack with a rcrack, use **hashcat** as your choice of tool since the output file for hashcat also splits the hash in two. This means that LM hashes generated for hashcat can also be fed directly to rcrack without having to manually split the hash in two.

## Note on the included rainbow table
We utilize a demo rainbow table included with the demo docker image. Please note that this is a very minimal rainbow table in order to reduce its size on disk. It has been tested to find the hash included with this demo but it may fail to find other hashes more often than a full rainbow table would.

Regenerate with `cd /RainbowCrack-NG/src/ && rtgen lm alpha-numeric 1 7 1 3800 33554432 0` 