class AddCertificateTypeToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :certificate_type, :integer, default: 0
  end
end
