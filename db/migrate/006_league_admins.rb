class LeagueAdmins < ActiveRecord::Migration
  def self.up
    create_table :league_admins do |t|
      t.belongs_to :user
      t.datetime :valid_until
      t.references :club

      t.timestamps
    end
  
    LeagueAdmin.create :user_id => 2
  end

  def self.down
    drop_table :league_admins
  end
end
