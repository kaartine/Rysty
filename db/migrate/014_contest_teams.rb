class ContestTeams < ActiveRecord::Migration
  def self.up
    create_table :contest_teams do |t|
      t.references :contest, :team

      t.timestamps
    end
    
  end

  def self.down
    drop_table :contest_teams
  end
end
