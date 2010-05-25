class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.references :first_referee
      t.references :second_referee
      t.string :trustee1
      t.string :trustee2
      t.string :trustee3
      t.text :aob
      t.integer :num_of_spectators
      t.references :hall
      t.references :home_team
      t.references :guest_team
      t.references :serie
      t.references :event
      
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
