# require 'rubygems'
require 'irb/ext/save-history'
require 'irb/completion'

IRB.conf[:SAVE_HISTORY]  = 10000
IRB.conf[:HISTORY_FILE]  = "#{ENV['HOME']}/.irb-history"
IRB.conf[:AUTO_INDENT]   = true

IRB.conf[:IRB_RC] = Proc.new do
  if defined?(Apartment::Tenant)
    account = Account.first
    account.switch!
    puts "Switched to #{account.name}"
  end
end

['interactive_editor', 'awesome_print'].each do |gem_name|
  begin
    require gem_name
    AwesomePrint.irb! if gem_name == 'awesome_print'
  rescue LoadError
    case gem_name
    when 'interactive_editor'
      $: << "/home/rotsen/.gem/ruby/#{RUBY_ENGINE_VERSION}/gems/interactive_editor-0.0.11/lib"
      require gem_name
    when 'awesome_print'
      $: << "/home/rotsen/.gem/ruby/#{RUBY_ENGINE_VERSION}/gems/awesome_print-1.8.0/lib"
      require gem_name
    end
  end
end
