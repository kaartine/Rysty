class FollowedContests < ActiveRecord::Migration
  def self.up
    create_table :followed_contests do |t|
      t.references :contest, :user

      t.timestamps
    end
    
    add_index :followed_contests, [:user_id, :contest_id], :unique => true
  end

  def self.down
    remove_index :followed_contests
    drop_table :followed_contests
  end
end
