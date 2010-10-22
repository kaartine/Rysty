class Events < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.references :users # organizer
      t.text :description
      t.datetime :date

      t.timestamps
    end
    
  end

  def self.down
    drop_table :events
  end
end
