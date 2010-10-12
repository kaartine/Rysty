class AddStuffToTeams < ActiveRecord::Migration
  def self.up
    rename_table :teams, :clubs
    rename_column :clubs, :club, :description
        
    create_table :teams do |t|
        t.string :short_name
        t.string :long_name, :string
        t.string :email, :string
        t.string :home_town, :string
        t.references :stadium
        t.string :mascot, :string
        t.string :description, :string
        t.references :club
            
        t.timestamps
      end
  end

  def self.down
    drop_table :teams    

    rename_table :clubs, :teams
    rename_column :teams, :description, :club
  end
end
