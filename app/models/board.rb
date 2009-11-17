class Board < ActiveRecord::Base
  has_many :tasks
  
  def find_by_state_and_project(state, project)
    tasks.find(:all, :conditions => ["state = ? and project = ?", state, project ])
  end
end
