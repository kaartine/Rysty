class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.date :posted
      t.string :title
      t.text :content
      t.references :person

      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
