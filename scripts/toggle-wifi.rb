#!/home/rotsen/.rubies/ruby-2.6.8/bin/ruby

require 'json'
secrets = JSON.parse(File.read(ENV['HOME'] + '/.dotfiles/secrets.json'))['toggle-wifi.rb']
require '/home/rotsen/.gem/ruby/2.6.8/gems/mtik-4.1.2/lib/mtik'

mktik = MTik::Connection.new(host: secrets['host'], user: secrets['user'], pass: secrets['pass'], unencrypted_plaintext: true)

command = mktik.get_reply("/caps-man/interface/print")[0]['disabled'] == 'true' ? 'enable' : 'disable'

mktik.get_reply("/caps-man/interface/#{command}", "=numbers=0")
mktik.get_reply("/caps-man/interface/#{command}", "=numbers=1")
