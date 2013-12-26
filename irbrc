require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY]  = 10000
IRB.conf[:HISTORY_FILE]  = "#{ENV['HOME']}/.irb-history"
IRB.conf[:AUTO_INDENT]   = true
IRB.conf[:PROMPT_MODE]   = :SIMPLE
IRB.conf[:LOAD_MODULES] |= %w(irb/completion)
