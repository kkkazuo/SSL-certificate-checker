Rack::Attack.blocklist('block unless whitelist IPs when backdoor') do |request|
  whitelist = %w(127.0.0.1 ::1)
  ENV['MP_WHITELIST_IP'] && whitelist.append(*ENV['MP_WHITELIST_IP'].split(','))
  whitelist.exclude?(request.ip)
end