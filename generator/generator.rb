#!/usr/bin/env ruby
require 'base64'
require 'digest'
require 'bcrypt'
require 'highline/import'
require 'scrypt'
require 'smbhash'

# Get password to generate hash for
password = ask( 'Password:  ' ) { |q| q.default = 'P4$$w0rd' }
puts ''

# Get hash type and generate the hash
hash = ''
type = nil
choose do |menu|
  menu.header = 'Hashing algorithms'
  menu.prompt = 'Choose a hash type: '
  menu.choice :md5 do
    type = :md5
    hash = Digest::MD5.hexdigest(password)
  end
  menu.choice :sha1 do
    type = :sha1
    hash = Digest::SHA1.hexdigest(password)
  end
  menu.choice :sha256 do
    type = :sha256
    hash = Digest::SHA256.hexdigest(password)
  end
  menu.choice :lm do
    type = :lm
    hash = Smbhash.lm_hash(password)
  end
  menu.choice :ntlm do
    type = :ntlm
    hash = Smbhash.ntlm_hash(password)
  end
  menu.choice :bcrypt do
    type = :bcrypt
    hash = BCrypt::Password.create(password, :cost => 10)
  end
  menu.choice :bcrypt_reduced do
    type = :bcrypt
    hash = BCrypt::Password.create(password, :cost => 5)
  end
  menu.choice :scrypt do
    type = :scrypt
    hash = SCrypt::Password.create(password)
  end

  menu.default = :md5
end
puts ''

# Get cracker
tool = nil
choose do |menu|
  menu.header = 'Cracking tools'
  menu.prompt = 'Choose a tool: '
  menu.choice :john do tool = :john end
  menu.choice :hashcat do tool = :hashcat end

  menu.default = :john
end
puts ''

# Get cracking method
method = nil
choose do |menu|
  menu.header = 'Attack methods'
  menu.prompt = 'Choose a method: '
  menu.choice :wordlist do method = :wordlist end
  menu.choice :bruteforce do method = :bruteforce end

  menu.default = :wordlist
end
puts ''

wordlist  = ''
maxlenght = password.length
charset   = ''
charpatt  = ''

if method == :wordlist
  wordlist = ask( 'Wordlist file:  ' ) { |q| q.default = '/usr/share/wordlists/rockyou.txt' }
elsif method == :bruteforce
  # Determine password character set
  charsets = {
    :low   => false,
    :upp   => false,
    :num   => false,
    :spc   => false,
    :human => '',
    :size  => 0
  }

  password.each_codepoint do |c|
    if c >= 48 and c <= 57
      charsets[:num] = true
      charpatt << '?d'
    elsif c >= 65 and c <= 90
      charsets[:upp] = true
      charpatt << '?u'
    elsif c >= 97 and c <= 122
      charsets[:low] = true
      charpatt << '?l'
    else
      charsets[:spc] = true
      charpatt << '?s'
    end
  end
  if charsets[:spc]
    charset = :ASCII
  elsif charsets[:num] && charsets[:upp] && charsets[:low]
    charset = :alnum
  elsif charsets[:num] && charsets[:upp]
    charset = :uppernum
  elsif charsets[:num] && charsets[:low]
    charset = :lowernum
  elsif charsets[:upp] && charsets[:low]
    charset = :alnum
  elsif charsets[:low]
    charset = :lower
  elsif charsets[:upp]
    charset = :upper
  elsif charset[:num]
    charset = :digits
  end
end

cmd = "#{tool} "
if tool == :john
  cmd << '--format='
  if type == :md5
    cmd << 'Raw-MD5'
  elsif type == :sha1
    cmd << 'Raw-SHA1'
  elsif type == :sha256
    cmd << 'Raw-SHA256'
  elsif type == :lm
    cmd << 'LM'
  elsif type == :ntlm
    cmd << 'NT'
  elsif type == :bcrypt
    cmd << 'bcrypt'
  elsif type == :scrypt
    say("<%= color('Cannot currently generate valid scrypt hashes!', RED) %>")
    cmd << 'scrypt'

    # A standard format for scrypt hashes would be nice
    temp = hash.split('$')
    temp[3] = Base64.encode64([temp[3]].pack('H*')).strip
    temp[4] = Base64.encode64([temp[4]].pack('H*')).strip
    hash = "$ScryptKDF.pm$#{temp.join('*')}"
  end

  if method == :wordlist
    cmd << " --wordlist=#{wordlist} "
  elsif method == :bruteforce
    cmd << " --incremental=#{charset} "
  end

  cmd << "hash_#{tool}_#{type}_#{method}.txt"
elsif tool == :hashcat
  cmd << '-m '
  if type == :md5
    cmd << '0'
  elsif type == :sha1
    cmd << '100'
  elsif type == :sha256
    cmd << '1400'
  elsif type == :lm
    cmd << '3000'
  elsif type == :ntlm
    cmd << '1000'
  elsif type == :bcrypt
    say("<%= color('This cracking process is very resource intensive! Consider yourself warned.', YELLOW) %>")
    cmd << '3200'
  elsif type == :scrypt
    say("<%= color('Cannot currently generate valid scrypt hashes!', RED) %>")
    #say("<%= color('This cracking process is very resource intensive! Consider yourself warned.', YELLOW) %>")
    cmd << '8900'

    # Make hash format hashcat understands
    temp = hash.split('$')
    temp[3] = Base64.encode64([temp[3]].pack('H*')).strip
    temp[4] = Base64.encode64([temp[4]].pack('H*')).strip
    hash = "SCRYPT:#{temp.join(':')}"
  end

  cmd << " hash_#{tool}_#{type}_#{method}.txt"

  if method == :wordlist
    cmd << " #{wordlist}"
  elsif method == :bruteforce
    cmd << " -a 3 #{charpatt} --increment"
  end
end

# Write hash to file
File.write("hash_#{tool}_#{type}_#{method}.txt", hash)

puts ""
puts cmd
