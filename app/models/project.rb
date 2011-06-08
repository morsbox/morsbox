class Project < ActiveRecord::Base
  include R18n::Translated
  translations :name
  
  validates :name_ru, :presence => true
  belongs_to :section
  has_many :descriptions
  
  scope :enabled, where(:enabled=>true).order(:show_order, :created_at)
end
