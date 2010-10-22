class CreateHalls < ActiveRecord::Migration
  def self.up
    create_table :halls do |t|
      t.string :name
      t.text :description
      t.integer :number_of_fields
      t.references :contact_information
      
      t.timestamps
    end
  end

  def self.down
    drop_table :halls
  end
end
