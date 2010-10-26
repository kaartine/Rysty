class EventTeams < ActiveRecord::Migration
  def self.up
    create_table :event_teams do |t|
      t.belongs_to :team, :event

      t.timestamps
    end
    
  end

  def self.down
    drop_table :event_teams
  end
end
