class Project < ActiveRecord::Base
  include R18n::Translated
  translations :name
  
  validates :name_ru, :presence => true
  belongs_to :section
  has_many :descriptions, :dependent => :destroy
  
  scope :sorted, order(:show_order, "created_at DESC")
  scope :enabled, where(:enabled=>true).sorted
end
