require 'irb/ext/save-history'
require 'irb/completion'
require "#{ENV['HOME']}/.irbrc_color"

IRB.conf[:SAVE_HISTORY]  = 10000
IRB.conf[:HISTORY_FILE]  = "#{ENV['HOME']}/.irb-history"
IRB.conf[:AUTO_INDENT]   = true
IRB.conf[:PROMPT_MODE] = :CUSTOM

['interactive_editor', 'awesome_print'].each do |gem_name|
  begin
    require gem_name
  rescue
    puts "Install #{gem_name}"
  end
end


