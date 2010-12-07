class AddImageUrlToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :image_url, :string
    add_column :users, :image_url_medium, :string
    add_column :users, :image_url_small, :string
  end

  def self.down
    remove_column :users, :image_url_small
    remove_column :users, :image_url_medium
    remove_column :users, :image_url
  end
end
