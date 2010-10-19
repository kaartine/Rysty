class Users < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.integer :height
      t.integer :weight
      t.string :username #that is shown to others
      t.boolean :public_profile, :default => false
      t.string :password, :limit => 50
      t.string :salt, :limit => 50
      t.references :contact_info

      t.timestamps
    end
  
  end

  def self.down
    drop_table :users
  end
end
