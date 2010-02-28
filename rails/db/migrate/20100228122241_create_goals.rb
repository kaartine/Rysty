class CreateGoals < ActiveRecord::Migration
  def self.up
    create_table :goals do |t|
      t.time :time
      t.boolean :penalty_shot
      t.boolean :delayed_penalty
      t.boolean :missed_penalty
      t.boolean :en #empty net
      t.boolean :pp #power play
      t.boolean :sh #short handed
      t.boolean :equal #equal number of players in game
      t.references :scorer
      t.references :assister
      t.references :team
      
      t.timestamps
    end
  end

  def self.down
    drop_table :goals
  end
end
