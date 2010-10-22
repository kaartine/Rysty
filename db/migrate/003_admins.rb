class Admins < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.references :user

      t.timestamps
    end
  
    Admin.create :user_id => 1
  end

  def self.down
    drop_table :admins
  end
end
