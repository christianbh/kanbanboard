class Task < ActiveRecord::Base
  validates_presence_of :name, :description
  belongs_to :board
end
