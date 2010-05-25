class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.integer :height
      t.integer :weight
      t.text :description
      t.string :nick_name

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
