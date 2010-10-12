class Teams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.references :contact_info, :club
      t.boolean :public_profile
      t.string :short_name, :limit => 6
      t.string :name
      t.integer :season, :limit => 4 #1900

      t.timestamps
    end
    
  end

  def self.down
    drop_table :teams
  end
end
