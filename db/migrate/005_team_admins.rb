class TeamAdmins < ActiveRecord::Migration
  def self.up
    create_table :team_admins do |t|
      t.belongs_to :user
      t.datetime :valid_until
      t.references :team
      
      t.timestamps
    end
  
  end

  def self.down
    drop_table :team_admins
  end
end
