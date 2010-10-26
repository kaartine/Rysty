class Games < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.references :home_team, :class_name => "Team"
      t.references :guest_team, :class_name => "Team"
      t.references :winner, :class_name => "Team"
      t.boolean :draw
      t.references :contest
      t.references :event
      t.integer :home_goals
      t.integer :guest_goals
      t.integer :spectators

      t.timestamps
    end
    
  end

  def self.down
    drop_table :games
  end
end
