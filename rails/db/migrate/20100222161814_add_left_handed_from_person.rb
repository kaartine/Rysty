class AddLeftHandedFromPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :left_handed, :boolean
  end

  def self.down
    remove_column :people, :left_handed
  end
end
