class RemoveExpirationDateFromCheckingLogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :checking_logs, :expiration_date, :datetime
  end
end
