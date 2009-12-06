class AddLimitsToBoard < ActiveRecord::Migration
  def self.up
    add_column :boards, :max_tasks, :integer, :default => 12
    add_column :boards, :max_projects, :integer, :default => 6
  end

  def self.down
    remove_column :boards, :max_projects
    remove_column :boards, :max_tasks
  end
end
