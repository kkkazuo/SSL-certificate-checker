class CreateNotificationInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_infos do |t|
      t.time :notify_before, null: false
      t.references :domain, foreign_key: true
      t.references :slack_info, foreign_key: true
      t.timestamps
    end
  end
end
