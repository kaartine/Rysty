class LeagueAdmins < ActiveRecord::Migration
  def self.up
    create_table :league_admins do |t|
      t.belongs_to :user
      t.datetime :valid_until
      t.references :league

      t.timestamps
    end
  
  end

  def self.down
    drop_table :league_admins
  end
end
