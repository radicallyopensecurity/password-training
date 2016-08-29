# Running your own Hashcat benchmarks

Rather than relying solely on published benchmarks for Hashcat, we can run our own benchmarks to repeatably prove and verify the estimated cracking speed is realistic. We will describe two benchmarks using Amazon's EC2 computing platform.

## GPU benchmarks
Amazon EC2 offers access to EC2 instances with Nvidia based GPU accelerators. At the time of writing the accelerators being used are Nvidia GRID K520 cards. We will be benchmarking on a g2.2xlarge instance type, which has one of the K520's two GPU cores assigned to it. This gives us a GPU with 1536 CUDA cores and 4GB of memory.

### Setting up the benchmark environment
In the Amazon EC2 console create a new instance. Select "Amazon Linux AMI with NVIDIA GRID GPU Driver" from the AWS marketplace and use a g2.2xlarge instance type. Once the instance is launched, log in over ssh with the "ec2-user" account. The SSH key you used should be provisioned for this account.

Set up prerequisites;
```
wget https://dl.fedoraproject.org/pub/epel/7/x86_64/p/p7zip-16.02-1.el7.x86_64.rpm
sudo rpm -i p7zip-16.02-1.el7.x86_64.rpm
```

Download and run hashcat benchmark;
```
wget https://hashcat.net/files/hashcat-3.10.7z
7za x hashcat-3.10.7z
cd hashcat-3.10
./hashcat64.bin -b
```

### GPU Results
This table shows the results for the hashtypes we use in the estimator. The full list of benchmark results can be found at the bottom of this page.

| Hash   | Speed       |
|--------|------------:|
| MD5    | 2317.5 MH/s |
| SHA1   |  617.6 MH/s |
| SHA256 |  292.2 MH/s |
| scrypt |   51541 H/s |
| LM     |  304.4 MH/s |
| NTLM   | 3496.3 MH/s |
| bcrypt |     536 H/s |

## CPU benchmarks
For the CPU benchmarks we are using a c4.2xlarge instance type, which offers 8 dedicated CPU cores on Intel Xeon E5-2666 v3 processors. This is a reasonable approximation for the compute power you will find in a high end workstation with no dedicated graphics cards to take advantage of.

### Setting up the benchmark environment
In the Amazon EC2 console create a new instance. Select "CentOS 7 (x86_64) - with Updates HVM" from the AWS marketplace and use a c4.2xlarge instance type. Once the instance is launched, log in over ssh with the "centos" account. The SSH key you used should be provisioned for this account.

Set up prerequisites;
```
sudo yum install epel-release
sudo yum install p7zip wget redhat-lsb-core
```
Set up Intel Xeon OpenCL runtime;
```
wget http://registrationcenter-download.intel.com/akdlm/irc_nas/9019/opencl_runtime_16.1.1_x64_rh_6.4.0.25.tgz
tar zxf opencl_runtime_16.1.1_x64_rh_6.4.0.25.tgz
cd opencl_runtime_16.1.1_x64_rh_6.4.0.25
sudo ./install.sh
cd ..
```
Download and run hashcat benchmark;
```
wget https://hashcat.net/files/hashcat-3.10.7z
7za x hashcat-3.10.7z
cd hashcat-3.10
./hashcat64.bin -b
```


### CPU Results
This table shows the results for the hashtypes we use in the estimator. The full list of benchmark results can be found at the bottom of this page.

| Hash   | Speed        |
|--------|-------------:|
| MD5    |   449.9 MH/s |
| SHA1   |   248.2 MH/s |
| SHA256 | 93109.5 kH/s |
| scrypt |    24344 H/s |
| LM     | 94441.3 kH/s |
| NTLM   |   764.5 MH/s |
| bcrypt |     2593 H/s |


# Note on version numbers
Since version numbers are subject to change over time, the following list can be used to seek out updated versions.

| Product                   | URL                                                                |
|---------------------------|--------------------------------------------------------------------|
| Hashcat                   | https://hashcat.net/hashcat/                                       |
| Intel Xeon OpenCL runtime | https://software.intel.com/en-us/articles/opencl-drivers#core_xeon |
| 7zip utilities RPM        | https://dl.fedoraproject.org/pub/epel/7/x86_64/p/                  |

# Full benchmark results
For reference, the full output of the benchmarks is provided here.

