#!/home/rotsen/.rubies/ruby-3.3.5/bin/ruby
require 'uri'
require 'net/http'
require 'json'
require 'time'
# require 'awesome_print'

DOMAIN = "https://px1.tuyaus.com"
SESSION_URL = "#{DOMAIN}/homeassistant/auth.do"
SECRETS = JSON.parse(File.read(ENV['HOME'] + '/.dotfiles/secrets.json'))['toggle_lights.rb']

def new_session

  uri = URI(SESSION_URL)
  res = Net::HTTP.post_form(
    uri,
    userName: SECRETS['user'],
    password: SECRETS['pass'],
    countryCode: SECRETS['countryCode'],
    bizType: 'smart_life',
    from: 'tuya'
  )
  # ap res
  # ap res.body
  body = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)
end

def session
  @_session ||= begin
                  credentials = JSON.parse(File.read('/tmp/smartlife.cred')) rescue {}
                  expire_at   = Time.parse(credentials['expires_at']) rescue nil

                  if (expire_at.nil? || expire_at < Time.now)
                    credentials = new_session
                    credentials['expires_at'] = (Time.new + credentials['expires_in'])
                  end

                  File.open('/tmp/smartlife.cred', 'w') { |f| f.write credentials.to_json }

                  credentials['access_token']
                end
end

def change_switch(on)
  `echo "Turning #{on ? 'on' : 'off'} lights" | systemd-cat -p info -t toggle_lights`
  headers = { 'Content-Type': 'application/json' }
  header = {
    'name': 'turnOnOff',
    'namespace': 'control',
    'payloadVersion': 1,
  }
  payload = {
    value: (on ? '1' : '0'),
    accessToken: session,
    devId: SECRETS['deviceId']
  }

  data = {
    header: header,
    payload: payload
  }
  uri = URI("#{DOMAIN}/homeassistant/skill")
  res = Net::HTTP.post(uri, data.to_json, headers)
  # ap res
  # ap res.body
  # pp res.body
  # body = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)
end

@retries = 0

begin
  if ARGV.size > 0 && ARGV.last&.downcase == 'off'
    # puts "Apagando"
    change_switch(false) # turn off
  else
    # puts "prendiendo"
    change_switch(true) # turn on
  end
rescue => e
  @retries += 1
  if @retries < 3
    sleep 1
    retry
  else
    `echo "Error: #{e.message}" | systemd-cat -p err -t toggle_lights`
  end
end
