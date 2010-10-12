class EventVideos < ActiveRecord::Migration
  def self.up
    create_table :event_videos do |t|
      t.references :event, :user
      t.text :description
      t.string :url
      
      t.timestamps
    end
    
  end

  def self.down
    drop_table :event_videos
  end
end