## GPU
```
hashcat (v3.10) starting in benchmark-mode...

OpenCL Platform #1: NVIDIA Corporation
======================================
- Device #1: GRID K520, 1023/4095 MB allocatable, 8MCU

Hashtype: MD4

Speed.Dev.#1.:  3513.1 MH/s (95.79ms)

Hashtype: MD5

Speed.Dev.#1.:  2317.5 MH/s (95.45ms)

Hashtype: Half MD5

Speed.Dev.#1.:  1610.5 MH/s (95.81ms)

Hashtype: SHA1

Speed.Dev.#1.:   617.6 MH/s (95.25ms)

Hashtype: SHA256

Speed.Dev.#1.:   292.2 MH/s (95.73ms)

Hashtype: SHA384

Speed.Dev.#1.: 74268.4 kH/s (95.11ms)

Hashtype: SHA512

Speed.Dev.#1.: 76020.2 kH/s (95.02ms)

Hashtype: SHA-3(Keccak)

Speed.Dev.#1.: 69574.7 kH/s (96.12ms)

Hashtype: SipHash

Speed.Dev.#1.:  3311.8 MH/s (95.59ms)

Hashtype: RipeMD160

Speed.Dev.#1.:   482.0 MH/s (95.31ms)

Hashtype: Whirlpool

Speed.Dev.#1.: 37368.8 kH/s (177.99ms)

Hashtype: GOST R 34.11-94

Speed.Dev.#1.: 41108.2 kH/s (155.82ms)

Hashtype: GOST R 34.11-2012 (Streebog) 256-bit

Speed.Dev.#1.:  8881.3 kH/s (219.05ms)

Hashtype: GOST R 34.11-2012 (Streebog) 512-bit

Speed.Dev.#1.:  8889.4 kH/s (218.85ms)

Hashtype: phpass, MD5(Wordpress), MD5(phpBB3), MD5(Joomla)

Speed.Dev.#1.:   765.3 kH/s (95.89ms)

Hashtype: scrypt

Speed.Dev.#1.:    51541 H/s (78.73ms)

Hashtype: PBKDF2-HMAC-MD5

Speed.Dev.#1.:   802.9 kH/s (78.03ms)

Hashtype: PBKDF2-HMAC-SHA1

Speed.Dev.#1.:   332.2 kH/s (87.37ms)

Hashtype: PBKDF2-HMAC-SHA256

Speed.Dev.#1.:   124.4 kH/s (89.42ms)

Hashtype: PBKDF2-HMAC-SHA512

Speed.Dev.#1.:    31316 H/s (93.13ms)

Hashtype: Skype

Speed.Dev.#1.:  1377.7 MH/s (95.86ms)

Hashtype: WPA/WPA2

Speed.Dev.#1.:    41092 H/s (94.72ms)

Hashtype: IKE-PSK MD5

Speed.Dev.#1.:   181.6 MH/s (98.11ms)

Hashtype: IKE-PSK SHA1

Speed.Dev.#1.: 80852.2 kH/s (96.02ms)

Hashtype: NetNTLMv1-VANILLA / NetNTLMv1+ESS

Speed.Dev.#1.:  1946.8 MH/s (96.91ms)

Hashtype: NetNTLMv2

Speed.Dev.#1.:   161.3 MH/s (94.53ms)

Hashtype: IPMI2 RAKP HMAC-SHA1

Speed.Dev.#1.:   162.2 MH/s (95.84ms)

Hashtype: Kerberos 5 AS-REQ Pre-Auth etype 23

Speed.Dev.#1.:  7782.6 kH/s (163.84ms)

Hashtype: Kerberos 5 TGS-REP etype 23

Speed.Dev.#1.:  7773.8 kH/s (163.96ms)

Hashtype: DNSSEC (NSEC3)

Speed.Dev.#1.:   332.9 MH/s (95.89ms)

Hashtype: PostgreSQL Challenge-Response Authentication (MD5)

Speed.Dev.#1.:   589.8 MH/s (99.73ms)

Hashtype: MySQL Challenge-Response Authentication (SHA1)

Speed.Dev.#1.:   230.4 MH/s (95.38ms)

Hashtype: SIP digest authentication (MD5)

Speed.Dev.#1.:   392.4 MH/s (97.91ms)

Hashtype: SMF > v1.1

Speed.Dev.#1.:   684.3 MH/s (96.12ms)

Hashtype: vBulletin < v3.8.5

Speed.Dev.#1.:   647.5 MH/s (98.91ms)

Hashtype: vBulletin > v3.8.5

Speed.Dev.#1.:   443.2 MH/s (97.36ms)

Hashtype: IPB2+, MyBB1.2+

Speed.Dev.#1.:   462.7 MH/s (98.55ms)

Hashtype: WBB3, Woltlab Burning Board 3

Speed.Dev.#1.:   126.7 MH/s (96.17ms)

Hashtype: OpenCart

Speed.Dev.#1.:   207.5 MH/s (98.10ms)

Hashtype: Joomla < 2.5.18

Speed.Dev.#1.:  2321.1 MH/s (95.29ms)

Hashtype: PHPS

Speed.Dev.#1.:   647.9 MH/s (98.85ms)

Hashtype: Drupal7

Speed.Dev.#1.:     4313 H/s (95.66ms)

Hashtype: osCommerce, xt:Commerce

Speed.Dev.#1.:  1380.1 MH/s (95.69ms)

Hashtype: PrestaShop

Speed.Dev.#1.:   796.8 MH/s (96.93ms)

Hashtype: Django (SHA-1)

Speed.Dev.#1.:   682.8 MH/s (96.04ms)

Hashtype: Django (PBKDF2-SHA256)

Speed.Dev.#1.:     6254 H/s (94.41ms)

Hashtype: Mediawiki B type

Speed.Dev.#1.:   608.6 MH/s (99.00ms)

Hashtype: Redmine Project Management Web App

Speed.Dev.#1.:   215.1 MH/s (96.80ms)

Hashtype: PostgreSQL

Speed.Dev.#1.:  2312.4 MH/s (95.71ms)

Hashtype: MSSQL(2000)

Speed.Dev.#1.:   612.3 MH/s (96.17ms)

Hashtype: MSSQL(2005)

Speed.Dev.#1.:   610.8 MH/s (96.41ms)

Hashtype: MSSQL(2012)

Speed.Dev.#1.: 76705.6 kH/s (93.52ms)

Hashtype: MySQL323

Speed.Dev.#1.:  9126.3 MH/s (58.80ms)

Hashtype: MySQL4.1/MySQL5

Speed.Dev.#1.:   324.5 MH/s (95.88ms)

Hashtype: Oracle H: Type (Oracle 7+)

Speed.Dev.#1.:   117.3 MH/s (96.65ms)

Hashtype: Oracle S: Type (Oracle 11+)

Speed.Dev.#1.:   615.9 MH/s (95.50ms)

Hashtype: Oracle T: Type (Oracle 12+)

Speed.Dev.#1.:     7819 H/s (93.85ms)

Hashtype: Sybase ASE

Speed.Dev.#1.: 36430.8 kH/s (93.06ms)

Hashtype: EPiServer 6.x < v4

Speed.Dev.#1.:   686.1 MH/s (96.29ms)

Hashtype: EPiServer 6.x > v4

Speed.Dev.#1.:   266.8 MH/s (95.40ms)

Hashtype: md5apr1, MD5(APR), Apache MD5

Speed.Dev.#1.:  1198.6 kH/s (95.42ms)

Hashtype: ColdFusion 10+

Speed.Dev.#1.:   184.5 MH/s (96.61ms)

Hashtype: hMailServer

Speed.Dev.#1.:   266.3 MH/s (95.55ms)

Hashtype: SHA-1(Base64), nsldap, Netscape LDAP SHA

Speed.Dev.#1.:   616.7 MH/s (95.35ms)

Hashtype: SSHA-1(Base64), nsldaps, Netscape LDAP SSHA

Speed.Dev.#1.:   617.9 MH/s (95.29ms)

Hashtype: SSHA-512(Base64), LDAP {SSHA512}

Speed.Dev.#1.: 76121.7 kH/s (95.27ms)

Hashtype: LM

Speed.Dev.#1.:   304.4 MH/s (94.63ms)

Hashtype: NTLM

Speed.Dev.#1.:  3496.3 MH/s (95.34ms)

Hashtype: Domain Cached Credentials (DCC), MS Cache

Speed.Dev.#1.:  1043.4 MH/s (95.27ms)

Hashtype: Domain Cached Credentials 2 (DCC2), MS Cache 2

Speed.Dev.#1.:    33339 H/s (96.05ms)

Hashtype: MS-AzureSync PBKDF2-HMAC-SHA256

Speed.Dev.#1.:  1176.2 kH/s (95.46ms)

Hashtype: descrypt, DES(Unix), Traditional DES

Speed.Dev.#1.: 12553.4 kH/s (83.41ms)

Hashtype: BSDiCrypt, Extended DES

Speed.Dev.#1.:   213.2 kH/s (91.96ms)

Hashtype: md5crypt, MD5(Unix), FreeBSD MD5, Cisco-IOS MD5

Speed.Dev.#1.:  1193.8 kH/s (95.48ms)

Hashtype: bcrypt, Blowfish(OpenBSD)

Speed.Dev.#1.:      536 H/s (29.04ms)

Hashtype: sha256crypt, SHA256(Unix)

Speed.Dev.#1.:    40409 H/s (96.47ms)

Hashtype: sha512crypt, SHA512(Unix)

Speed.Dev.#1.:    12638 H/s (96.81ms)

Hashtype: OSX v10.4, v10.5, v10.6

Speed.Dev.#1.:   690.4 MH/s (95.66ms)

Hashtype: OSX v10.7

Speed.Dev.#1.: 75924.9 kH/s (95.51ms)

Hashtype: OSX v10.8+

Speed.Dev.#1.:      908 H/s (94.91ms)

Hashtype: AIX {smd5}

Speed.Dev.#1.:  1195.5 kH/s (95.37ms)

Hashtype: AIX {ssha1}

Speed.Dev.#1.:  4346.4 kH/s (44.20ms)

Hashtype: AIX {ssha256}

Speed.Dev.#1.:  1773.7 kH/s (96.50ms)

Hashtype: AIX {ssha512}

Speed.Dev.#1.:   484.1 kH/s (95.18ms)

Hashtype: Cisco-PIX MD5

Speed.Dev.#1.:  1810.4 MH/s (95.54ms)

Hashtype: Cisco-ASA MD5

Speed.Dev.#1.:  1794.1 MH/s (95.81ms)

Hashtype: Cisco-IOS SHA256

Speed.Dev.#1.:   289.8 MH/s (96.60ms)

Hashtype: Cisco $8$

Speed.Dev.#1.:     6224 H/s (94.92ms)

Hashtype: Cisco $9$

Speed.Dev.#1.:      252 H/s (2032.10ms)

Hashtype: Juniper Netscreen/SSG (ScreenOS)

Speed.Dev.#1.:  1382.4 MH/s (95.54ms)

Hashtype: Juniper IVE

Speed.Dev.#1.:  1196.2 kH/s (95.60ms)

Hashtype: Android PIN

Speed.Dev.#1.:   577.2 kH/s (80.33ms)

Hashtype: Citrix NetScaler

Speed.Dev.#1.:   766.9 MH/s (96.37ms)

Hashtype: RACF

Speed.Dev.#1.:   250.9 MH/s (101.53ms)

Hashtype: GRUB 2

Speed.Dev.#1.:     3222 H/s (95.94ms)

Hashtype: Radmin2

Speed.Dev.#1.:   876.2 MH/s (95.71ms)

Hashtype: SAP CODVN B (BCODE)

Speed.Dev.#1.:   228.8 MH/s (122.31ms)

Hashtype: SAP CODVN F/G (PASSCODE)

Speed.Dev.#1.:   105.1 MH/s (122.17ms)

Hashtype: SAP CODVN H (PWDSALTEDHASH) iSSHA-1

Speed.Dev.#1.:   628.7 kH/s (80.09ms)

Hashtype: Lotus Notes/Domino 5

Speed.Dev.#1.: 34465.4 kH/s (117.28ms)

Hashtype: Lotus Notes/Domino 6

Speed.Dev.#1.:  9252.9 kH/s (132.78ms)

Hashtype: Lotus Notes/Domino 8

Speed.Dev.#1.:    67586 H/s (95.07ms)

Hashtype: PeopleSoft

Speed.Dev.#1.:   615.6 MH/s (95.35ms)

Hashtype: PeopleSoft PS_TOKEN

Speed.Dev.#1.:   310.4 MH/s (96.15ms)

Hashtype: 7-Zip

Speed.Dev.#1.:      969 H/s (95.73ms)

Hashtype: WinZip

Speed.Dev.#1.:   104.5 kH/s (90.42ms)

Hashtype: RAR3-hp

Speed.Dev.#1.:     6479 H/s (78.95ms)

Hashtype: RAR5

Speed.Dev.#1.:     3792 H/s (94.96ms)

Hashtype: AxCrypt

Speed.Dev.#1.:    21350 H/s (172.04ms)

Hashtype: AxCrypt in memory SHA1

Speed.Dev.#1.:   562.8 MH/s (95.93ms)

Hashtype: TrueCrypt PBKDF2-HMAC-RipeMD160 + XTS 512 bit

Speed.Dev.#1.:    28008 H/s (94.09ms)

Hashtype: TrueCrypt PBKDF2-HMAC-SHA512 + XTS 512 bit

Speed.Dev.#1.:    31091 H/s (93.80ms)

Hashtype: TrueCrypt PBKDF2-HMAC-Whirlpool + XTS 512 bit

Speed.Dev.#1.:     5828 H/s (238.61ms)

Hashtype: TrueCrypt PBKDF2-HMAC-RipeMD160 + XTS 512 bit + boot-mode

Speed.Dev.#1.:    53481 H/s (92.15ms)

Hashtype: VeraCrypt PBKDF2-HMAC-RipeMD160 + XTS 512 bit

Speed.Dev.#1.:       88 H/s (94.97ms)

Hashtype: VeraCrypt PBKDF2-HMAC-SHA512 + XTS 512 bit

Speed.Dev.#1.:       64 H/s (96.52ms)

Hashtype: VeraCrypt PBKDF2-HMAC-Whirlpool + XTS 512 bit

Speed.Dev.#1.:       11 H/s (236.78ms)

Hashtype: VeraCrypt PBKDF2-HMAC-RipeMD160 + XTS 512 bit + boot-mode

Speed.Dev.#1.:      175 H/s (95.04ms)

Hashtype: VeraCrypt PBKDF2-HMAC-SHA256 + XTS 512 bit

Speed.Dev.#1.:      118 H/s (95.26ms)

Hashtype: VeraCrypt PBKDF2-HMAC-SHA256 + XTS 512 bit + boot-mode

Speed.Dev.#1.:      296 H/s (95.97ms)

Hashtype: Android FDE <= 4.3

Speed.Dev.#1.:    83553 H/s (93.58ms)

Hashtype: Android FDE (Samsung DEK)

Speed.Dev.#1.:    30470 H/s (94.47ms)

Hashtype: eCryptfs

Speed.Dev.#1.:     1140 H/s (94.31ms)

Hashtype: MS Office <= 2003 MD5 + RC4, oldoffice$0, oldoffice$1

Speed.Dev.#1.:  5693.0 kH/s (139.73ms)

Hashtype: MS Office <= 2003 MD5 + RC4, collision-mode #1

Speed.Dev.#1.:  9162.2 kH/s (204.33ms)

Hashtype: MS Office <= 2003 SHA1 + RC4, oldoffice$3, oldoffice$4

Speed.Dev.#1.:  8318.8 kH/s (176.13ms)

Hashtype: MS Office <= 2003 SHA1 + RC4, collision-mode #1

Speed.Dev.#1.:  9513.6 kH/s (213.86ms)

Hashtype: Office 2007

Speed.Dev.#1.:    13750 H/s (95.12ms)

Hashtype: Office 2010

Speed.Dev.#1.:     6835 H/s (95.23ms)

Hashtype: Office 2013

Speed.Dev.#1.:      732 H/s (95.42ms)

Hashtype: PDF 1.1 - 1.3 (Acrobat 2 - 4)

Speed.Dev.#1.:  9431.3 kH/s (198.36ms)

Hashtype: PDF 1.1 - 1.3 (Acrobat 2 - 4) + collider-mode #1

Speed.Dev.#1.: 10775.9 kH/s (222.34ms)

Hashtype: PDF 1.4 - 1.6 (Acrobat 5 - 8)

Speed.Dev.#1.:   462.4 kH/s (125.29ms)

Hashtype: PDF 1.7 Level 3 (Acrobat 9)

Speed.Dev.#1.:   291.8 MH/s (96.08ms)

Hashtype: PDF 1.7 Level 8 (Acrobat 10 - 11)

Speed.Dev.#1.:     3342 H/s (459.56ms)

Hashtype: Password Safe v2

Speed.Dev.#1.:    10735 H/s (31.78ms)

Hashtype: Password Safe v3

Speed.Dev.#1.:   124.4 kH/s (91.60ms)

Hashtype: Lastpass

Speed.Dev.#1.:   240.5 kH/s (81.16ms)

Hashtype: 1Password, agilekeychain

Speed.Dev.#1.:   335.7 kH/s (88.31ms)

Hashtype: 1Password, cloudkeychain

Speed.Dev.#1.:      799 H/s (94.02ms)

Hashtype: Bitcoin/Litecoin wallet.dat

Speed.Dev.#1.:      374 H/s (94.99ms)

Hashtype: Blockchain, My Wallet

Speed.Dev.#1.:  8008.1 kH/s (96.26ms)

Hashtype: Keepass 1 (AES/Twofish) and Keepass 2 (AES)

Speed.Dev.#1.:    24085 H/s (173.30ms)

Hashtype: ArubaOS

Speed.Dev.#1.:   689.3 MH/s (95.43ms)

Started: Mon Aug 29 09:29:12 2016
Stopped: Mon Aug 29 09:47:27 2016
```

