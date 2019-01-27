class CreateSlackChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :slack_channels do |t|
      t.string :channel
      t.references :slack_info, foreign_key: true

      t.timestamps
    end
  end
end
