class CreateDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :domains do |t|
      t.string :fqdn, null: false

      t.timestamps
    end
  end
end
