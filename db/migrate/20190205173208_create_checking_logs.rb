class CreateCheckingLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :checking_logs do |t|
      t.datetime :expiration_date, null: false
      t.datetime :notification
      t.references :domain, foreign_key: true

      t.timestamps
    end
  end
end
