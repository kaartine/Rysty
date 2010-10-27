class ContestAdmins < ActiveRecord::Migration
  def self.up
    create_table :contest_admins do |t|
      t.belongs_to :user
      t.datetime :valid_until
      t.references :contest

      t.timestamps
    end
  
  end

  def self.down
    drop_table :contest_admins
  end
end
