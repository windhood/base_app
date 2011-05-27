class CreateComponents < ActiveRecord::Migration
  def self.up
    create_table :components do |t|
      t.string :heading #text
      t.text :content  #text
      t.string :uri #link
      t.string :title #link
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :components
  end
end
