# Memory dump
This demo is a simple password manager which can be seen as a professional manager like Keepass etc.
The password is stored in plaintext as an example. Real password managers would use hashes.
However, those hashes are not secure, unless the user chooses a secure password!

##Requirements
Dumpit - http://www.downloadcrew.com/article/23854-dumpit
HxD - http://www.heise.de/download/product/hxd-50764
Volatility - http://downloads.volatilityfoundation.org/releases/2.5/volatility_2.5.win.standalone.zip
#Dump ftp credentials.
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

#Dump Windows user password hashes with Volatility
## Usage
```
Launch the tool dumpit.exe downloaded from the requirements.
```

A dumpfile will be created. Paste it inside the Folder:
C:\Users\IEUser\Desktop\volatility_2.5.win.standalone
Open the CMD and Navigate to Volatility.
```
Windows+R -> Cmd -> Enter -> cd Desktop/volatility_2.5.win.standalone
```

Now use Volatility to check for the hivelist
```
volatility-2.5.standalone.exe -f IE8WIN7-20160923-152024.raw --profile=Win7SP1x86 hivelist
```

Now that we see the list. Use the virtual adress from the Entry with the name '\SystemRoot\System32\Config\SAM'.
(This is the File where Windows stores the user passwords)
```
volatility-2.5.standalone.exe -f IE8WIN7-20160923-152024.raw --profile=Win7SP1x86 hashdump -s 0x9515f598 >
 hashes.txt
```

Lastly, you see the hashes from the Users. Select the Password from the IEUser and crack it online with a Service like
https://crackstation.net/ .
If the Password is simple enough. You now have the password of the Windows machine.


#Dump Github login from Firefox history with a simple hex editor
##Usage
```
Sign in to Github with the account rosdemo@trash-mail.com and the password secretpassword1
Now launch dumpit.exe located on desktop
```
Open the hexeditor HxD
```
Hit Strg+f and enter "user[password]"
```
You should see the entered password on Github.
