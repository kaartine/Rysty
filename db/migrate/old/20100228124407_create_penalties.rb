class CreatePenalties < ActiveRecord::Migration
  def self.up
    create_table :penalties do |t|
      t.time :time
      t.integer :reason
      t.integer :minutes
      t.time :end_time
      
      t.timestamps
    end
  end

  def self.down
    drop_table :penalties
  end
end
