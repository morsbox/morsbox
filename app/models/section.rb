class Section < ActiveRecord::Base
  include R18n::Translated
  translations :name
  
  scope :enabled, where(:enabled=>true).order("show_order DESC",:created_at)
end
