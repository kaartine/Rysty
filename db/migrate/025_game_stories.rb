class GameStories < ActiveRecord::Migration
  def self.up
    create_table :game_stories do |t|
      t.references :game, :user
      t.text :story

      t.timestamps
    end
    
  end

  def self.down
    drop_table :game_stories
  end
end
