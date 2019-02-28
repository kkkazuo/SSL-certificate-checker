require 'net/http'

namespace :sslc do
  desc 'check SSL certificate expiration date and save checking records'
  task check: :environment do
    Domain.all.each do |domain|
      uri = URI::HTTPS.build(host: domain.fqdn)
      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => true)
      expiration_date = response.peer_cert.not_after
      CheckingLog.transaction do
        domain.notifications.create!(expiration_date: expiration_date) if (Time.now + 3.month) > expiration_date
        domain.checking_logs.create!
      end
    end
  end

  desc 'notify slack from notification record'
  task notify: :environment do
    notifier = Slack::Notifier.new ENV['SLACKHOST'], username: 'sslc-notification'
    notifications = Notification.not_notified
    count = notifications.count
    notifications.each do |notification|
      expiration_date = notification.expiration_date.strftime('%Y-%m-%d %H:%M')
      created_at      = notification.created_at.strftime('%Y-%m-%d %H:%M')
      domain          = notification.domain.fqdn
      message         = "'#{domain} ( #{notification.certificate_type} )' will expire at #{expiration_date}. This notification was created at #{created_at}"
      Notification.transaction do
        notifier.ping message
        notification.update!(status: :notified, notified_at: Time.now)
      end
    end
    notifier.ping "********** Finish #{count} notifications! **********"
  end
end
