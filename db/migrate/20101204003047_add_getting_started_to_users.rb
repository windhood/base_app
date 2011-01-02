class AddGettingStartedToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :getting_started, :boolean, :default => true
  end

  def self.down
    remove_column :users, :getting_started
  end
end
