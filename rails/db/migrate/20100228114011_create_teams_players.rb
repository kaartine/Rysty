class CreateTeamsPlayers < ActiveRecord::Migration
  def self.up
    create_table :teams_players do |t|
      t.integer :number
      t.string :position
      t.boolean :captain
      t.boolean :assistant_captain

      t.timestamps
    end
  end

  def self.down
    drop_table :teams_players
  end
end
