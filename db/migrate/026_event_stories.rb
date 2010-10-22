class EventStories < ActiveRecord::Migration
  def self.up
    create_table :event_stories do |t|
      t.references :event, :user
      t.text :story

      t.timestamps
    end
    
  end

  def self.down
    drop_table :event_stories
  end
end
