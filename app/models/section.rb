class Section < ActiveRecord::Base
  include R18n::Translated
  translations :name
  
  validates :name_ru, :presence => true
  has_many :projects
  
  scope :enabled, where(:enabled=>true).order("show_order DESC",:created_at)
end
