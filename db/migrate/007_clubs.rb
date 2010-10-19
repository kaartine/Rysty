class Clubs < ActiveRecord::Migration
  def self.up
    create_table :clubs do |t|
      t.references :contact_info
      t.string :name
      t.string :short_name, :limit => 8
      t.integer :founded_in_year
      t.string :logo_url

      t.timestamps
    end
    
  end

  def self.down
    drop_table :clubs
  end
end
