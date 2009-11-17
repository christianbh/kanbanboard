class AddProjectToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :project, :boolean, :default => false
  end

  def self.down
    remove_column :tasks, :project
  end
end
