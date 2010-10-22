class TeamMemberPhotos < ActiveRecord::Migration
  def self.up
    create_table :team_member_photos do |t|
      t.references :team_member, :user
      t.text :description
      t.string :url

      t.timestamps
    end
    
  end

  def self.down
    drop_table :team_member_photos
  end
end
