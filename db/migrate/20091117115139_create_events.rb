class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.string :details
      t.date :start
      t.date :end
      t.boolean :span

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
