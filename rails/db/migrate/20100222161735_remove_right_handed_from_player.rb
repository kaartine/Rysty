class RemoveRightHandedFromPlayer < ActiveRecord::Migration
  def self.up
    remove_column :players, :right_handed
  end

  def self.down
    add_column :players, :right_handed, :boolean
  end
end
