class ContactInfos < ActiveRecord::Migration
  def self.up
    create_table :contact_infos do |t|
      t.string :phone_number_1
      t.string :phone_number_2
      t.string :phone_number_3
      t.string :address
      t.string :postal_code
      t.string :city
      t.string :country
      t.string :email
      t.string :facebook
      t.string :homepage
      t.string :twitter

      t.timestamps
    end 

  end

  def self.down
    drop_table :contact_infos
  end
end
