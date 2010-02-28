class CreatePlayerStatistics < ActiveRecord::Migration
  def self.up
    create_table :player_statistics do |t|
      t.integer :plusminus
      t.integer :number
      t.boolean :captain
      t.boolean :assistant_captain
      t.boolean :goalie
      t.time :game_time
      t.integer :saved_shots
      t.integer :goals_against
      t.references :player
      t.references :game

      t.timestamps
    end
  end

  def self.down
    drop_table :player_statistics
  end
end
