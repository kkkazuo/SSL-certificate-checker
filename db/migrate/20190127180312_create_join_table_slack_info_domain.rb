class CreateJoinTableSlackInfoDomain < ActiveRecord::Migration[5.2]
  def change
    create_join_table :slack_infos, :domains do |t|
      t.index [:slack_info_id, :domain_id]
    end
  end
end
