# Hash generator
You can use this tool to generate password hashes of different types and the john or hashcat commands you need to crack them. Before trying to crack a generated hash it may be a good idea to use the "estimator.rb" script too to check if your hash is likely to be cracked in any reasonable amount of time.

## Usage
The generator script may be found in the `/root/password-cracking/generator/` directory inside your docker container.
Running the script requires no special parameters:
```
ruby generator.rb
```

The script will prompt you for any information it requires, such as hash types and attack methods. It will write a file to the current working directory containing the generated hash and output the command to crack it in the terminal.

## Notes on bcrypt
In order to make the password cracking a little more manageable for bcrypt hashes there is a bcrypt_reduced option available in the algorithms. The default work factor has been brought down from 10 to 5. This reduces the memory requirement and processing time required for bcrypt hashes. Though the default work factor for bcrypt hashes is usually 10, allowing you to generate hashes with a work factor of 5 makes it possible to experiment with bcrypt hashes on some lower end hardware too.

## Notes on scrypt
For scrypt hashes there is a similar construction in place where you are allowed to generate a reduced complexity hash in order to allow for faster testing and experimentation. This is the scrypt_reduced option in the generator script.