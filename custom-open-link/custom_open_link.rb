#!/home/rotsen/.rubies/ruby-3.3.5/bin/ruby

puts "lala"

require 'yaml'

CONFIG = YAML.load(
  File.read(ENV['HOME'] + '/.dotfiles/custom-open-link/config.yml'),
  permitted_classes: [Regexp]
)

# Log to journal
def log(string)
  `echo '#{string}' >> /tmp/custom-open-link`
  `echo '#{string}' | systemd-cat -t custom-open-link`
end

def drop_params(url)
  clean = url.split('?').first

  clean || url
end

def open(url)
  command = command_for(url)

  log("Opening with #{command} #{url}")
  `#{command} "#{url}"`
end

def filter_url(url)
  case url
  when *CONFIG['drop_params'] then drop_params(url)
  else
    url
  end
end

def command_for(url)
  log("Command for: #{url}")

  if CONFIG['trusted_domains']&.any? { |d| d.match?(url) }
    return CONFIG['default']
  end

  if (cd = CONFIG['custom_domains'])&.any?
    cd.each do |cmd, domains|
      log("#{cmd} for #{domains}")
      return cmd if domains.any? { |d| d.match?(url) }
    end
  end

  CONFIG['private']
end

begin
  url = filter_url(ARGV[0])

  open url
rescue ::Exception => e
  `echo '#{e}' >> /tmp/custom-open-link`
end
