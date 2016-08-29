# Hash generator
You can use this tool to generate password hashes of different types and the john or hashcat commands you need to crack them. Before trying to crack a generated hash it may be a good idea to use the "estimator.rb" too to check if your hash is likely to be cracked in any reasonable amount of time.

## Usage
Run the ruby script with no special parameters:
```
ruby generator.rb
```

The script will prompt you for any information it requires, such as hash types and attack methods. It will write a file to the current working directory containing the generated hash and output the command to crack it in the terminal.