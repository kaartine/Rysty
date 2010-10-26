class ClubAdmins < ActiveRecord::Migration
  def self.up
    create_table :club_admins do |t|
      t.belongs_to :user
      t.datetime :valid_until
      t.references :club
      t.timestamps
    end
  
  end

  def self.down
    drop_table :club_admins
  end
end
