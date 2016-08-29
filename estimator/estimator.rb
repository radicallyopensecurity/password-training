#!/usr/bin/env ruby
require 'highline'
require 'humanize'
require 'terminal-table'

# Helper function to make times human readable
def runtime( seconds )
	if seconds > 31536000000 then "#{( seconds / 31536000000 ).floor.humanize.split( ',' )[ 0 ] } millennia"
	elsif seconds > 31536000 then "#{( seconds / 31536000 ).floor } years"
	elsif seconds > 86400    then "#{( seconds / 86400 ).floor } days"
	elsif seconds > 3600     then "#{( seconds / 3600 ).floor } hours"
	elsif seconds > 60       then "#{( seconds / 60 ).floor } minutes"
	else "#{ seconds } seconds" end
end

cli = HighLine.new

options = {}

# Get password to test
puts 'Enter password to test'
options[ :password ] = cli.ask( 'Password:  ' ) { |q| q.default = 'P4$$w0rd' }
puts ''

# Set parameters to determine cracking speed (Attempts/s)
options[ :online ] = {
	'Speeds' => {
		'100 mbit' => 14000,
		'1 gbit'   => 140000,
		'10 gbit'  => 1400000
	}
}

options[ :offline ] = {
	'Threat actor' => {
		"EC2 c4.2xlarge\nIntel Xeon E5-2660V3"   => { MD5: 449900000,       SHA1: 248200000,      SHA256: 93109500,       LM: 94441300,        NTLM: 764500000,       bcrypt: 2593,      scrypt: 24344 },
		"EC2 g2.2xlarge\nNvdia GRID K520"        => { MD5: 2317500000,      SHA1: 617600000,      SHA256: 292200000,      LM: 304400000,       NTLM: 3496300000,      bcrypt: 536,       scrypt: 51541 },
		"Casual attacker\nNvidia GTX970"         => { MD5: 10443100000,     SHA1: 3349800000,     SHA256: 1321800000,     LM: 1343700000,      NTLM: 21427800000,     bcrypt: 8984,      scrypt: 191900 },
		"Funded attacker\nNvidia GTX1080"        => { MD5: 200300000000,    SHA1: 68771000000,    SHA256: 23012100000,    LM: 148400000000,    NTLM: 334000000000,    bcrypt: 105700,    scrypt: 3493600 },
		"Large corporation\n10 x Nvidia GTX1080" => { MD5: 2003000000000,   SHA1: 687710000000,   SHA256: 230121000000,   LM: 1484000000000,   NTLM: 3340000000000,   bcrypt: 1057000,   scrypt: 34936000 },
		"Nation state\n1000 x Nvidia GTX1080"    => { MD5: 200300000000000, SHA1: 68771000000000, SHA256: 23012100000000, LM: 148400000000000, NTLM: 334000000000000, bcrypt: 105700000, scrypt: 3493600000 }
	}
}

options[ :rainbow ] = {}

# Determine password characteristics
options[ :length ] = options[ :password ].length

options[ :charsets ] = {
	:low   => false,
	:upp   => false,
	:num   => false,
	:spc   => false,
	:human => '',
	:size  => 0
}

options[ :password ].each_codepoint do |c|
	if c >= 48 and c <= 57
		options[ :charsets ][ :num ] = true
	elsif c >= 65 and c <= 90
		options[ :charsets ][ :upp ] = true
	elsif c >= 97 and c <= 122
		options[ :charsets ][ :low ] = true
	else
		options[ :charsets ][ :spc ] = true
	end
end

if options[ :charsets ][ :upp ]
	options[ :charsets ][ :human ].concat( 'uppercase ' )
	options[ :charsets ][ :size ] += 26
end
if options[ :charsets ][ :low ]
	options[ :charsets ][ :human ].concat( 'lowercase ' )
	options[ :charsets ][ :size ] += 26
end
if options[ :charsets ][ :num ]
	options[ :charsets ][ :human ].concat( 'numbers ' )
	options[ :charsets ][ :size ] += 10
end
if options[ :charsets ][ :spc ]
	options[ :charsets ][ :human ].concat( 'special ' )
	options[ :charsets ][ :size ] += 33
end
options[ :charsets ][ :human ].rstrip!
options[ :charsets ][ :options ] = options[ :charsets ][ :size ] ** options[ :length ]

# Show password properties
rows = []
rows << [ 'Password stats', '' ]
rows << :separator
rows << [ 'Password', options[ :password ] ]
rows << [ 'Length'  , options[ :length ] ]
rows << [ 'Charsets', options[ :charsets ][ :human ] ]
rows << [ 'Charset size', options[ :charsets ][ :size ] ]
rows << [ 'Possible passwords', options[ :charsets ][ :options ] ]
rows << [ '', "(#{ options[ :charsets ][ :options ].humanize.split( ',' )[ 0 ] })" ]
table = Terminal::Table.new :rows => rows
puts table
puts ''

# Estimate online cracking time
cli.say( "<%= color( \"Online cracking\", BOLD ) %>" )
rows = []
rows << [ 'Uplink speed', 'Average time needed' ]
rows << :separator
options[ :online ][ 'Speeds' ].each do | key, value |
rows << [ key, runtime( options[ :charsets ][ :options ] / value / 2 ) ]
end

table = Terminal::Table.new :rows => rows
puts table
puts ''

# Estimate online cracking time
cli.say( "<%= color( \"Offline cracking\", BOLD ) %>" )
rows = []
rows << [ 'Threat actor', 'Hashing algorithm', 'Average time needed' ]
rows << :separator
options[ :offline ][ 'Threat actor' ].each do | actor, hashes |
	rows << [ actor, '', '' ]
	hashes.each do | hash, attempts |
		if hash == :LM
			# Fix charset
			if options[ :charsets ][ :low ] == true and options[ :charsets ][ :upp ] == true
				s = options[ :charsets ][ :size ] - 26
			else
				s = options[ :charsets ][ :size ]
			end

			# LM hashes are 2 hashes of 7 chars max
			if options[ :length ] >= 14
				h1l = 7
				h2l = 7
			elsif options[ :length ] > 7
				h1l = 7
				h2l = options[ :length ] - 7
			elsif options[ :length ] <= 7
				h1l = options[ :length ]
				h2l = 0
			end

			# Calculate runtime per hash and sum
			h1t = s ** h1l
			h2t = s ** h2l
			ht = h1t + h2t

			rows << [ '', hash, runtime( ht / attempts / 2 ) ]
		else
			rows << [ '', hash, runtime( options[ :charsets ][ :options ] / attempts / 2 ) ]
		end
	end
end

table = Terminal::Table.new :rows => rows
puts table
puts ''

