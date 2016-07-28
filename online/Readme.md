# Online cracking
This demo uses hydra to do brute force attacks on web logins. There are two demo pages, one using Apache's HTTP basic auth to provide a login form. The second is a HTML form which validates the entered credentials against a hardcoded bcrypt hash.
To get started, log into the kali container and run 'service apache2 start' to bring up the local test sites.
The username and password for both demo pages is "admin" with password "secret1".
- Apache http basic auth can be found at http://localhost/basic/
- Php login form can be found at http://localhost/form/
- Bonus; determine a valid user for the php form by doing timing analysis on the web form. This type of attack is sometimes called a "side channel attack", though this name is more commonly used when attacking a cryptographic system.

## Hydra syntax
The -l option specifies a single user name. To take user names from a file you can use the option -L instead. The same applies for passwords. A single password may be specified with the -p option while a file containing a list of passwords can be specified using -P. The IP address or hostname may be used to provide the target, followed by the protocol specification which is "http-get" for our HTTP basic auth example and "http-form-post" for the HTML form. The HTTP basic auth example may also be done with the "http-head" option which may be slightly faster, but not all web servers respond the same to HEAD requests with authentication so it may not yield any results in some cases. After the protocol specifier there are options specific to that protocol. In both our examples this is just the path to the login page.

### Dictionary attack against basic auth
```
hydra -l "admin" -P /usr/share/wordlists/rockyou.txt localhost http-get /basic
```

### Brute force generation attack against basic auth
The -x option will make Hydra generate all possible passwords in the set you specify. The specification is done by passing three parameters to the -x argument; minimum length, maximum length and the character set to use, each parameter separated by a colon. The character set specification is not very elaborate, a lowercase "a" for lowercase characters, an uppercase "A" for uppercase and a "1" for numbers. Any special characters may be added onto the character specification at the end. So if we want to generate passwords of 6 to 8 characters long with only lowercase and numbers we would pass the option "-x 6:8:a1" to Hydra. Note that Hydra does not allow you to generate very large password lists this way. It automatically stops with an error if your brute force generator specification would result in more than 4 billion passwords. This is done since it is typically not feasible to perform such an attack over the network.
```
hydra -l "admin" -x 6:8:a1 localhost http-get /basic
```

HTTP basic auth attacks are usually very noisy in the sense that they tend to consume a lot of CPU on the target server and leave a log entry for each failed login attampt. You should be able to see this in /var/log/apache2/error.log after a brute force attack.

### Dictionary attack against HTML form
The syntax for http forms is the same as for http basic auth except for the protocol specifier and the protocol specific options. The protocol specifier we need for most HTML forms is "http-form-post". In some cases a form will use GET instead of POST to submit a form in which case "http-form-get" must be used, but this is very uncommon for login forms. The protocol specific options start with the path where the login form posts its data to. If we inspect the source of the HTML page we can find the form tag. A form submits to the page that is specified in the "action" attribute of the form tag, but if we look at the example page we find there is no "action" specified. In this case the form is submitted back to the same page the form itself is on, so "/form/index.php" in our example. After that we need to specify which form fields are to be used for the username and password. These are the "name" attributes for the two "input" tags. In our example they are conveniently named "username" and "password". To specify this to Hydra we give it the string "username=&#94;USER&#94;&password=&#94;PASS&#94;" The &#94;USER&#94; and &#94;PASS&#94; marks tell Hydra exactly where we want it to insert the username and password for each login attempt. The last thing we need to specify is how to determine when a login was successful, this is done by giving it any text string that is on the failed login page and which we do not expect to be on the successful login page. The error messages telling us our login failed is usually a good choice. Hydra will scan the result it gets back from each login attempt for this text string and conclude that the login attempt was successful if it does not find that text string in the response. Each of the parameters specific to the http-form-post action are again separated by a colon. In our example we put quotes around the whole set of arguments to ensure our shell passes it to Hydra as a single argument.
```
hydra -l "admin" -P /usr/share/wordlists/rockyou.txt localhost http-form-post "/form/index.php:username=&#94;USER&#94;&password=&#94;PASS&#94;:Login failed"
```

# Run apache in docker so it can be accessed from the host OS
You may wish to try some external tools or look at pages in your browser, to do so you can run apache in the docker container and bind it to port 8000 on localhost;

docker run -d -p 8000:80 ros-demos/kali-linux-docker /usr/sbin/apache2ctl -D FOREGROUND

You should be able to access the sites on http://localhost:8000/ now.
(Use 'docker ps' and 'docker stop' to shut down the apache server after you are done.)
