class StaticBlock < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
end
