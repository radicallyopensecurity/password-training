# Demo login deployment
The demo login pages are deployed into the Docker image by default, however should your want to run them elsewhere the scripts in this directory will help you deploy them on any almost Debian/Ubuntu based system.
It is not recommended to use the deploy script on web servers that are also meant to run anything other than this demo since it will overwrite the default Apache vhost configuration.

## Pre-deployment
You will need to set up a Debian or Ununtu based server where you want to run the demo login pages. Other operating systems are note handled by the deploy script, but the pages can be deployed manually on any web server with PHP support.

If Apache and PHP are not already installed, do so now.
```
apt-get install apache2 php5 -y
```
Start apache if not started already.
```
service apache2 start
```
The server should now be ready to have the demo logins deployed on it. Be sure to check if the server is running and reachable.

## Automatic deployment using the script
The "deploy.sh" script found in this directory will write an Apache vhost config and place the demo login pages in the web directory for you. Simply copy the script over to the server that will run the demo. The script does require super-user privileges to copy files into protected directories so run it with sudo or as the root user.
```
sudo bash deploy.sh
```
The script will automatically tell Apache to reload its configuration so when the script is done your should see the demo login pages become available on the web server.

## Manual deployment
To manually deploy the demo login no systems that are not supported by the "deploy.sh" script, copy the files from web folder the of the online demo into your web servers content directory. This is usually located somewhere in `/var/www/` on most Linux systems. If you're using the default web server vhost this should be all you need to do. If you are using another vhost, be sure to add the required vhost configuration. The exact configuration required depend on the vhost and web server you are using. If you are using Apache as your web server, you can have a look at the `vhost.conf` file for an example.

## Making changes to the website
If you have made any changes to the demo login pages the "deploy.sh" script will need to be regenerated to reflect your changes. Run the "deploygenerator.sh" script in order to generate a new "deploy.sh" script.
```
./deploygenerator.sh
```
