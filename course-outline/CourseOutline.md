Authentication and password cracking
====================================
## Introduction

#### Authentication Types
* Something you know (Password)
* Something you have (Badge, token, digital certificate)
* Something you are (biometric, Fingerprint, retina)

#### Password Policies 
* Give participants two scenario for password policies  and asked them which option is better
* Provide brief about password policies

#### Statics about how long it will take password to crack depends on character size (Trade-off between password complexity vs usability
#### Phasphrase vs complex password

## Agenda
What do you need know about password?
* How and where are they stored?
* How are they used?
* How they can be attack?

## Brief (few slides) about various storage methods in Windows/Linux/application server
### How they are stored
* Plain text
* Encrypted

##### Hash
* LM Hash
* NT Hash
* MD5
* SHA1
* SHA2

#### Salt

### Where they stored
* In file
* In database
* In Memory

## Password Storage
* SAM Database
* LDAP/Active Directory
* /etc/shadow
* Database
* Configuration file of application server

## Brief (few slides) about various application and network based authentication schemes
### Application Authentication Protocols
* HTTP authentication
* HTTP form based authentication
* FTP authentication

## How they can be attack?
### Various methods of password cracking (online, offline) and process of cracking with Demo/hands-on
* Dictionary attack
* Brute force attack
* Rainbow table attack
* Offline cracking
* Password sniffing (MITM) attack sslstrip/sslsniff^X
* Forget password (https://techcrunch.com/2009/07/19/the-anatomy-of-the-twitter-attack/)
* Security Questions
* Phishing
* Social Engineering
* Malware
* Shoulder surfing
* Guess
* Spidering
* In memory
* In browser/application cache (Password Recovery/cracking, stored in application cache chrome, Firefox etc.)
* Access of authentication database/server
* Authentication through password hash
* Pass the hash attack

## Tools
* Cain and Abel
* John the Ripper
* THC Hydra
* Aircrack-ng (Wifi)
* L0phtcrack
* Ophcrack (Crack LM hashes through rainbow table)
* hashdump
* hashcat
* RainbowCrack
* Brutus

### Password Management tools
* Dashlane4
* LastPass Premimum
* Sticky Password
* KeePass

## Reference
