class CreateTeamsInSeason < ActiveRecord::Migration
  def self.up
    create_table :teams_in_season do |t|
      t.string :picture
      t.string :logo
      t.references :team
      t.references :season
      t.references :contact_information
      
      t.timestamps
    end
  end

  def self.down
    drop_table :teams_in_season
  end
end