## CPU
```
hashcat (v3.10) starting in benchmark-mode...

OpenCL Platform #1: Intel(R) Corporation
========================================
- Device #1: Intel(R) Xeon(R) CPU E5-2666 v3 @ 2.90GHz, 3655/14622 MB allocatable, 8MCU

Hashtype: MD4

Speed.Dev.#1.:   762.1 MH/s (10.96ms)

Hashtype: MD5

Speed.Dev.#1.:   449.9 MH/s (18.60ms)

Hashtype: Half MD5

Speed.Dev.#1.:   269.7 MH/s (31.06ms)

Hashtype: SHA1

Speed.Dev.#1.:   248.2 MH/s (33.75ms)

Hashtype: SHA256

Speed.Dev.#1.: 93109.5 kH/s (90.04ms)

Hashtype: SHA384

Speed.Dev.#1.: 27199.8 kH/s (96.02ms)

Hashtype: SHA512

Speed.Dev.#1.: 27159.7 kH/s (96.12ms)

Hashtype: SHA-3(Keccak)

Speed.Dev.#1.: 24502.4 kH/s (95.70ms)

Hashtype: SipHash

Speed.Dev.#1.:   626.8 MH/s (13.34ms)

Hashtype: RipeMD160

Speed.Dev.#1.:   121.4 MH/s (69.08ms)

Hashtype: Whirlpool

Speed.Dev.#1.:  3622.2 kH/s (96.34ms)

Hashtype: GOST R 34.11-94

Speed.Dev.#1.:  3776.2 kH/s (96.31ms)

Hashtype: GOST R 34.11-2012 (Streebog) 256-bit

Speed.Dev.#1.:  1556.7 kH/s (95.17ms)

Hashtype: GOST R 34.11-2012 (Streebog) 512-bit

Speed.Dev.#1.:  1561.1 kH/s (95.77ms)

Hashtype: phpass, MD5(Wordpress), MD5(phpBB3), MD5(Joomla)

Speed.Dev.#1.:   151.4 kH/s (26.74ms)

Hashtype: scrypt

Speed.Dev.#1.:    24344 H/s (2.37ms)

Hashtype: PBKDF2-HMAC-MD5

Speed.Dev.#1.:   154.3 kH/s (51.83ms)

Hashtype: PBKDF2-HMAC-SHA1

Speed.Dev.#1.:    92975 H/s (86.62ms)

Hashtype: PBKDF2-HMAC-SHA256

Speed.Dev.#1.:    37583 H/s (96.89ms)

Hashtype: PBKDF2-HMAC-SHA512

Speed.Dev.#1.:    13547 H/s (64.31ms)

Hashtype: Skype

Speed.Dev.#1.:   279.0 MH/s (7.41ms)

Hashtype: WPA/WPA2

Speed.Dev.#1.:    11397 H/s (96.20ms)

Hashtype: IKE-PSK MD5

Speed.Dev.#1.: 39104.1 kH/s (53.59ms)

Hashtype: IKE-PSK SHA1

Speed.Dev.#1.: 22906.9 kH/s (96.13ms)

Hashtype: NetNTLMv1-VANILLA / NetNTLMv1+ESS

Speed.Dev.#1.:   468.5 MH/s (17.85ms)

Hashtype: NetNTLMv2

Speed.Dev.#1.: 36559.8 kH/s (97.41ms)

Hashtype: IPMI2 RAKP HMAC-SHA1

Speed.Dev.#1.: 46172.3 kH/s (96.07ms)

Hashtype: Kerberos 5 AS-REQ Pre-Auth etype 23

Speed.Dev.#1.:  3139.3 kH/s (97.44ms)

Hashtype: Kerberos 5 TGS-REP etype 23

Speed.Dev.#1.:  3188.2 kH/s (95.93ms)

Hashtype: DNSSEC (NSEC3)

Speed.Dev.#1.: 80998.2 kH/s (96.60ms)

Hashtype: PostgreSQL Challenge-Response Authentication (MD5)

Speed.Dev.#1.:   124.1 MH/s (67.53ms)

Hashtype: MySQL Challenge-Response Authentication (SHA1)

Speed.Dev.#1.: 67218.7 kH/s (96.23ms)

Hashtype: SIP digest authentication (MD5)

Speed.Dev.#1.: 17274.0 kH/s (97.16ms)

Hashtype: SMF > v1.1

Speed.Dev.#1.:   203.3 MH/s (41.21ms)

Hashtype: vBulletin < v3.8.5

Speed.Dev.#1.:   125.6 MH/s (66.72ms)

Hashtype: vBulletin > v3.8.5

Speed.Dev.#1.: 90970.9 kH/s (92.16ms)

Hashtype: IPB2+, MyBB1.2+

Speed.Dev.#1.: 93902.7 kH/s (89.29ms)

Hashtype: WBB3, Woltlab Burning Board 3

Speed.Dev.#1.: 31542.8 kH/s (96.00ms)

Hashtype: OpenCart

Speed.Dev.#1.: 41445.5 kH/s (96.20ms)

Hashtype: Joomla < 2.5.18

Speed.Dev.#1.:   438.7 MH/s (19.08ms)

Hashtype: PHPS

Speed.Dev.#1.:   126.7 MH/s (66.19ms)

Hashtype: Drupal7

Speed.Dev.#1.:      695 H/s (95.90ms)

Hashtype: osCommerce, xt:Commerce

Speed.Dev.#1.:   286.0 MH/s (7.30ms)

Hashtype: PrestaShop

Speed.Dev.#1.:   170.4 MH/s (49.19ms)

Hashtype: Django (SHA-1)

Speed.Dev.#1.:   203.7 MH/s (41.15ms)

Hashtype: Django (PBKDF2-SHA256)

Speed.Dev.#1.:     1917 H/s (93.96ms)

Hashtype: Mediawiki B type

Speed.Dev.#1.: 80619.4 kH/s (25.97ms)

Hashtype: Redmine Project Management Web App

Speed.Dev.#1.: 54948.4 kH/s (96.10ms)

Hashtype: PostgreSQL

Speed.Dev.#1.:   440.6 MH/s (18.99ms)

Hashtype: MSSQL(2000)

Speed.Dev.#1.:   249.3 MH/s (33.61ms)

Hashtype: MSSQL(2005)

Speed.Dev.#1.:   250.6 MH/s (33.44ms)

Hashtype: MSSQL(2012)

Speed.Dev.#1.: 27099.1 kH/s (48.06ms)

Hashtype: MySQL323

Speed.Dev.#1.:  1234.3 MH/s (1.67ms)

Hashtype: MySQL4.1/MySQL5

Speed.Dev.#1.:   113.4 MH/s (73.95ms)

Hashtype: Oracle H: Type (Oracle 7+)

Speed.Dev.#1.:  9000.3 kH/s (96.38ms)

Hashtype: Oracle S: Type (Oracle 11+)

Speed.Dev.#1.:   248.4 MH/s (33.73ms)

Hashtype: Oracle T: Type (Oracle 12+)

Speed.Dev.#1.:     1389 H/s (88.43ms)

Hashtype: Sybase ASE

Speed.Dev.#1.: 13045.8 kH/s (95.99ms)

Hashtype: EPiServer 6.x < v4

Speed.Dev.#1.:   202.2 MH/s (41.43ms)

Hashtype: EPiServer 6.x > v4

Speed.Dev.#1.: 85416.0 kH/s (95.95ms)

Hashtype: md5apr1, MD5(APR), Apache MD5

Speed.Dev.#1.:    38893 H/s (97.14ms)

Hashtype: ColdFusion 10+

Speed.Dev.#1.: 50587.4 kH/s (41.40ms)

Hashtype: hMailServer

Speed.Dev.#1.: 85309.4 kH/s (96.02ms)

Hashtype: SHA-1(Base64), nsldap, Netscape LDAP SHA

Speed.Dev.#1.:   247.3 MH/s (33.85ms)

Hashtype: SSHA-1(Base64), nsldaps, Netscape LDAP SSHA

Speed.Dev.#1.:   248.5 MH/s (33.71ms)

Hashtype: SSHA-512(Base64), LDAP {SSHA512}

Speed.Dev.#1.: 27174.9 kH/s (96.08ms)

Hashtype: LM

Speed.Dev.#1.: 94441.3 kH/s (94.20ms)

Hashtype: NTLM

Speed.Dev.#1.:   764.5 MH/s (10.93ms)

Hashtype: Domain Cached Credentials (DCC), MS Cache

Speed.Dev.#1.:   250.6 MH/s (33.44ms)

Hashtype: Domain Cached Credentials 2 (DCC2), MS Cache 2

Speed.Dev.#1.:     9270 H/s (88.13ms)

Hashtype: MS-AzureSync PBKDF2-HMAC-SHA256

Speed.Dev.#1.:    67248 H/s (39.28ms)

Hashtype: descrypt, DES(Unix), Traditional DES

Speed.Dev.#1.:  3942.1 kH/s (132.82ms)

Hashtype: BSDiCrypt, Extended DES

Speed.Dev.#1.:    17210 H/s (90.93ms)

Hashtype: md5crypt, MD5(Unix), FreeBSD MD5, Cisco-IOS MD5

Speed.Dev.#1.:    38807 H/s (97.55ms)

Hashtype: bcrypt, Blowfish(OpenBSD)

Speed.Dev.#1.:     2593 H/s (96.29ms)

Hashtype: sha256crypt, SHA256(Unix)

Speed.Dev.#1.:     2414 H/s (93.57ms)

Hashtype: sha512crypt, SHA512(Unix)

Speed.Dev.#1.:     2135 H/s (93.77ms)

Hashtype: OSX v10.4, v10.5, v10.6

Speed.Dev.#1.:   196.4 MH/s (10.63ms)

Hashtype: OSX v10.7

Speed.Dev.#1.: 26938.6 kH/s (95.73ms)

Hashtype: OSX v10.8+

Speed.Dev.#1.:      390 H/s (95.80ms)

Hashtype: AIX {smd5}

Speed.Dev.#1.:    38998 H/s (97.08ms)

Hashtype: AIX {ssha1}

Speed.Dev.#1.:   253.5 kH/s (30.79ms)

Hashtype: AIX {ssha256}

Speed.Dev.#1.:   103.9 kH/s (75.99ms)

Hashtype: AIX {ssha512}

Speed.Dev.#1.:    87637 H/s (90.03ms)

Hashtype: Cisco-PIX MD5

Speed.Dev.#1.:   295.8 MH/s (6.99ms)

Hashtype: Cisco-ASA MD5

Speed.Dev.#1.:   326.4 MH/s (25.65ms)

Hashtype: Cisco-IOS SHA256

Speed.Dev.#1.: 93049.6 kH/s (90.11ms)

Hashtype: Cisco $8$

Speed.Dev.#1.:     1915 H/s (94.06ms)

Hashtype: Cisco $9$

Speed.Dev.#1.:     1625 H/s (39.02ms)

Hashtype: Juniper Netscreen/SSG (ScreenOS)

Speed.Dev.#1.:   280.9 MH/s (7.43ms)

Hashtype: Juniper IVE

Speed.Dev.#1.:    39002 H/s (97.09ms)

Hashtype: Android PIN

Speed.Dev.#1.:    30742 H/s (96.13ms)

Hashtype: Citrix NetScaler

Speed.Dev.#1.:   196.8 MH/s (10.61ms)

Hashtype: RACF

Speed.Dev.#1.: 18175.9 kH/s (95.47ms)

Hashtype: GRUB 2

Speed.Dev.#1.:     1366 H/s (93.55ms)

Hashtype: Radmin2

Speed.Dev.#1.:   162.9 MH/s (12.82ms)

Hashtype: SAP CODVN B (BCODE)

Speed.Dev.#1.: 19302.0 kH/s (103.90ms)

Hashtype: SAP CODVN F/G (PASSCODE)

Speed.Dev.#1.:  8795.0 kH/s (95.89ms)

Hashtype: SAP CODVN H (PWDSALTEDHASH) iSSHA-1

Speed.Dev.#1.:    31806 H/s (96.14ms)

1 warning generated.
Hashtype: Lotus Notes/Domino 5

Speed.Dev.#1.:  3934.9 kH/s (97.28ms)

Hashtype: Lotus Notes/Domino 6

Speed.Dev.#1.:  1252.5 kH/s (98.05ms)

Hashtype: Lotus Notes/Domino 8

Speed.Dev.#1.:     3393 H/s (93.82ms)

Hashtype: PeopleSoft

Speed.Dev.#1.:   236.0 MH/s (8.78ms)

Hashtype: PeopleSoft PS_TOKEN

Speed.Dev.#1.: 16462.5 kH/s (95.99ms)

Hashtype: 7-Zip

Speed.Dev.#1.:       64 H/s (95.96ms)

Hashtype: WinZip

Speed.Dev.#1.:     5672 H/s (72.03ms)

Hashtype: RAR3-hp

Speed.Dev.#1.:      404 H/s (80.35ms)

Hashtype: RAR5

Speed.Dev.#1.:      210 H/s (95.93ms)

Hashtype: AxCrypt

Speed.Dev.#1.:     3213 H/s (93.79ms)

Hashtype: AxCrypt in memory SHA1

Speed.Dev.#1.:   222.7 MH/s (9.38ms)

Hashtype: TrueCrypt PBKDF2-HMAC-RipeMD160 + XTS 512 bit

Speed.Dev.#1.:     1290 H/s (94.01ms)

Hashtype: TrueCrypt PBKDF2-HMAC-SHA512 + XTS 512 bit

Speed.Dev.#1.:     5644 H/s (72.11ms)

Hashtype: TrueCrypt PBKDF2-HMAC-Whirlpool + XTS 512 bit

Speed.Dev.#1.:     1022 H/s (88.40ms)

Hashtype: TrueCrypt PBKDF2-HMAC-RipeMD160 + XTS 512 bit + boot-mode

Speed.Dev.#1.:     2572 H/s (84.37ms)

Hashtype: VeraCrypt PBKDF2-HMAC-RipeMD160 + XTS 512 bit

Speed.Dev.#1.:        4 H/s (95.71ms)

Hashtype: VeraCrypt PBKDF2-HMAC-SHA512 + XTS 512 bit

Speed.Dev.#1.:       11 H/s (95.87ms)

Hashtype: VeraCrypt PBKDF2-HMAC-Whirlpool + XTS 512 bit

Speed.Dev.#1.:        2 H/s (96.03ms)

Hashtype: VeraCrypt PBKDF2-HMAC-RipeMD160 + XTS 512 bit + boot-mode

Speed.Dev.#1.:        8 H/s (95.74ms)

Hashtype: VeraCrypt PBKDF2-HMAC-SHA256 + XTS 512 bit

Speed.Dev.#1.:        7 H/s (95.78ms)

Hashtype: VeraCrypt PBKDF2-HMAC-SHA256 + XTS 512 bit + boot-mode

Speed.Dev.#1.:       17 H/s (95.80ms)

Hashtype: Android FDE <= 4.3

Speed.Dev.#1.:     4234 H/s (94.04ms)

Hashtype: Android FDE (Samsung DEK)

Speed.Dev.#1.:     1685 H/s (88.58ms)

Hashtype: eCryptfs

Speed.Dev.#1.:      173 H/s (95.78ms)

Hashtype: MS Office <= 2003 MD5 + RC4, oldoffice$0, oldoffice$1

Speed.Dev.#1.:  3323.2 kH/s (96.19ms)

Hashtype: MS Office <= 2003 MD5 + RC4, collision-mode #1

Speed.Dev.#1.:  5445.5 kH/s (94.70ms)

Hashtype: MS Office <= 2003 SHA1 + RC4, oldoffice$3, oldoffice$4

Speed.Dev.#1.:  4342.4 kH/s (104.15ms)

Hashtype: MS Office <= 2003 SHA1 + RC4, collision-mode #1

Speed.Dev.#1.:  6307.8 kH/s (96.03ms)

Hashtype: Office 2007

Speed.Dev.#1.:      706 H/s (95.92ms)

Hashtype: Office 2010

Speed.Dev.#1.:      353 H/s (95.81ms)

Hashtype: Office 2013

Speed.Dev.#1.:      116 H/s (95.79ms)

Hashtype: PDF 1.1 - 1.3 (Acrobat 2 - 4)

Speed.Dev.#1.:  6121.3 kH/s (96.28ms)

Hashtype: PDF 1.1 - 1.3 (Acrobat 2 - 4) + collider-mode #1

Speed.Dev.#1.:  7977.6 kH/s (94.92ms)

Hashtype: PDF 1.4 - 1.6 (Acrobat 5 - 8)

Speed.Dev.#1.:   274.9 kH/s (95.91ms)

Hashtype: PDF 1.7 Level 3 (Acrobat 9)

Speed.Dev.#1.: 92125.8 kH/s (22.72ms)

Hashtype: PDF 1.7 Level 8 (Acrobat 10 - 11)

Speed.Dev.#1.:     1980 H/s (102.86ms)

Hashtype: Password Safe v2

Speed.Dev.#1.:    61990 H/s (95.97ms)

Hashtype: Password Safe v3

Speed.Dev.#1.:     6711 H/s (95.74ms)

Hashtype: Lastpass

Speed.Dev.#1.:    13608 H/s (95.90ms)

Hashtype: 1Password, agilekeychain

Speed.Dev.#1.:    17082 H/s (95.99ms)

Hashtype: 1Password, cloudkeychain

Speed.Dev.#1.:      143 H/s (95.92ms)

Hashtype: Bitcoin/Litecoin wallet.dat

Speed.Dev.#1.:       57 H/s (95.83ms)

Hashtype: Blockchain, My Wallet

Speed.Dev.#1.:   578.4 kH/s (9.77ms)

Hashtype: Keepass 1 (AES/Twofish) and Keepass 2 (AES)

Speed.Dev.#1.:     3948 H/s (93.54ms)

Hashtype: ArubaOS

Speed.Dev.#1.:   199.0 MH/s (10.51ms)

Started: Mon Aug 29 11:05:07 2016
Stopped: Mon Aug 29 11:11:54 2016 
```