class ChangeNewsToHeadlines < ActiveRecord::Migration
  def self.up
    rename_table :news, :head_lines
  end

  def self.down
    rename_table :head_lines, :news
  end
end
