class Participants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.belongs_to :user, :event
      t.text :description
      t.boolean :participating
      t.string :message

      t.timestamps
    end
    
  end

  def self.down
    drop_table :participants
  end
end
