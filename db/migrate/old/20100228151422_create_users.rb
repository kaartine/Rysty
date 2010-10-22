class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :password, :limit => 40
      t.string :salt, :limit => 40 
      t.references :person
      # rights
      t.boolean :admin
      t.boolean :add_edit_delete
      t.boolean :intranet

      t.timestamps
    end
  
    User.create :username => "admin",
      :password => "e0489cd5c151d95f52ce708a6158bb8c3d05b6fc",
      :salt => "1234",
      :admin => true,
      :person => 1,
      :add_edit_delete => true,
      :intranet => true 
      
  end

  def self.down
    drop_table :users
  end
end
