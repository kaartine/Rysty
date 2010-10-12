class Contests < ActiveRecord::Migration
  def self.up
    create_table :contests do |t|
      t.references :league
      t.string :name
      t.string :short_name, :limit => 6
      t.text :description
      t.boolean :public_profile, :default => true
      t.integer :season, :limit => 4
      t.integer :climing # for drawing place how many will be advancing
      t.integer :play_off_line # how many are going to play offs
      t.integer :demotion  # for drawing place how many will be dropping

      t.timestamps
    end
    
  end

  def self.down
    drop_table :contests
  end
end
