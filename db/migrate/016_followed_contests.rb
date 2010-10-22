class FollowedContests < ActiveRecord::Migration
  def self.up
    create_table :followed_contests do |t|
      t.references :contest, :user

      t.timestamps
    end
    
  end

  def self.down
    drop_table :followed_contests
  end
end
