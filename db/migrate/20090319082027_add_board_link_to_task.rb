class AddBoardLinkToTask < ActiveRecord::Migration
  def self.up
    change_table :tasks do |t|
      t.references :board
    end
    add_column :tasks, :status, :integer
  end

  def self.down
    
    remove_column :tasks, :status
    remove_column :tasks, :board_id 
  end
end
