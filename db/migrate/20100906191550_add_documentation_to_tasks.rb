class AddDocumentationToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :documentation, :string
  end

  def self.down
    remove_column :tasks, :documentation
  end
end
