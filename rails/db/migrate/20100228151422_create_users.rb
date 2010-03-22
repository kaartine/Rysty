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
  end

  def self.down
    drop_table :users
  end
end