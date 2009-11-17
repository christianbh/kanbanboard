class AddStateToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :state, :integer, :default => 0
  end

  def self.down
    remove_column :tasks, :state
  end
end
