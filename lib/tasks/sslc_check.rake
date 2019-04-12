include OpenSSL

namespace :sslc do
  desc 'check SSL certificate expiration date and save checking records'
  task check: :environment do
    Domain.all.each do |domain|
      soc = TCPSocket.new(domain.fqdn, 443)
      ssl = SSL::SSLSocket.new(soc)
      ssl.connect
      certificates = ssl.peer_cert_chain
      root_cert_authority = certificates.last.issuer.to_a.find{ |arr| arr[0]=='CN' }[1]
      root_cert = OpenSSL::X509::Certificate.new(File.read("/etc/ssl/certs/#{root_cert_authority.gsub(' ', '_')}.pem"))
      CheckingLog.transaction do
        certificates.each_with_index do |c, i|
          expiration_time = c.not_after
          if expiration_time < (Time.now + 100.days)
            domain.notifications.create!(expiration_date: expiration_time) and next if i == 0
            domain.notifications.create!(certificate_type: :intermediate, expiration_date: expiration_time)
          end
        end
        root_exp = root_cert.not_after
        domain.notifications.create!(certificate_type: :root, expiration_date: root_exp) if root_exp < (Time.now + 3.month)
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
