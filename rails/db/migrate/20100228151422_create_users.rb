class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :user_name
      t.string :password
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
