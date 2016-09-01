Authentication and password cracking
====================================
## Agenda
What do you need know about password
* How and Where are they stored?
* How are they used?
* How they can be attack?
## Brief (few slides) about various storage methods in Windows/Linux/application server
### How they are stored
* Plain text
* Encrypted
##### Hash
* LM Hash
* NT Hash
### Where they stored
* In file
* In database
* In Memory
## Password Storage
* SAM Database
* LDAP/Active Directory
* /etc/shadow
* Database
## Brief (few slides) about various application and network based authentication schemes
### Application Authentication Protocols
* HTTP authentication
* HTTP form based authentication
* FTP authentication
* SMTP authentication
* IMAP/POP3 authentication
### Network Authentication Protocols
* PAP
* CHAP
* MS-CHAP and MS-CHAPv2
* EAP
* NTLM
* Kerberos
* RADIUS
* TACAS and TACAS+
* Wifi (WEP, WPA, WPA2)
* SNMP
## How they can be attack?
### Various methods of password cracking (online, offline) and process of cracking with Demo/hands-on
* Dictionary attack
* Brute force attack
* Rainbow table attack
* Offline cracking
* password sniffing (MITM) attack sslstrip/sslsniff^X
* Forget password (https://techcrunch.com/2009/07/19/the-anatomy-of-the-twitter-attack/)
* Security Questions
* Phishing
* Social Engineering
* Malware
* Soulder surfing
* Guess
* Spidering
* In memory
* In browser/application cache (Password Recover/cracking stored in applciation cache chrome,firefox etc.) Required physical access
* Access of authentication database/server
* Authentication through password hash
* Pass the hash attack
## Tools
* Cain and Abel
* Jhon the Ripper
* THC Hydra
* Aircrack-ng (Wifi)
* L0phtcrack
* Ophcrack (Crack LM hashes through rainbow table)
* hashdump
* hashcat
* RainbowCrack
* SolarWinds
* Brutus
## Recommandation/Conclusion
* Tradeoff between password complexity vs usability
* Phasphrase vs longpassword
### Password Management tools
* Dashlane4
* LastPass Premimum
* Sticky Password
* KeePass
## Reference
