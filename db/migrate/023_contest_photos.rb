class ContestPhotos < ActiveRecord::Migration
  def self.up
    create_table :contest_photos do |t|
      t.references :contest, :user
      t.text :description
      t.string :url

      t.timestamps
    end
    
  end

  def self.down
    drop_table :contest_photos
  end
end
