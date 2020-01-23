# User Password Retreival From Memory Dump

## Download and Install 32-bit Windows 7 Virtual Machine
* Windows 7 VMs can be downloaded from Microsoft at https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/. 
* Install the VM on the platform of your choice. These VMs expire after 90 days, so Microsoft recommends creating a snapshot after the initial installation. 
You may need to restart the VM after installation. 

## Download Volatility
* Volatility can be downloaded from http://downloads.volatilityfoundation.org/releases/2.5/volatility_2.5.win.standalone.zip.
While there are more recent versions of Volatility, we will use version 2.5 because it will run on a 32-bit machine.
* Save the Volatility zip file onto the VM and extract its contents.

## Obtain Memory Image Using DumpIt
* Download the DumpIt executable from https://github.com/thimbleweed/All-In-USB/tree/master/utilities/DumpIt and save the file onto the VM.
* Open a command prompt on the VM.
* Navigate to the folder containing "DumpIt.exe".
* Run DumpIt: `DumpIt.exe`. Dumpit will produce a memory image with a name similar to the Virtal Machine name (for example "IE8WIN7-20200116-184345.raw") but has been renamed to "image.dmp" in the examples below.

## Retrieve Password Using Volatility

### Find the Volatility profile
* Copy the memory image "image.dmp" to the folder containing "volatility-2.5.standalone.exe".
* Run `volatility-2.5.standalone.exe -f image.dmp imageinfo` to find the profile (based on the operating system and service pack version, "Win7SP1x86" in the examples below).

### Dump Registry Hives
* Run  `volatility-2.5.standalone.exe -f image.dmp --profile=Win7SP1x86 hivelist` to see the registry hive offsets.
* We will need the SYSTEM (-y) and SAM (-s) virtual offests (0x87a1c008 and 0x8a4299c8 in the example below).

### Dump Password Hashes
* Run `volatility-2.5.standalone.exe -f image.dmp --profile=Win7SP1x86 hashdump -y 0x87a1c008 -s 0x8a4299c8 > hashes.txt` to dump the password hashes. Be sure to replace the virtual offsets with the ones you found in the previous step. 
* View the hashes in the command prompt: `type hashes.txt`
* Copy the hashes to https://crackstation.net/ to crack the passwords (the NTLM hash is the part between the third colon and the final three colons).

## References
* https://www.aldeid.com/wiki/Volatility/Retrieve-password
