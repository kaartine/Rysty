class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer :number
      t.string :stick
      t.boolean :right_handed
      t.string :position
      t.references :person

      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
