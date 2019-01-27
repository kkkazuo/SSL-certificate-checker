class CreateSlackInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :slack_infos do |t|
      t.string :name
      t.string :webhook_url, null: false
      t.string :username
      t.string :encrypted_token

      t.timestamps
    end
  end
end
