class DeviseCreateAdminUsers < ActiveRecord::Migration
  def self.up
    create_table(:admin_users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.string :username, :null => false

      t.timestamps
    end

    # Create a default admin user
    AdminUser.create!(:email => 'admin@windhood.com', 
                      :password => 'start123', 
                      :password_confirmation => 'start123', 
                      :username => 'admin')

    add_index :admin_users, :email,                :unique => true
    add_index :admin_users, :reset_password_token, :unique => true
    add_index :admin_users, :username,             :unique => true
    # add_index :admin_users, :confirmation_token,   :unique => true
    # add_index :admin_users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :admin_users
  end
end