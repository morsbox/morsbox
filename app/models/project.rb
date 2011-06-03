class Project < ActiveRecord::Base
  include R18n::Translated
  translations :name
  
  validates :name_ru, :presence => true
  belongs_to :section
end
