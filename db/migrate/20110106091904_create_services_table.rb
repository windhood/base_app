class CreateServicesTable < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :type
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :access_token
      t.string :access_secret
      t.string :nickname
      t.timestamps
    end
    add_index :services, :user_id
  end

  def self.down
    drop_table :services
  end
end
