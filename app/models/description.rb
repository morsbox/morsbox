class Description < ActiveRecord::Base
  include R18n::Translated
  translations :text
  
  has_attached_file :image, :styles => { :thumb => "100x100>" }
  
  belongs_to :project
  
  scope :ordered, order(:show_order, "created_at DESC")
  scope :enabled, where(:enabled=>true).ordered
end
