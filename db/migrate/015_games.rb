class Games < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.references :home_team, :class_name => "Team"
      t.references :guest_team, :class_name => "Team"
      t.references :contest

      t.timestamps
    end
    
  end

  def self.down
    drop_table :games
  end
end
