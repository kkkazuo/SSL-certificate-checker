class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.datetime :expiration_date, null: false
      t.references :domain, foreign_key: true

      t.timestamps
    end
  end
end
