# require 'rubygems'
# require 'irb/ext/save-history'
require 'irb/completion'

IRB.conf[:AUTO_INDENT]   = true
IRB.conf[:SAVE_HISTORY]  = 10000
IRB.conf[:USE_MULTILINE] = false

projects_dir = "#{ENV['HOME']}/git/"
history_dir  = if ENV['PWD'].include?(projects_dir)
                 proj_dir = ENV['PWD'].sub(projects_dir, '').split('/').first

                 "#{projects_dir}#{proj_dir}"
               else
                 ENV['HOME']
               end

IRB.conf[:HISTORY_FILE] = "#{history_dir}/.irb-history"

IRB.conf[:IRB_RC] = Proc.new do
  if defined?(Apartment::Tenant)
    if account = Account.find_by(tenant_name: 'arg')
      account.switch!
      puts "Switched to #{account&.name}"
    end
  end
rescue
end

def find_and_require_gem(gem_name)
  dir = `find $HOME/.gem/ruby/#{RUBY_ENGINE_VERSION}/gems/ -maxdepth 1 -type d -name '#{gem_name}*'`.split("\n").sort.last

  if dir == ''
    puts "MISSING GEM: #{gem_name}"
  else
    $: << "#{dir}/lib"
    require gem_name
  end
rescue LoadError
  puts "MISSING GEM: #{gem_name}"
end

['interactive_editor', 'amazing_print'].each do |gem_name|
  begin
    require gem_name
  rescue LoadError
    find_and_require_gem gem_name
  ensure
    AmazingPrint.irb! if gem_name == 'amazing_print' && defined?(AmazingPrint)
  end
end
