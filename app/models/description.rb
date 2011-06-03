class Description < ActiveRecord::Base
  include R18n::Translated
  translations :text
  
  has_attached_file :image
  
  belongs_to :project
end
