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
You may specify one or more rainbow table files to use in the cracking process, followed by the -h option to specify a hash directly or the -l option to specify a list of hashes contained in a file. The -f and -n options are available for pwdump files but we will not be using those here.
```
rcrack /usr/share/rainbowtables/lm_alpha-numeric#1-7_1_3800x33554432_0.rt -l /root/password-cracking/rainbow/hashes_lm.txt
```
### Note on cracking LM hashes
Rcrack expects you to manually separate the two hashes that make up a full ML hash. In the "hashes_lm.txt" file included with this demo that has already been done for you so you can pass it directly to rcrack as is.

## Note on the included rainbow table
We utilizes a demo rainbow table included with the demo docker image. Please note that this is a very minimal rainbow table in order to reduce its size on disk. It has been tested to find the hash included with this demo but it may fail to find other hashes more often than a full rainbow table would.