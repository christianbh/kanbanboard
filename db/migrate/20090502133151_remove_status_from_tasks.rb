class RemoveStatusFromTasks < ActiveRecord::Migration
  def self.up
    remove_column :tasks, :status
  end

  def self.down
    add_column :tasks, :status
  end
end
