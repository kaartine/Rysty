class Leagues < ActiveRecord::Migration
  def self.up
    create_table :event_teams do |t|
      t.references :contact_info
      t.string :name
      t.string :short_name, :limit => 6

      t.timestamps
    end
    
  end

  def self.down
    drop_table :event_teams
  end
end
