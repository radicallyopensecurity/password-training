# Memory dump
### This demo contains a few demos:
1. FTP PASS dump
3. Windows user hash dump
3. Dump Firefox history & cookies
4. Dump Github login from Firefox process with a simple hex editor

## Requirements
Windows VM - https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/

Python - https://www.python.org/ftp/python/2.7.12/python-2.7.12.msi

Select IE8 on Win7, as platform VirtualBox. Download the .zip and extract. Open the extracted file with VirtualBox and launch it.

### Also download the following tools:

Dumpit - http://www.downloadcrew.com/article/23854-dumpit

HxD - http://www.heise.de/download/product/hxd-50764

Volatility - http://downloads.volatilityfoundation.org/releases/2.5/volatility_2.5.win.standalone.zip

Volatility plugins - https://github.com/superponible/volatility-plugins

Paste the extracted .py files inside volatility-master/volatility/plugins

# Dump FTP credentials (Linux)
## Usage
Open any Linux docker instance.
Switch inside the docker instance, enter the command but do not submit yet!
```
docker run -it --privileged dockername /bin/bash
pgrep -f ftp | xargs gcore
```

Open another docker session and open ftp.
```
docker exec -it --privileged dockername bash
ftp lima-ftp.de
```
Now enter username test and enter any password.
Right after you entered the password, switch to the other terminal and hit enter.
Finally, use Strings and Grep to find the password in the dump.
```
strings ftpdumpfile | grep PASS
```

# Dump Windows user password hashes with Volatility (Windows)
## Usage
```
Launch the tool dumpit.exe downloaded from the requirements.
```

A dumpfile will be created. Paste it inside the Folder:
volatility-master
Open the CMD and Navigate to Volatility.
```
Windows+R -> Cmd -> Enter -> cd Desktop/volatility-master
```

Now use Volatility to check for the hivelist
```
python vol.py -f IE8WIN7-20160923-152024.raw --profile=Win7SP1x86 hivelist
```

Now that we see the list. Use the virtual address from the Entry with the name '\SystemRoot\System32\Config\SAM'.
(This is the file where Windows stores the user passwords)
```
python vol.py -f IE8WIN7-20160923-152024.raw --profile=Win7SP1x86 hashdump -s 0x9515f598 >
 hashes.txt
```

Lastly, you see the hashes from the Users. Select the Password from the IEUser and crack it online with a Service like
https://crackstation.net/ .

If the Password is simple enough. You now have the password of the Windows machine.

# Dump Firefox History & Cookies
## Usage

Surf a bit on Sites like Facebook,Gmail etc. Login to some sites.

Use the following command to dump the firefox history into a txt file.
```
python vol.py --plugins=plugins/ -f IE8WIN7-20160927-111546.raw firefoxhistory > history.txt
```
And this one to dump the partial cookies of Firefox.
```
python vol.py --plugins=plugins/ -f IE8WIN7-20160927-111546.raw firefoxcookies > cookies.txt
```
#Dump Github login from Firefox process with a simple hex editor(Windows)
##Usage
```
Sign in to Github with the account rosdemo@trash-mail.com and the password secretpassword1
Now launch dumpit.exe located on desktop
```
Open the hex editor HxD
```
Hit Strg+f and enter "user[password]"
```
You should see the entered password on Github.
