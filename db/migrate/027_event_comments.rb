class EventComments < ActiveRecord::Migration
  def self.up
    create_table :event_comments do |t|
      t.references :event, :user
      t.text :comment

      t.timestamps
    end
    
  end

  def self.down
    drop_table :event_comments
  end
end
