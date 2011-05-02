class CreateWowos < ActiveRecord::Migration
  def self.up
    create_table :wowos do |t|
      t.string :name, :limit => 256, :null => false
      t.string :url, :limit => 128, :null => false
      t.string :guid, :limit => 128, :null => false
      t.references :theme
      t.references :user
      t.boolean :published, :null => false

      t.timestamps
    end
    add_index :wowos, :name
    add_index :wowos, :url,                 :unique => true
    add_index :wowos, :guid,                :unique => true
    add_index :wowos, :published,           :unique => false
    add_index :wowos, :user_id    
  end

  def self.down
    drop_table :wowos
  end
end
