class CreateContactInformations < ActiveRecord::Migration
  def self.up
    create_table :contact_informations do |t|
      t.string :phone_number
      t.string :address
      t.string :postal_code
      t.string :city
      t.string :country
      t.text :description
      t.string :email

      t.timestamps
    end
    
#    add_column :people, :contact_information, :references
#    add_column :club, :contact_information, :references
#    drop_column :people, :contact_information
#    drop_column :club, :contact_information
  end

  def self.down
    drop_table :contact_informations
    
  end
end
