class Leagues < ActiveRecord::Migration
  def self.up
    create_table :leagues do |t|
      t.references :contact_info
      t.string :name
      t.string :short_name, :limit => 8

      t.timestamps
    end
    
  end

  def self.down
    drop_table :leagues
  end
end
