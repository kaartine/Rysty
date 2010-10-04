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
    
    Person.create :first_name => "admin",
      :last_name => "admin",
      :birthday => "18-06-1980"
  end

  def self.down
    drop_table :people
  end
end
