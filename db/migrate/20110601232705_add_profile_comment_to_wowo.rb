class AddProfileCommentToWowo < ActiveRecord::Migration
  def self.up
    add_column :wowos, :profile_enabled, :boolean, :default => true
    add_column :wowos, :comments_enabled, :boolean, :default => true
  end

  def self.down
    remove_column :wowos, :profile_enabled
    remove_column :wowos, :comments_enabled
  end
end
