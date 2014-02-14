############### CUSTOM PROMPT ####################
COLORS = {
  RESET:      "\e[0m",
  BOLD:       "\e[1m",
  UNDERLINE:  "\e[4m",
  LGRAY:      "\e[0;37m",
  GRAY:       "\e[1;30m",
  RED:        "\e[31m",
  GREEN:      "\e[32m",
  YELLOW:     "\e[33m",
  BLUE:       "\e[34m",
  MAGENTA:    "\e[35m",
  CYAN:       "\e[36m",
  WHITE:      "\e[37m"
}

dir = File.basename(ENV['PWD'])
colored_dir =  COLORS[:GREEN] + dir + COLORS[:RESET]

branch = if system("git rev-parse --is-inside-work-tree > /dev/null 2>&1")
  `git branch | awk '/^\*/ { print $2 }'`.delete("\n")
else
  ''
end

if env = defined?(Rails) ? Rails.env[0..3] : nil
  env = (env == 'deve' ? ':dev' : ":#{env}")
end

colored_branch = COLORS[:CYAN] + branch + COLORS[:RESET]
prompt = "#{colored_dir}(#{colored_branch})#{env} %03n:%i→ "

IRB.conf[:PROMPT][:CUSTOM] = {
  PROMPT_I:     prompt,
  PROMPT_S:     prompt,
  PROMPT_C:     prompt,
  PROMPT_N:     prompt,
  RETURN:       "=>> %s\n"
}

