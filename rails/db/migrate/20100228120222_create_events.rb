class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :place
      t.time :time
      t.date :date
      t.text :description
      t.references :participants
      t.references :oraganizer
      t.string :event_type
      
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
