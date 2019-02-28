class RemoveNotificationFromCheckingLogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :checking_logs, :notification, :datetime
  end
end
