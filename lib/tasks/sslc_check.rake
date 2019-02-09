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

  desc 'notify slack from notification record'
  task notify: :environment do
    notifier = Slack::Notifier.new ENV['SLACKHOST'], username: 'sslc-notification'
    notifications = Notification.all
    notifications.each do |notification|
      expiration_date = notification.expiration_date.strftime('%Y-%m-%d %H:%M')
      created_at      = notification.created_at.strftime('%Y-%m-%d %H:%M')
      domain          = notification.domain.fqdn
      message         = "'#{domain}' will expire at #{expiration_date}. This notification was created at #{created_at}"
      Notification.transaction do
        notifier.ping message
        notification.domain.checking_logs.create!(expiration_date: notification.expiration_date, notification: Time.now)
        notification.destroy!
      end
    end
    notifier.ping "Finish #{notifications.count} notifications!"
  end
end
