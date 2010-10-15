class ClubAdmins < ActiveRecord::Migration
  def self.up
    create_table :club_admins do |t|
      t.belongs_to :user
      t.datetime :valid_until
      t.references :club
      t.timestamps
    end
  
    ClubAdmin.create :user_id => 2
  end

  def self.down
    drop_table :club_admins
  end
end
