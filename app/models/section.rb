class Section < ActiveRecord::Base
  include R18n::Translated
  translations :name
  
  validates :name_ru, :presence => true
  has_many :projects, :dependent => :nullify
  
  scope :sorted, order(:show_order, "created_at DESC")
  scope :enabled, where(:enabled=>true).sorted
end
