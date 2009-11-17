class AddConsequenceToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :consequence, :string
  end

  def self.down
    remove_column :tasks, :consequence
  end
end
