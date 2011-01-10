class AddDisableMailToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :disable_mail, :boolean, :default => false
  end

  def self.down
    remove_column :users, :disable_mail
  end
end
