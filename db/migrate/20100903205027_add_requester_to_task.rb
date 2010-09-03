class AddRequesterToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :requester, :string
  end

  def self.down
    remove_column :tasks, :requester
  end
end
