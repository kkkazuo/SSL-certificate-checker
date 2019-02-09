require 'net/http'

namespace :sslc do
  desc 'check SSL certificate expiration date and save checking records'
  task check: :environment do
    Domain.all.each do |domain|
      uri = URI::HTTPS.build(host: domain.fqdn)
      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => true)
      expiration_date = response.peer_cert.not_after
      if (Time.now + 3.month) > expiration_date
        domain.notifications.create!(expiration_date: expiration_date)
      else
        domain.checking_logs.create!(expiration_date: expiration_date)
      end
    end
  end
end
