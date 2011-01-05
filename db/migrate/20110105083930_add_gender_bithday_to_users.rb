class AddGenderBithdayToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :birthday, :date
    add_column :users, :gender, :string
    add_column :users, :searchable, :boolean, :default => true
  end

  def self.down
    remove_column :users, :birthday
    remove_column :users, :gender
    remove_column :users, :searchable
  end
end
