class AddValueToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :value, :string
  end

  def self.down
    remove_column :tasks, :value
  end
end
