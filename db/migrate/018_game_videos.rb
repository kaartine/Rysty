class GameVideos < ActiveRecord::Migration
  def self.up
    create_table :game_videos do |t|
      t.references :game, :user
      t.text :description
      t.string :url

      t.timestamps
    end
    
  end

  def self.down
    drop_table :game_videos
  end
end
